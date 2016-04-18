//
//  CHXKVOController.m
//  KVOController
//
//  Created by 王晨晓 on 16/4/13.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import "CHXKVOController.h"
#import "CHXKVOInfo.h"
#import <libkern/OSAtomic.h>
#import <objc/message.h>

@interface _CHXKVOSharedController : NSObject

@property (strong, nonatomic) NSHashTable<CHXKVOInfo *> *infos;
@property (assign, nonatomic) OSSpinLock lock;

+ (instancetype)sharedController;
- (void)observe:(id)object info:(nullable CHXKVOInfo *)info;
- (void)unobserve:(id)object info:(nullable CHXKVOInfo *)info;
- (void)unobserve:(id)object infos:(nullable NSSet *)infos;

@end

@implementation _CHXKVOSharedController
+ (instancetype)sharedController {
    static dispatch_once_t onceToken;
    static _CHXKVOSharedController *sharedController;
    dispatch_once(&onceToken, ^{
        sharedController = [[_CHXKVOSharedController alloc] init];
    });
    return sharedController;
}

- (instancetype)init {
    self = [super init];
    if (nil != self) {
        NSHashTable *infos = [NSHashTable alloc];
#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
        _infos = [infos initWithOptions:NSMapTableWeakMemory|NSMapTableObjectPointerPersonality capacity:0];
#elif defined(__MAC_OS_X_VERSION_MIN_REQUIRED)
        if ([NSHashTable respondsToSelector:@selector(weakObjectHashTable)]) {
            
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated declarations"
            _infos = [infos initWithOptions:NSPointerFunctionsZeroingWeakMemory|NSPointerFunctionsObjectPointerPersonality capacity:0];
#pragma clang diagnostic pop
        }
#endif
        _lock = OS_SPINLOCK_INIT;
    }
    return self;
}

- (NSString *)debugDescription {
    NSMutableString *s = [NSMutableString stringWithFormat:@"<%@:%p", NSStringFromClass([self class]), self];
    // lock
    OSSpinLockLock(&_lock);
    NSMutableArray *infoDescriptions = [NSMutableArray arrayWithCapacity:_infos.count];
    for (CHXKVOInfo *info in _infos) {
        [infoDescriptions addObject:info.debugDescription];
    }
    
    [s appendFormat:@" context:%@", infoDescriptions];
    // unlock
    OSSpinLockUnlock(&_lock);
    [s appendFormat:@">"];
    return s;
}

- (void)observe:(id)object info:(nullable CHXKVOInfo *)info {
    if (nil == info) {
        return;
    }
    
    OSSpinLockLock(&_lock);
    [_infos addObject:info];
    OSSpinLockUnlock(&_lock);
    
    [object addObserver:self forKeyPath:info.keyPath options:info.options context:info.context];
    if (info.state == CHXKVOInfoStateInitial) {
        info.state = CHXKVOInfoStateObserving;
    } else if (info.state == CHXKVOInfoStateNotObserving) {
        [object removeObserver:self forKeyPath:info.keyPath context:(void *)info];
    }
}

- (void)unobserve:(id)object info:(nullable CHXKVOInfo *)info {
    if (nil == info) {
        return;
    }
    
    // unregister info
    OSSpinLockLock(&_lock);
    [_infos removeObject:info];
    OSSpinLockUnlock(&_lock);
    
    if (info.state == CHXKVOInfoStateNotObserving) {
        [object removeObserver:self forKeyPath:info.keyPath context:(void *)info];
    }
    info.state = CHXKVOInfoStateNotObserving;
}

- (void)unobserve:(id)object infos:(nullable NSSet *)infos {
    if (0 == infos.count) {
        return;
    }
    
    // unregister info
    OSSpinLockLock(&_lock);
    for (CHXKVOInfo *info in infos) {
        [_infos removeObject:info];
    }
    OSSpinLockUnlock(&_lock);
    
    for (CHXKVOInfo *info in infos) {
        if (info.state == CHXKVOInfoStateObserving) {
            [object removeObserver:self forKeyPath:info.keyPath context:(void *)info];
        }
        info.state = CHXKVOInfoStateNotObserving;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {

    NSAssert(context, @"missing context keyPath:%@ object:%@ change:%@", keyPath, object, change);
    
    CHXKVOInfo *info;
    OSSpinLockLock(&_lock);
    info = [_infos member:(__bridge id)context];
    OSSpinLockUnlock(&_lock);
    
    if (nil != info) {
        CHXKVOController *controller = info.controller;
        if (nil != controller) {
            id observer = controller.observer;
            if (nil != observer) {
                if (info.block) {
                    info.block(observer, object, change);
                } else if (info.action) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                    [observer performSelector:info.action withObject:change withObject:object];
#pragma clang diagnostic pop
                }
            } else {
                [observer observeValueForKeyPath:keyPath ofObject:object change:change context:context];
            }
        }
    }
}

@end

@interface CHXKVOController ()

@property (nonatomic, strong) NSMapTable <id, NSMutableSet <CHXKVOInfo *>*>*objectInfosMap;
@property (nonatomic, assign) OSSpinLock lock;
@end

@implementation CHXKVOController

#pragma mark - Life Cycle
+ (instancetype)controllerWithObserver:(id)observer {
    return [[self alloc] initWithObserver:observer];
}

- (instancetype)initWithObserver:(id)observer retainObserved:(BOOL)retainObserved {
    if (self = [super init]) {
        _observer = observer;
        NSPointerFunctionsOptions keyOptions = retainObserved ? NSPointerFunctionsStrongMemory|NSPointerFunctionsObjectPointerPersonality : NSPointerFunctionsWeakMemory|NSPointerFunctionsObjectPointerPersonality;
        _objectInfosMap = [[NSMapTable alloc] initWithKeyOptions:keyOptions valueOptions:NSPointerFunctionsStrongMemory|NSPointerFunctionsObjectPersonality capacity:0];
        _lock = OS_SPINLOCK_INIT;
    }
    return self;
}

- (instancetype)initWithObserver:(id)observer {
    return [self initWithObserver:observer retainObserved:YES];
}

- (void)dealloc {
    [self unobserveAll];
}

#pragma mark - Debug Description
- (NSString *)debugDescription {
    NSMutableString *s = [NSMutableString stringWithFormat:@"<%@:%p", NSStringFromClass([self class]), self];
    [s appendFormat:@" observer:<%@:%p>", NSStringFromClass([_observer class]), _observer];
    OSSpinLockLock(&_lock);
    if (0 != _objectInfosMap.count) {
        [s appendString:@"\n "];
    }
    
    for (id object in _objectInfosMap) {
        NSMutableSet *infos = [_objectInfosMap objectForKey:object];
        NSMutableArray *infoDescriptions = [NSMutableArray arrayWithCapacity:infos.count];
        [infos enumerateObjectsUsingBlock:^(CHXKVOInfo *info, BOOL * _Nonnull stop) {
            [infoDescriptions addObject:info.debugDescription];
        }];
        [s appendFormat:@"%@ -> %@", object, infoDescriptions];
    }
    OSSpinLockUnlock(&_lock);
    
    [s appendString:@">"];
    return s;
}

#pragma mark - Utilities
- (void)_observe:(id)object info:(CHXKVOInfo *)info {
    OSSpinLockLock(&_lock);
    NSMutableSet *infos = [_objectInfosMap objectForKey:object];
    CHXKVOInfo *existingInfo = [infos member:info];
    if (nil != existingInfo) {
        OSSpinLockUnlock(&_lock);
        return;
    }
    
    if (nil == infos) {
        infos = [NSMutableSet set];
        [_objectInfosMap setObject:infos forKey:object];
    }
    
    [infos addObject:info];
    
    OSSpinLockUnlock(&_lock);
    
    [[_CHXKVOSharedController sharedController] observe:object info:info];
}

- (void)_unobserve:(id)object info:(CHXKVOInfo *)info {
    OSSpinLockLock(&_lock);
    NSMutableSet *infos = [_objectInfosMap objectForKey:object];
    CHXKVOInfo *registeredInfo = [infos member:info];
    if (nil != registeredInfo) {
        [infos removeObject:registeredInfo];
        if (0 == infos.count) {
            [_objectInfosMap removeObjectForKey:object];
        }
    }
    
    OSSpinLockUnlock(&_lock);
    [[_CHXKVOSharedController sharedController] unobserve:object info:info];
}

- (void)_unobserve:(id)object {
    OSSpinLockLock(&_lock);
    NSMutableSet *infos = [_objectInfosMap objectForKey:object];
    [_objectInfosMap removeObjectForKey:object];
    OSSpinLockUnlock(&_lock);
    [[_CHXKVOSharedController sharedController] unobserve:object infos:infos];
}

- (void)_unobserveAll {
    OSSpinLockLock(&_lock);
    NSMapTable *objectInfoMaps = [_objectInfosMap copy];
    [_objectInfosMap removeAllObjects];
    OSSpinLockUnlock(&_lock);
    
    _CHXKVOSharedController *sharedController = [_CHXKVOSharedController sharedController];
    for (id object in objectInfoMaps) {
        NSSet *infos = [objectInfoMaps objectForKey:object];
        [sharedController unobserve:object infos:infos];
    }
}

#pragma mark - API
- (void)observe:(nullable id)object keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options block:(CHXKVONotificationBlock)block {

}

- (void)observe:(nullable id)object keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options action:(SEL)action {

}

- (void)observe:(nullable id)object keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context {

}

- (void)observe:(nullable id)object keyPaths:(NSArray <NSString *>*)keyPaths options:(NSKeyValueObservingOptions)options block:(CHXKVONotificationBlock)block {

}

- (void)observe:(nullable id)object keyPaths:(NSArray <NSString *>*)keyPaths options:(NSKeyValueObservingOptions)options actions:(SEL)action {

}

- (void)observe:(nullable id)object keyPaths:(NSArray <NSString *>*)keyPaths options:(NSKeyValueObservingOptions)options context:(nullable void *)context {
    CHXKVOInfo *info = [CHXKVOInfo alloc];
}

- (void)unobserve:(nullable id)object keyPath:(NSString *)keyPath {

}

- (void)unobserve:(nullable id)object {
    if (nil == object) {
        return;
    }
    [self _unobserve:object];
}

- (void)unobserveAll {
    [self _unobserveAll];
}

@end

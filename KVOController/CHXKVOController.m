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
        
#pragma clang diagnostic pop
        }
#endif
    }
    return self;
}

@end

@implementation CHXKVOController

@end

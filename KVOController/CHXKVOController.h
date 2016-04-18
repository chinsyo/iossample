//
//  CHXKVOController.h
//  KVOController
//
//  Created by 王晨晓 on 16/4/13.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CHXKVOKeyPath(KEYPATH)\
@(((void)(NO && ((void)KEYPATH, No)),\
({ char *chxkvokeypath = strchr(#KEYPATH, '.'); NSCAssert(chxkvokeypath, @"Provided key path is invalid."); chxkeypath + 1;})))

#define CHXKVOClassKeyPath(CLASS, KEYPATH) \
@(((void)(NO && ((void)((CLASS *)(nil)).KEYPATH, NO)), #KEYPATH))

NS_ASSUME_NONNULL_BEGIN

typedef void (^CHXKVONotificationBlock)(id _Nullable observer, id object, NSDictionary<NSString *, id> *change);

@interface CHXKVOController : NSObject

@property (nullable, nonatomic, weak, readonly) id observer;

+ (instancetype)controllerWithObserver:(nullable id)observer;
- (instancetype)initWithObserver:(nullable id)observer retainObserved:(BOOL)retainObserved;
- (instancetype)initWithObserver:(nullable id)observer;

- (void)observe:(nullable id)object keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options block:(CHXKVONotificationBlock)block;
- (void)observe:(nullable id)object keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options action:(SEL)action;
- (void)observe:(nullable id)object keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;

- (void)observe:(nullable id)object keyPaths:(NSArray <NSString *>*)keyPaths options:(NSKeyValueObservingOptions)options block:(CHXKVONotificationBlock)block;
- (void)observe:(nullable id)object keyPaths:(NSArray <NSString *>*)keyPaths options:(NSKeyValueObservingOptions)options actions:(SEL)action;
- (void)observe:(nullable id)object keyPaths:(NSArray <NSString *>*)keyPaths options:(NSKeyValueObservingOptions)options context:(nullable void *)context;

- (void)unobserve:(nullable id)object keyPath:(NSString *)keyPath;
- (void)unobserve:(nullable id)object;
- (void)unobserveAll;
@end

NS_ASSUME_NONNULL_END

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

@end

NS_ASSUME_NONNULL_END

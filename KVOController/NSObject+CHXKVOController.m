//
//  NSObject+CHXKVOController.m
//  KVOController
//
//  Created by 王晨晓 on 16/4/13.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import "NSObject+CHXKVOController.h"
#import <libkern/OSAtomic.h>
#import <objc/message.h>

#if !__has_feature(objc_arc)
#error This file must be compiled with ARC. Convert you project to ARC or specify the -objc-arc flag.
#endif

#pragma mark - NSObject+CHXKVOController

NS_ASSUME_NONNULL_BEGIN

static void *NSObjectKVOControllerKey = &NSObjectKVOControllerKey;
static void *NSObjectKVOControllerNonRetainingKey = &NSObjectKVOControllerNonRetainingKey;

@implementation NSObject (CHXKVOController)

- (CHXKVOController *)KVOController {
    id controller = objc_getAssociatedObject(self, NSObjectKVOControllerKey);
    if (nil == controller) {
        controller = [[CHXKVOController alloc] init];
        self.KVOController = controller;
    }
    return controller;
}

- (void)setKVOController:(CHXKVOController *)KVOController {
    objc_setAssociatedObject(self, NSObjectKVOControllerKey, KVOController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CHXKVOController *)KVOControllerNonRetaining {
    id controller = objc_getAssociatedObject(self, NSObjectKVOControllerNonRetainingKey);
    if (nil == controller) {
        controller = [CHXKVOController new];
        self.KVOControllerNonRetaining = controller;
    }
    return controller;
}

- (void)setKVOControllerNonRetaining:(CHXKVOController *)KVOControllerNotRetaining {
    objc_setAssociatedObject(self, NSObjectKVOControllerNonRetainingKey, KVOControllerNotRetaining, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

NS_ASSUME_NONNULL_END
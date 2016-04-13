//
//  CHXKVOInfo.h
//  KVOController
//
//  Created by 王晨晓 on 16/4/13.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHXKVOController.h"

#pragma mark - Utilities
static NSString *describe_option(NSKeyValueObservingOptions option) {
    switch (option) {
        case NSKeyValueObservingOptionInitial:
            return @"NSKeyValueObservingOptionInitial";
            break;
        case NSKeyValueObservingOptionNew:
            return @"NSKeyValueObservingOptionNew";
            break;
        case NSKeyValueObservingOptionOld:
            return @"NSKeyValueObservingOptionOld";
            break;
        case NSKeyValueObservingOptionPrior:
            return @"NSKeyValueObservingOptionPrior";
            break;
        default:
            NSCAssert(NO, @"Unexpected option %tu", option);
            break;
    }
    return nil;
}

static void append_option_description(NSMutableString *s, NSUInteger option) {
    if (0 == s.length) {
        [s appendString:describe_option(option)];
    } else {
        [s appendString:@"|"];
        [s appendString:describe_option(option)];
    }
}

static NSUInteger enumerate_flags(NSUInteger *ptrFlags) {
    NSCAssert(ptrFlags, @"Expected prtFlags");
    if (!ptrFlags) {
        return 0;
    }
    
    NSUInteger flags = *ptrFlags;
    if (!flags) {
        return 0;
    }
    
    NSUInteger flag = 1 << __builtin_ctzl(flags);
    flags &= ~flag;
    *ptrFlags = flags;
    return flag;
}

static NSString *describe_options(NSKeyValueObservingOptions options) {
    NSMutableString *s = [NSMutableString string];
    NSUInteger option;
    while (0 != (option = enumerate_flags(&options))) {
        append_option_description(s, option);
    }
    return s;
}

#pragma mark - CHXKVOInfo

typedef NS_ENUM(uint8_t, CHXKVOInfoState) {
    CHXKVOInfoStateInitial = 0,
    CHXKVOInfoStateObserving,
    CHXKVOInfoStateNotObserving,
};

@interface CHXKVOInfo : NSObject
@property (weak, nonatomic) CHXKVOController *controller;
@property (copy, nonatomic) CHXKVONotificationBlock block;
@property (strong, nonatomic) NSString *keyPath;
@property (assign, nonatomic) NSKeyValueObservingOptions options;
@property (nonatomic) SEL action;
@property (nonatomic) void *context;
@property (nonatomic) CHXKVOInfoState state;
@end

//
//  UIViewControllerInterceptor.m
//  Log
//
//  Created by Chinsyo on 16/5/11.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

#import "UIViewControllerInterceptor.h"
#import <UIKit/UIKit.h>
#import <Aspects/Aspects.h>
#import "Logger.h"

@implementation UIViewControllerInterceptor
+ (void)load {
    [super load];
    [[self class] sharedInstance];
}

+ (instancetype)sharedInstance {
    static UIViewControllerInterceptor *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[UIViewControllerInterceptor alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        Logger *logger = [Logger sharedInstance];
        
        SEL appear = @selector(viewWillAppear:);
        [UIViewController aspect_hookSelector:appear withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
            NSTimeInterval t = 1.0;//[NSDate timeIntervalSinceReferenceDate];
            NSString *target = NSStringFromClass([[aspectInfo instance] class]);
            NSString *action = NSStringFromSelector(appear);
            [logger insertLogWithTime:t target:target action:action];
        } error:NULL];
        
        SEL disappear = @selector(viewWillDisappear:);
        [UIViewController aspect_hookSelector:disappear withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
            NSTimeInterval t = 1.0;//[NSDate timeIntervalSinceReferenceDate];
            NSString *target = NSStringFromClass([[aspectInfo instance] class]);
            NSString *action = NSStringFromSelector(disappear);
            [logger insertLogWithTime:t target:target action:action];
        } error:NULL];
    }
    return self;
}
@end

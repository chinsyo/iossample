//
//  CHXViewControllerInterceptor.m
//  Aspects
//
//  Created by 王晨晓 on 16/4/11.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import "CHXViewControllerInterceptor.h"
#import <Aspects/Aspects.h>
#import <UIKit/UIKit.h>

@implementation CHXViewControllerInterceptor
+ (void)load {
    [super load];
    [CHXViewControllerInterceptor sharedInstance];
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static CHXViewControllerInterceptor *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CHXViewControllerInterceptor alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
            NSLog(@"[%@ will appear!]", [aspectInfo instance]);
        } error:NULL];
    }
    return self;
}


@end

//
//  Clock.m
//  KVOController
//
//  Created by 王晨晓 on 16/4/19.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import "Clock.h"

@interface Clock ()

@property (strong, nonatomic) NSTimer *timer;
@end

@implementation Clock
+ (instancetype)clock {
    static Clock *clock;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        clock = [[Clock alloc] init];
    });
    return clock;
}

- (instancetype)init {
    if (self = [super init]) {
        [self _updateClock];
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(_updateClock) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)dealloc {
    if (nil != _timer) {
        [_timer invalidate];
    }
}

- (void)_updateClock {
    _date = [NSDate date];
}

@end

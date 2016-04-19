//
//  ClockViewController.m
//  KVOController
//
//  Created by 王晨晓 on 16/4/13.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import "ClockViewController.h"
#import "Clock.h"
#import "ClockView.h"

#define CLOCK_VIEW_MAX_COUNT 10
#define CLOCK_VIEW_TIME_DELAY 3.0
#define RANDOM_ENABLED 1

@interface ClockViewController ()
@property (strong, nonatomic) NSMutableArray *clockViews;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation ClockViewController

- (void)dealloc {
    if (nil != _timer) {
        [_timer invalidate];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    
    while (_clockViews.count < CLOCK_VIEW_MAX_COUNT) {
        [self _addClockView];
    }
    [self _scheduleTimer];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)_scheduleTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(_resetClockView) userInfo:nil repeats:YES];
}

- (void)_addClockView {
    if (!_clockViews) {
        _clockViews = [NSMutableArray array];
    }
    ClockView *clockView = [[ClockView alloc] initWithClock:[Clock clock] style:arc4random_uniform(ClockViewStyleDark + 1)];
    [_clockViews addObject:clockView];
    [self.view addSubview:clockView];
    
    clockView.bounds = CGRectMake(0, 0, 132, 132);
    CGRect contentBounds = self.view.bounds;
#if RANDOM_ENABLED
    clockView.center = CGPointMake(arc4random_uniform(contentBounds.size.width), arc4random_uniform(contentBounds.size.height));
#else
    clockView.center = CGPointMake(contentBounds.size.width/2.f, contentBounds.size.height/2.f);
#endif
}

- (void)_removeClockView {
    if (0 == _clockViews.count) {
        return;
    }
    [_clockViews[0] removeFromSuperview];
    [_clockViews removeObjectAtIndex:0];
}

- (void)_resetClockView {
    [self _removeClockView];
    [self _addClockView];
}

@end

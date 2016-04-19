//
//  ClockView.m
//  KVOController
//
//  Created by 王晨晓 on 16/4/19.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import "ClockView.h"
#import "ClockLayer.h"
#import "KVOController.h"

#define CLOCK_LAYER(VIEW) ((ClockLayer *)VIEW.layer)

static NSDictionary *layer_style(ClockViewStyle viewStyle) {
    NSDictionary *dict = nil;
    switch (viewStyle) {
        case ClockViewStyleLight:
            
            break;
            
        case ClockViewStyleDark:
            
            break;
    }
    return dict;
}

@interface ClockView ()

@property (strong, nonatomic) CHXKVOController *KVOController;

@end

@implementation ClockView

- (instancetype)initWithClock:(Clock *)clock style:(ClockViewStyle)style {
    if (self = [super init]) {
        CLOCK_LAYER(self).style = layer_style(style);
        _KVOController = [CHXKVOController controllerWithObserver:self];
        [_KVOController observe:clock keyPath:@"date" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew block:^(ClockView *clockView, Clock *clock, NSDictionary *change) {
            CLOCK_LAYER(clockView).date = change[NSKeyValueChangeNewKey];
        }];
    }
    return self;
}

@end

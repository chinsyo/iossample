//
//  ClockView.h
//  KVOController
//
//  Created by 王晨晓 on 16/4/19.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Clock;

typedef NS_ENUM(NSInteger, ClockViewStyle) {
    ClockViewStyleLight = 0,
    ClockViewStyleDark
};

@interface ClockView : UIView

- (instancetype)initWithClock:(Clock *)clock style:(ClockViewStyle)style;

@end

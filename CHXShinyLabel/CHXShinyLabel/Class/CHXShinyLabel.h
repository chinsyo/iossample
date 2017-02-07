//
//  CHXShinyLabel.h
//  CHXShinyLabel
//
//  Created by 王晨晓 on 16/3/16.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat kCHXShinyLabelAnimationDuration = 2.5f;

@interface CHXShinyLabel: UILabel

@property (assign, nonatomic, readwrite) CFTimeInterval shiningDuration;
@property (assign, nonatomic, readwrite) CFTimeInterval fadeOutDuration;
@property (assign, nonatomic, readwrite, getter = isAutoStart) BOOL autoStart;
@property (assign, nonatomic, readonly, getter = isShining) BOOL shining;
@property (assign, nonatomic, readonly, getter = isVisible) BOOL visible;

- (void)shine;
- (void)shineWithCompletion:(nullable void (^)())completion;
- (void)fadeOut;
- (void)fadeOutWithCompletion:(nullable void (^)())completion;

@end

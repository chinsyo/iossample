//
//  CHXUtilities.m
//  CHXPageController
//
//  Created by 王晨晓 on 16/4/21.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import "CHXUtilities.h"

const NSInteger UIViewDefaultZIndex = -1;

#pragma mark - UIView (CHXAutoLayout)
@implementation UIView (CHXAutoLayout)

#pragma mark - Public
- (void)addExpandSubview:(UIView *)subview {

}

- (void)addExpandSubview:(UIView *)subview edgeInsets:(UIEdgeInsets)insets {

}

- (void)addExpandSubview:(UIView *)subview edgeInsets:(UIEdgeInsets)insets atZIndex:(NSInteger)index {

}

- (void)addPinnedSubview:(UIView *)subview withHeight:(CGFloat)height {

}

#pragma mark - Internal
- (void)addSubview:(UIView *)view atZIndex:(NSInteger)index {

}

@end

#pragma mark - UIViewController (CHXPageController)
@implementation UIViewController (CHXPageController)

#pragma mark - Public
- (void)addToParentViewController:(UIViewController *)parentViewController {

}

- (void)addToParentViewController:(UIViewController *)parentViewController atZIndex:(NSInteger)index {

}

- (void)addToParentViewController:(UIViewController *)parentViewController withView:(UIView *)view {

}

#pragma mark - Internal
- (void)addToParentViewController:(UIViewController *)parentViewController withView:(UIView *)view atZIndex:(NSInteger)index {

}

@end
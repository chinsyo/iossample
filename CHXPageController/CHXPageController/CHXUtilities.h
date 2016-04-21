//
//  CHXUtilities.h
//  CHXPageController
//
//  Created by 王晨晓 on 16/4/21.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - UIView (CHXAutoLayout)
extern const NSInteger UIViewDefaultZIndex;

@interface UIView (CHXAutoLayout)

- (void)addExpandSubview:(UIView *)subview;
- (void)addExpandSubview:(UIView *)subview edgeInsets:(UIEdgeInsets)insets;
- (void)addExpandSubview:(UIView *)subview edgeInsets:(UIEdgeInsets)insets atZIndex:(NSInteger)index;
- (void)addPinnedSubview:(UIView *)subview withHeight:(CGFloat)height;
@end

#pragma mark - UIViewController (CHXPageController)
@interface UIViewController (CHXPageController)

- (void)addToParentViewController:(UIViewController *)parentViewController;
- (void)addToParentViewController:(UIViewController *)parentViewController atZIndex:(NSInteger)index;
- (void)addToParentViewController:(UIViewController *)parentViewController withView:(UIView *)view;
@end

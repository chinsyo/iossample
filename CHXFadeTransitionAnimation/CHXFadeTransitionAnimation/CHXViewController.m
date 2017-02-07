//
//  CHXViewController.m
//  CHXFadeTransitionAnimation
//
//  Created by 王晨晓 on 16/3/15.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import "CHXViewController.h"
#import "CHXFadeTransitionAnimation.h"

@interface CHXViewController () <UINavigationControllerDelegate>

@end

@implementation CHXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // CHXNavigationControllerDelegate *delegate = [[CHXNavigationControllerDelegate alloc] init];
    self.delegate = self;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    return [CHXFadeTransitionAnimation new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

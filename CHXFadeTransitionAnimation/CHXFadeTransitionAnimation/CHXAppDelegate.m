//
//  CHXAppDelegate.m
//  CHXFadeTransitionAnimation
//
//  Created by 王晨晓 on 16/3/15.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import "CHXAppDelegate.h"
#import "CHXViewController.h"
#import "FirstViewController.h"

@interface CHXAppDelegate ()

@end

@implementation CHXAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] init];
    self.window.backgroundColor = [UIColor orangeColor];
    FirstViewController *firstViewController = [FirstViewController new];
    self.window.rootViewController = [[CHXViewController alloc] initWithRootViewController:firstViewController];
    [self.window makeKeyAndVisible];
    return YES;
}

@end

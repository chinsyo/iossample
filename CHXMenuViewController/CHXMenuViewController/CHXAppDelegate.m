//
//  CHXAppDelegate.m
//  CHXMenuViewController
//
//  Created by 王晨晓 on 16/3/22.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import "CHXAppDelegate.h"
#import "CHXMenuViewController.h"

@interface CHXAppDelegate () <CHXMenuViewDelegate>

@end

@implementation CHXAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

#pragma mark - 
#pragma mark CHXMenuViewDelegate
- (void)menu:(CHXMenuViewController *)menu didSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"Menu did selected item at index %ld", index);
}

- (void)menuWillOpen {
    NSLog(@"Menu will open.");
}

- (void)menuDidOpen {
    NSLog(@"Menu did open.");
}

- (void)menuWillClose {
    NSLog(@"Menu will close.");
}

- (void)menuDidClose {
    NSLog(@"Menu did close.");
}

@end

//
//  AppDelegate.m
//  JSPatchDemo-OC
//
//  Created by 王晨晓 on 16/4/20.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import "AppDelegate.h"
#import "JPEngine.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [JPEngine startEngine];
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"js"];
    NSString *script = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
    [JPEngine evaluateScript:script];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ViewController *rootViewController = [[ViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    [[UINavigationBar appearance] setBackgroundImage:nil forBarMetrics:UIBarMetricsCompact];
    return YES;
}

@end

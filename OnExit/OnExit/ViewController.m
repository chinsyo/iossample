//
//  ViewController.m
//  OnExit
//
//  Created by 王晨晓 on 16/5/16.
//  Copyright © 2016年 chinsyo. All rights reserved.
//

#import "ViewController.h"

#define onExit\
    __strong void(^block)(void) __attribute__((cleanup(blockCleanUp), unused)) = ^

static void stringCleanUp(__strong NSString **string) {
    NSLog(@"%@", *string);
}

static void blockCleanUp(__strong void(^*block)(void)) {
    (*block)();
}

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __strong NSString *string __attribute__((__unused__, cleanup(stringCleanUp))) = @"CHX";
    onExit {
        NSLog(@"hello world");
    };
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

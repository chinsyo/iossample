//
//  AnotherViewController.m
//  LifeCycle
//
//  Created by Chinsyo on 16/5/4.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

#import "AnotherViewController.h"
#import "MyView.h"

#define MyLog NSLog(@"%@ %s", NSStringFromClass([self class]), __FUNCTION__);

@interface AnotherViewController ()

@end

@implementation AnotherViewController


- (void)loadView {
    [super loadView];
    MyLog
}

- (void)viewDidLoad {
    [super viewDidLoad];
    MyLog
    
    MyView *view = [[MyView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:view];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    MyLog
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    MyLog
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    MyLog
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    MyLog
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    MyLog
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    MyLog
}

- (void)dealloc {
    MyLog
}

@end

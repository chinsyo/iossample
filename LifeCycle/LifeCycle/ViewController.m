//
//  ViewController.m
//  LifeCycle
//
//  Created by Chinsyo on 16/5/4.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

#import "ViewController.h"
#import "AnotherViewController.h"

#define MyLog NSLog(@"%@ %s", NSStringFromClass([self class]), __FUNCTION__);

@interface ViewController ()

@end

@implementation ViewController

- (void)loadView {
    [super loadView];
    MyLog
}

- (void)viewDidLoad {
    [super viewDidLoad];
    MyLog
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 100, 100);
    button.center = self.view.center;
    [button setTitle:@"push" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)onClick:(id)sender {
    AnotherViewController *controller = [[AnotherViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
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

//
//  ViewController.m
//  Log
//
//  Created by Chinsyo on 16/5/11.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

#import "ViewController.h"
#import "Logger.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Show" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    [button setCenter:self.view.center];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)onClick:(UIButton *)button {
    Logger *logger = [Logger sharedInstance];
    [logger showLogs];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

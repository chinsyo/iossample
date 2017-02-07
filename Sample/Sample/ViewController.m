//
//  ViewController.m
//  Sample
//
//  Created by 王晨晓 on 16/5/16.
//  Copyright © 2016年 chinsyo. All rights reserved.
//

#import "ViewController.h"

extern NSString *const string;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", string);
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

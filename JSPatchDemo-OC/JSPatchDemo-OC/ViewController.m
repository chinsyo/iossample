//
//  ViewController.m
//  JSPatchDemo-OC
//
//  Created by 王晨晓 on 16/4/20.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 50)];
    [btn setTitle:@"Push TableViewController" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(handleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:btn];
}

- (void)handleBtn:(id)sender {

}

@end

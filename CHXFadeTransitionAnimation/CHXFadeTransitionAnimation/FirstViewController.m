//
//  FirstViewController.m
//  CHXFadeTransitionAnimation
//
//  Created by 王晨晓 on 16/3/15.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"

@interface FirstViewController ()
@property (strong, nonatomic) UIButton *button;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"First";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.button setTitle:@"Push" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(onPush:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillLayoutSubviews {
    self.button.backgroundColor = [UIColor orangeColor];
    self.button.frame = CGRectInset(self.view.bounds, 100, 300);
}

- (void)onPush:(UIButton *)sender {
    SecondViewController *secondViewController = [SecondViewController new];
    [self.navigationController pushViewController:secondViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

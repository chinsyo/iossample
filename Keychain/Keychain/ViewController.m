//
//  ViewController.m
//  Keychain
//
//  Created by Chinsyo on 16/5/2.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

#import "ViewController.h"
#import <SSKeychain/SSKeychain.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SSKeychain setPassword:@"1234" forService:@"qq" account:@"123456"];
    NSString *pwd = [SSKeychain passwordForService:@"qq" account:@"123456"];
    NSLog(@"%@", pwd);
    [SSKeychain setPassword:@"1234" forService:@"qq" account:@"qwerty"];
    
    NSArray *services = [SSKeychain accountsForService:@"qq"];
    NSLog(@"%@", services);
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

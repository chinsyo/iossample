
//
//  FRPLoginViewModel.m
//  FRP
//
//  Created by Chinsyo on 16/5/16.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

#import "FRPLoginViewModel.h"
#import "FRPPhotoImporter.h"

@interface FRPLoginViewModel ()

@property (nonatomic, strong) RACCommand *loginCommand;

@end

@implementation FRPLoginViewModel

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    @weakify(self);
    self.loginCommand = [[RACCommand alloc] initWithEnabled:[self validateLoginInputs] signalBlock:^RACSignal *(id input) {
        @strongify(self);
        return [FRPPhotoImporter logInWithUsername:self.username password:self.password];
    }];
    return self;
}

#pragma mark - Private
- (RACSignal *)validateLoginInputs {
    return [RACSignal combineLatest:@[RACObserve(self, username), RACObserve(self, password)] reduce:^id(NSString *username, NSString *password) {
        return @(username.length > 0 && password.length > 0);
    }];
}

@end

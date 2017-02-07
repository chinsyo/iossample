//
//  FRPPhotoViewController.m
//  FRP
//
//  Created by Chinsyo on 16/5/16.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

#import "FRPPhotoViewController.h"

// Model
#import "FRPPhotoViewModel.h"

// Utilities
#import <SVProgressHUD.h>

@interface FRPPhotoViewController ()

@property (nonatomic, assign) NSInteger photoIndex;
@property (nonatomic, strong) FRPPhotoViewModel *viewModel;

@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation FRPPhotoViewController

- (instancetype)initWithViewModel:(FRPPhotoViewModel *)viewModel index:(NSInteger)photoIndex {
    self = [super init];
    if (!self) return nil;
    
    self.viewModel = viewModel;
    self.photoIndex = photoIndex;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    RAC(imageView, image) = RACObserve(self.viewModel, photoImage);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    self.imageView = imageView;
    
    [RACObserve(self.viewModel, loading) subscribeNext:^(NSNumber *loading) {
        if ([loading boolValue]) {
            [SVProgressHUD show];
        } else {
            [SVProgressHUD dismiss];
        }
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.viewModel.active = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.viewModel.active = NO;
}

@end

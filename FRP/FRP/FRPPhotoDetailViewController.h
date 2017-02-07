//
//  FRPPhotoDetailViewController.h
//  FRP
//
//  Created by Chinsyo on 16/5/16.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FRPPhotoDetailViewModel;

@interface FRPPhotoDetailViewController : UIViewController

@property (nonatomic, readonly) FRPPhotoDetailViewModel *viewModel;

- (instancetype)initWithViewModel:(FRPPhotoDetailViewModel *)viewModel;

@end

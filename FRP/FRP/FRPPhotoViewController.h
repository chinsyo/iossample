//
//  FRPPhotoViewController.h
//  FRP
//
//  Created by Chinsyo on 16/5/16.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FRPPhotoViewModel;

@interface FRPPhotoViewController : UIViewController

@property (nonatomic, readonly) FRPPhotoViewModel *viewModel;
@property (nonatomic, readonly) NSInteger photoIndex;

- (instancetype)initWithViewModel:(FRPPhotoViewModel *)viewModel index:(NSInteger)photoIndex;

@end

//
//  FRPPhotoViewModel.h
//  FRP
//
//  Created by Chinsyo on 16/5/16.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FRPPhotoModel;

@interface FRPPhotoViewModel : RVMViewModel

@property (nonatomic, readonly) FRPPhotoModel *model;
@property (nonatomic, readonly) UIImage *photoImage;
@property (nonatomic, readonly, getter=isLoading) BOOL loading;

- (instancetype)initWithModel:(FRPPhotoModel *)photoModel;
- (NSString *)photoName;

@end

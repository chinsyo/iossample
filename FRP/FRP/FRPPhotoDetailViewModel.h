//
//  FRPPhotoDetailViewModel.h
//  FRP
//
//  Created by Chinsyo on 16/5/16.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FRPPhotoModel;

@interface FRPPhotoDetailViewModel : RVMViewModel

@property (nonatomic, readonly) FRPPhotoModel *model;

@property (nonatomic, readonly) NSString *photoName;
@property (nonatomic, readonly) NSString *photoRating;
@property (nonatomic, readonly) NSString *photographerName;
@property (nonatomic, readonly) NSString *votePromptText;

@property (nonatomic, readonly) RACCommand *voteCommand;

@property (nonatomic, readonly) BOOL loggedIn;

- (instancetype)initWithModel:(FRPPhotoModel *)photoModel;

@end

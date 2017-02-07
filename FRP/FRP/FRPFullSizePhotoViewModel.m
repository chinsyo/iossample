//
//  FRPFullSizePhotoViewModel.m
//  FRP
//
//  Created by Chinsyo on 16/5/16.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

#import "FRPFullSizePhotoViewModel.h"

// Model
#import "FRPPhotoModel.h"

@interface FRPFullSizePhotoViewModel ()

@property (nonatomic, strong) NSArray *model;
@property (nonatomic, assign) NSInteger initialPhotoIndex;

@end

@implementation FRPFullSizePhotoViewModel

- (instancetype)initWithPhotoArray:(NSArray *)photoArray initialPhotoIndex:(NSInteger)initialPhotoIndex {
    self = [super init];
    if (!self) return nil;
    self.model = photoArray;
    self.initialPhotoIndex = initialPhotoIndex;
    return self;
}

- (NSString *)initialPhotoName {
    FRPPhotoModel *photoModel = [self initialPhotoModel];
    return [photoModel photoName];
}

- (FRPPhotoModel *)photoModelAtIndex:(NSInteger)index {
    if (index < 0 || index > self.model.count - 1) {
        return nil;
    } else {
        return self.model[index];
    }
}

#pragma mark - Private Methods
- (FRPPhotoModel *)initialPhotoModel {
    return [self photoModelAtIndex:self.initialPhotoIndex];
}

@end

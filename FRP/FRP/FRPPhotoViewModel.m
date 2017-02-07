//
//  FRPPhotoViewModel.m
//  FRP
//
//  Created by Chinsyo on 16/5/16.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

#import "FRPPhotoViewModel.h"

// Utilities
#import "FRPPhotoImporter.h"
#import "FRPPhotoModel.h"

@interface FRPPhotoViewModel ()

@property (nonatomic, strong) UIImage *photoImage;
@property (nonatomic, assign, getter=isLoading) BOOL loading;

@end

@implementation FRPPhotoViewModel

- (instancetype)initWithModel:(FRPPhotoModel *)photoModel {
    self = [super init];
    if (!self) return nil;
    
    @weakify(self);
    [self.didBecomeActiveSignal subscribeNext:^(id x) {
        @strongify(self);
        [self downloadPhotoModelDetails];
    }];
    
    RAC(self, photoImage) = [RACObserve(self.model, fullsizedData) map:^id(id value) {
        return [UIImage imageWithData:value];
    }];
    
    return self;
}

#pragma mark - Public
- (NSString *)photoName {
    return self.model.photoName;
}

#pragma mark - Private
- (void)downloadPhotoModelDetails {
    self.loading = YES;
    
    @weakify(self);
    [[FRPPhotoImporter fetchPhotoDetails:self.model] subscribeError:^(NSError *error) {
        NSLog(@"Could not fetch photo details: %@", error);
    } completed:^{
        @strongify(self);
        self.loading = NO;
        NSLog(@"Fetched photo details.");
    }];
}

@end

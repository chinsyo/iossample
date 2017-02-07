//
//  FRPCell.m
//  FRP
//
//  Created by Chinsyo on 16/5/16.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

#import "FRPCell.h"
#import "FRPPhotoModel.h"
#import <NSData+AFDecompression.h>

@interface FRPCell ()
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation FRPCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = [UIColor darkGrayColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.contentView addSubview:imageView];
    
    RAC(self.imageView, image) = [[[RACObserve(self, photoModel.thumbnailData) ignore:nil] map:^id(id value) {
        return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [value af_decompressedImageFromJPEGDataWithCallback:^(UIImage *decompressedImage) {
                [subscriber sendNext:decompressedImage];
                [subscriber sendCompleted];
            }];
            return nil;
        }] subscribeOn:[RACScheduler scheduler]];
    }] switchToLatest];
    
    [self.rac_prepareForReuseSignal subscribeNext:^(id x) {
        self.imageView = nil;
    }];
    return self;
}

@end

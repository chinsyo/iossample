//
//  UIImage+CHXWatermark.h
//  CHXWatermark
//
//  Created by 王晨晓 on 16/4/27.
//  Copyright © 2016年 chinsyo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct {
    double dx;
    double dy;
} CGOffset;

CGOffset CGOffsetMake(double dx, double dy);

typedef enum {
    CGPositionDefault = 0,
    CGPositionHorizontalLeft    = 1 << 0,
    CGPositionHorizontalCenter  = 1 << 1,
    CGPositionHorizontalRight   = 1 << 2,
    CGPositionVerticalTop      = 1 << 3,
    CGPositionVerticalCenter    = 1 << 4,
    CGPositionVerticalBottom     = 1 << 5,
} CGPosition;

@interface UIImage (CHXWatermark)
// text watermark
+ (instancetype)imageWithUIImage:(UIImage *)image watermarkText:(NSAttributedString *)text;
+ (instancetype)imageWithUIImage:(UIImage *)image watermarkText:(NSAttributedString *)text atPosition:(CGPosition)position;
+ (instancetype)imageWithUIImage:(UIImage *)image watermarkText:(NSAttributedString *)text atPosition:(CGPosition)position withOffset:(CGOffset)offset;

- (instancetype)addWatermarkText:(NSAttributedString *)text;
- (instancetype)addWatermarkText:(NSAttributedString *)text atPosition:(CGPosition)position;
- (instancetype)addWatermarkText:(NSAttributedString *)text atPosition:(CGPosition)position withOffset:(CGOffset)offset;

// image watermark
+ (instancetype)imageWithUIImage:(UIImage *)image watermarkImage:(UIImage *)watermark;
+ (instancetype)imageWithUIImage:(UIImage *)image watermarkImage:(UIImage *)watermark atPosition:(CGPosition)position;
+ (instancetype)imageWithUIImage:(UIImage *)image watermarkImage:(UIImage *)watermark atPosition:(CGPosition)position withOffset:(CGOffset)offset;
- (instancetype)addWatermarkImage:(UIImage *)image;
- (instancetype)addWatermarkImage:(UIImage *)image atPosition:(CGPosition)position;
- (instancetype)addWatermarkImage:(UIImage *)image atPosition:(CGPosition)position withOffset:(CGOffset)offset;
@end

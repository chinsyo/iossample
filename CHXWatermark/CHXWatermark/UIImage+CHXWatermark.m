//
//  UIImage+CHXWatermark.m
//  CHXWatermark
//
//  Created by 王晨晓 on 16/4/27.
//  Copyright © 2016年 chinsyo. All rights reserved.
//

#import "UIImage+CHXWatermark.h"
#import "NSAttributedString+CHXWatermark.h"

CGOffset CGOffsetMake(double dx, double dy) {
    CGOffset insets;
    insets.dx = dx;
    insets.dy = dy;
    return insets;
}

static const CGFloat kCHXWatermarkDefaultMargin = 5.f;

@interface UIImage ()

@end

@implementation UIImage (CHXWatermark)
+ (instancetype)imageWithUIImage:(UIImage *)image watermarkText:(NSAttributedString *)text {
    return [UIImage imageWithUIImage:image watermarkText:text atPosition:CGPositionDefault];
}

+ (instancetype)imageWithUIImage:(UIImage *)image watermarkText:(NSAttributedString *)text atPosition:(CGPosition)position {
    return [UIImage imageWithUIImage:image watermarkText:text atPosition:position withOffset:CGOffsetMake(0, 0)];
}

+ (instancetype)imageWithUIImage:(UIImage *)image watermarkText:(NSAttributedString *)text atPosition:(CGPosition)position withOffset:(CGOffset)offset {
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    [image drawAtPoint:CGPointZero];
    
    CGSize textSize = text.textSize;
    CGPoint point = [UIImage pointWithImgeSize:image.size watermarkSize:textSize position:position offset:offset];
    [text drawAtPoint:point];
    
    UIImage *updatedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return updatedImage;
}

- (instancetype)addWatermarkText:(NSAttributedString *)text {
    return [UIImage imageWithUIImage:self watermarkText:text];
}

- (instancetype)addWatermarkText:(NSAttributedString *)text atPosition:(CGPosition)position {
    return [UIImage imageWithUIImage:self watermarkText:text atPosition:position];
}

- (instancetype)addWatermarkText:(NSAttributedString *)text atPosition:(CGPosition)position withOffset:(CGOffset)offset {
    return [UIImage imageWithUIImage:self watermarkText:text atPosition:position withOffset:offset];
}

+ (instancetype)imageWithUIImage:(UIImage *)image watermarkImage:(UIImage *)watermark {
    return [UIImage imageWithUIImage:image watermarkImage:watermark atPosition:CGPositionDefault];
}

+ (instancetype)imageWithUIImage:(UIImage *)image watermarkImage:(UIImage *)watermark atPosition:(CGPosition)position {
    return [UIImage imageWithUIImage:image watermarkImage:watermark atPosition:position withOffset:CGOffsetMake(0, 0)];
}

+ (instancetype)imageWithUIImage:(UIImage *)image watermarkImage:(UIImage *)watermark atPosition:(CGPosition)position withOffset:(CGOffset)offset {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    [image drawAtPoint:CGPointZero];
    
    CGPoint point = [UIImage pointWithImgeSize:image.size watermarkSize:watermark.size position:position offset:offset];
    [watermark drawAtPoint:point];
    
    UIImage *updatedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return updatedImage;
}

- (instancetype)addWatermarkImage:(UIImage *)image {
    return [UIImage imageWithUIImage:self watermarkImage:image];
}

- (instancetype)addWatermarkImage:(UIImage *)image atPosition:(CGPosition)position {
    return [UIImage imageWithUIImage:self watermarkImage:image atPosition:position];
}

- (instancetype)addWatermarkImage:(UIImage *)image atPosition:(CGPosition)position withOffset:(CGOffset)offset {
    return [UIImage imageWithUIImage:self watermarkImage:image atPosition:position withOffset:offset];
}

#pragma mark - Private
+ (CGPoint)pointWithImgeSize:(CGSize)imageSize watermarkSize:(CGSize)watermarkSize position:(CGPosition)position offset:(CGOffset)offset {
    
    CGFloat imageWidth = imageSize.width;
    CGFloat imageHeight = imageSize.height;
    CGFloat watermarkWidth = watermarkSize.width;
    CGFloat watermarkHeight = watermarkSize.height;
    
    int horizontalPosition = position & 0b111;
    int verticalPosition = (position >> 3) & 0b111;
    
    CGPoint point;
    switch (horizontalPosition) {
        case 0: point.x = (imageWidth - watermarkWidth) * 0.5; break;
        case 1: point.x = (imageWidth * 0.f) + kCHXWatermarkDefaultMargin; break;
        case 2: point.x = (imageWidth - watermarkWidth) * 0.5; break;
        case 4: point.x = (imageWidth - watermarkWidth) * 1.0 - kCHXWatermarkDefaultMargin; break;
        default:
            NSAssert(NO, @"Unexpected horizontal position!");
            break;
    }
    switch (verticalPosition) {
        case 0: point.y = (imageHeight - watermarkHeight) * 0.5; break;
        case 1: point.y = (imageHeight * 0.f) + kCHXWatermarkDefaultMargin; break;
        case 2: point.y = (imageHeight - watermarkHeight) * 0.5; break;
        case 4: point.y = (imageHeight - watermarkHeight) * 1.0  - kCHXWatermarkDefaultMargin; break;
        default:
            NSAssert(NO, @"Unexpected vertical position!");
            break;
    }
    point.x += offset.dx;
    point.y += offset.dy;
    return point;
}

@end

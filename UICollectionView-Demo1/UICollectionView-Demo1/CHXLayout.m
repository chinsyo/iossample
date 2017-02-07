//
//  CHXLayout.m
//  UICollectionView-Demo1
//
//  Created by 王晨晓 on 16/3/15.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import "CHXLayout.h"

static const CGFloat kCHXLayoutItemSize = 200.f;
static const CGFloat kCHXLayoutActiveDistance = 200.f;
static const CGFloat kCHXLayoutZoomFactor = 0.3f;

@implementation CHXLayout

- (instancetype)init {
    if (self = [super init]) {
        self.itemSize = CGSizeMake(kCHXLayoutItemSize, kCHXLayoutItemSize);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.sectionInset = UIEdgeInsetsMake(200, 0, 200, 0);
        self.minimumLineSpacing = 50.f;
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UICollectionViewLayoutAttributes *attributes = (UICollectionViewLayoutAttributes *)obj;
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
            CGFloat normalizedDistance = distance / kCHXLayoutActiveDistance;
            if (ABS(distance) < kCHXLayoutActiveDistance) {
                CGFloat zoom = 1 + kCHXLayoutZoomFactor * (1 - ABS(normalizedDistance));
                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.f);
                attributes.zIndex = 1.f;
            }
        }
    }];
    return array;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    CGFloat offsetAdjustment = MAXFLOAT;
    CGFloat horizontalCenter = proposedContentOffset.x + CGRectGetWidth(self.collectionView.bounds)/2.f;
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0,self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray *array = [super layoutAttributesForElementsInRect:targetRect];
    
    for (UICollectionViewLayoutAttributes* layoutAttributes in array) {
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment)) {
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}

@end

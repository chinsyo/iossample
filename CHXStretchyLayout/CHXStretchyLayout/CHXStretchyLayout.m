//
//  CHXStretchyLayout.m
//  CHXStretchyLayout
//
//  Created by 王晨晓 on 16/3/18.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import "CHXStretchyLayout.h"

@implementation CHXStretchyLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (UICollectionViewScrollDirection)scrollDirection {
    return UICollectionViewScrollDirectionVertical;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    UIEdgeInsets insets = self.collectionView.contentInset;
    CGPoint offset = self.collectionView.contentOffset;
    CGFloat minY = -insets.top;
    
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    if (offset.y < minY) {
        CGSize headerSize = self.headerReferenceSize;
        CGFloat deltaY = fabs(offset.y - minY);
        for (UICollectionViewLayoutAttributes *attribute in attributes) {
            
            if ([attribute representedElementKind] == UICollectionElementKindSectionHeader) {
                
                CGRect headerRect = attribute.frame;
                headerRect.size.height = MAX(minY, headerSize.height + deltaY);
                headerRect.origin.y = headerRect.origin.y - deltaY;
                attribute.frame = headerRect;
                break;
            }
        }
    }
    return attributes;
}

@end

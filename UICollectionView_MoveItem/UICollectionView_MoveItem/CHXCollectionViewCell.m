//
//  CHXCollectionViewCell.m
//  UICollectionView_MoveItem
//
//  Created by Chinsyo on 16/3/19.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

#import "CHXCollectionViewCell.h"

CG_INLINE CGFloat Random() {
    return arc4random()%100/100.f;
}
#define Random (Random())

@implementation CHXCollectionViewCell

- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    
    _numberLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _numberLabel.backgroundColor = [UIColor colorWithRed:Random green:Random blue:Random alpha:1.f];
    _numberLabel.textColor = [UIColor colorWithRed:MAX(Random, Random/2+0.2) green:MAX(Random, Random/2+0.2) blue:MAX(Random, Random/2+0.2) alpha:1.f];
    _numberLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_numberLabel];
}



@end

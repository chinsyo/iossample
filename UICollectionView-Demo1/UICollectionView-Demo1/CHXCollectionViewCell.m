//
//  CHXCollectionViewCell.m
//  UICollectionView-Demo1
//
//  Created by 王晨晓 on 16/3/15.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import "CHXCollectionViewCell.h"

@implementation CHXCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.contentView addSubview:self.label];
        self.contentView.autoresizesSubviews = YES;
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.label.backgroundColor = [UIColor orangeColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont boldSystemFontOfSize:50.0];
        self.label.textColor = [UIColor blackColor];
        
    }
    return self;
}

- (void)layoutSubviews {

}

@end

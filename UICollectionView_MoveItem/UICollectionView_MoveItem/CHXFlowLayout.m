//
//  CHXFlowLayout.m
//  UICollectionView_MoveItem
//
//  Created by Chinsyo on 16/3/19.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

#import "CHXFlowLayout.h"

@implementation CHXFlowLayout
- (instancetype)init {
    self = [super init];
    if (self) {
        self.sectionInset = UIEdgeInsetsMake(10.f, 10.f, 10.f, 10.f);
        self.minimumLineSpacing = 10.f;
        self.minimumInteritemSpacing = 10.f;
        self.itemSize = CGSizeMake(50, 50);
    }
    return self;
}
@end

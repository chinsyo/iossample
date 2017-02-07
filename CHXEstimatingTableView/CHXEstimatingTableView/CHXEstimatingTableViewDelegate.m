//
//  CHXEstimatingTableViewDelegate.m
//  CHXEstimatingTableView
//
//  Created by 王晨晓 on 16/3/24.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import "CHXEstimatingTableViewDelegate.h"

@implementation CHXEstimatingTableViewDelegate
- (instancetype)initWithHeightBlock:(CGFloat (^)(NSIndexPath *indexPath))heightBlock
              estimatingHeightBlock:(CGFloat(^)(NSIndexPath *indexPath))estimatingHeightBlock {
    if (self = [super initWithHeightBlock:heightBlock]) {
        _estimatingHeightBlock = [estimatingHeightBlock copy];
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _estimatingHeightBlock(indexPath);
}

@end

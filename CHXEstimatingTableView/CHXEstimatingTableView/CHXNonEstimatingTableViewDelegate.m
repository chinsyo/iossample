//
//  CHXNonEstimatingTableViewDelegate.m
//  CHXEstimatingTableView
//
//  Created by 王晨晓 on 16/3/24.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import "CHXNonEstimatingTableViewDelegate.h"

@implementation CHXNonEstimatingTableViewDelegate

- (instancetype)initWithHeightBlock:(CGFloat(^)(NSIndexPath *indexPath))heightBlock {
    if (self = [super init]) {
        _heightBlock = [heightBlock copy];
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _heightBlock(indexPath);
}


@end

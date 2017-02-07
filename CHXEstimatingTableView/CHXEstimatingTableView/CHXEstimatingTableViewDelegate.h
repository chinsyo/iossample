//
//  CHXEstimatingTableViewDelegate.h
//  CHXEstimatingTableView
//
//  Created by 王晨晓 on 16/3/24.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import "CHXNonEstimatingTableViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN
@interface CHXEstimatingTableViewDelegate : CHXNonEstimatingTableViewDelegate
@property (nonatomic, copy) CGFloat(^estimatingHeightBlock)(NSIndexPath *);
- (instancetype)initWithHeightBlock:(CGFloat (^)(NSIndexPath *indexPath))heightBlock
              estimatingHeightBlock:(CGFloat(^)(NSIndexPath *indexPath))estimatingHeightBlock;
@end
NS_ASSUME_NONNULL_END
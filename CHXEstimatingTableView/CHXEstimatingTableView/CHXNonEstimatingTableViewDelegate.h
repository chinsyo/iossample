//
//  CHXNonEstimatingTableViewDelegate.h
//  CHXEstimatingTableView
//
//  Created by 王晨晓 on 16/3/24.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface CHXNonEstimatingTableViewDelegate : NSObject <UITableViewDelegate>
@property (nonatomic, copy) CGFloat(^heightBlock)(NSIndexPath *indexPath);

- (instancetype)initWithHeightBlock:(CGFloat(^)(NSIndexPath *indexPath))heightBlock;
@end
NS_ASSUME_NONNULL_END
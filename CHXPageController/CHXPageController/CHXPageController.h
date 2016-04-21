//
//  CHXPageController.h
//  CHXPageController
//
//  Created by 王晨晓 on 16/4/21.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CHXPageControllerScrollDirection) {
    CHXPageControllerScrollDirectionUnknown = 0,
    CHXPageControllerScrollDirectionBackward,
    CHXPageControllerScrollDirectionForward,
};

#pragma mark - CHXPageControllerDataSource
@protocol CHXPageControllerDataSource <NSObject>

@end

#pragma mark - CHXPageControllerDelegate
@protocol CHXPageControllerDelegate <NSObject>

@end

#pragma mark - CHXPageChildControllerDelegate
@protocol CHXPageChildControllerDelegate <NSObject>

@end

#pragma mark - CHXPageController
@interface CHXPageController : UIViewController

@end

//
//  CHXCollectionView.h
//  CHXPageController
//
//  Created by 王晨晓 on 16/4/21.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CHXCollectionViewAccessoryType) {
    CHXCollectionViewAccessoryNone = 0,
    CHXCollectionViewAccessoryButton,
};

typedef NS_ENUM(NSInteger, CHXCollectionViewContentType) {
    CHXCollectionViewContentText = 0,
    CHXCollectionViewContentImage,
};

typedef NS_ENUM(NSInteger, CHXCollectionViewSizingMode) {
    CHXCollectionViewSizingFlexible = 0,
    CHXCollectionViewSizingFixed,
};

typedef NS_ENUM(NSInteger, CHXCollectionViewTransitionMode) {
    CHXCollectionViewTransitionProgress = 0,
    CHXCollectionViewTransitionSnapshot,
};

#pragma mark - CHXCollectionViewDataSource
@protocol CHXCollectionViewDataSource <NSObject>

@end

#pragma mark - CHXCollectionViewDelegate
@protocol CHXCollectionViewDelegate <NSObject>

@end

#pragma mark - CHXCollectionView
@interface CHXCollectionView : UIView

@end

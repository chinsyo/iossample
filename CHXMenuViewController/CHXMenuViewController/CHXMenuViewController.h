//
//  CHXMenuViewController.h
//  CHXMenuViewController
//
//  Created by 王晨晓 on 16/3/22.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 
#pragma mark CHXMenuViewDelegate
@class CHXMenuViewController;
@protocol CHXMenuViewDelegate <NSObject>
@optional

- (void)menu:(CHXMenuViewController *)menu didSelectedItemAtIndex:(NSInteger)index;
- (void)menuWillOpen;
- (void)menuDidOpen;
- (void)menuWillClose;
- (void)menuDidClose;
@end

#pragma mark -
#pragma mark CHXMenuViewController

typedef NS_ENUM(NSInteger, CHXMenuStyle) {
    CHXMenuStyleTable = 0,
    CHXMenuStyleCollection,
};

typedef NS_ENUM(BOOL, CHXMenuState) {
    CHXMenuStateOpened = YES,
    CHXMenuStateClosed = NO,
};

@interface CHXMenuViewController : UIViewController
@property (assign, nonatomic) CHXMenuStyle style;
@property (assign, nonatomic) CHXMenuState state;
@property (weak, nonatomic) id<CHXMenuViewDelegate> delegate;
@property (strong, nonatomic) NSMutableArray <UIViewController *>*controllers;
@property (strong, nonatomic) NSMutableArray <NSString *>*menuTitles;
@property (strong, nonatomic) NSMutableArray <NSString *>*imageTitles;
@property (strong, nonatomic, readonly) UIViewController *currentController;
@property (strong, nonatomic) UIColor *menuColor;
@property (strong, nonatomic) UIButton *menuButton;

+ (instancetype)menuWithControllers:(NSArray <UIViewController *>*)controllers menuTitles:(NSArray <NSString *>*)menuTitles imageTitles:(NSArray <NSString *>*)imageTitles style:(CHXMenuStyle)style;

+ (instancetype)menuWithControllers:(NSArray <UIViewController *>*)controllers menuTitles:(NSArray <NSString *>*)menuTitles imageTitles:(NSArray <NSString *>*)imageTitles;

- (instancetype)initWithControllers:(NSArray <UIViewController *>*)controllers menuTitles:(NSArray <NSString *>*)menuTitles imageTitles:(NSArray <NSString *>*)imageTitles style:(CHXMenuStyle)style;

- (instancetype)initWithControllers:(NSArray <UIViewController *>*)controllers menuTitles:(NSArray <NSString *>*)menuTitles imageTitles:(NSArray <NSString *>*)imageTitles;

- (void)addMenuItemWithController:(UIViewController *)controller title:(NSString *)title image:(NSString *)image;

- (void)openMenu;
- (void)closeMenu;
- (void)switchMenuState;
@end

NS_ASSUME_NONNULL_END
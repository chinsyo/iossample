//
//  FRPFullSizePhotoViewController.m
//  FRP
//
//  Created by Chinsyo on 16/5/16.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

// ViewControllers
#import "FRPFullSizePhotoViewController.h"
#import "FRPPhotoViewController.h"
#import "FRPPhotoDetailViewController.h"

// Models
#import "FRPFullSizePhotoViewModel.h"
#import "FRPPhotoViewModel.h"
#import "FRPPhotoDetailViewModel.h"

@interface FRPFullSizePhotoViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageViewController;

@end

@implementation FRPFullSizePhotoViewController

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{UIPageViewControllerOptionInterPageSpacingKey: @(30)}];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    [self addChildViewController:self.pageViewController];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Configure child view controllers
    [self.pageViewController setViewControllers:@[[self photoViewControllerForIndex:self.viewModel.initialPhotoIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Configure self
    self.title = self.viewModel.initialPhotoName;
    
    @weakify(self);
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    infoButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            
            FRPPhotoViewController *photoViewController = self.pageViewController.viewControllers.firstObject;
            FRPPhotoModel *photoModel = photoViewController.viewModel.model;
            
            FRPPhotoDetailViewModel *viewModel = [[FRPPhotoDetailViewModel alloc] initWithModel:photoModel];
            
            FRPPhotoDetailViewController *viewController = [[FRPPhotoDetailViewController alloc] initWithViewModel:viewModel];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
            
            [self presentViewController:navigationController animated:YES completion:^{
                [subscriber sendCompleted];
            }];
            
            return nil;
        }];
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
    
    // Configure self's view
    self.view.backgroundColor = [UIColor blackColor];
    
    // Configure subviews
    self.pageViewController.view.frame = self.view.bounds;
    [self.view addSubview:self.pageViewController.view];
}

#pragma mark - UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    self.title = [((FRPPhotoViewController *)self.pageViewController.viewControllers.firstObject).viewModel photoName];
    [self.delegate userDidScroll:self toPhotoAtIndex:[self.pageViewController.viewControllers.firstObject photoIndex]];
}

#pragma mark - UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(FRPPhotoViewController *)viewController {
    return [self photoViewControllerForIndex:viewController.photoIndex - 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(FRPPhotoViewController *)viewController {
    return [self photoViewControllerForIndex:viewController.photoIndex + 1];
}

#pragma mark - Private Methods
- (FRPPhotoViewController *)photoViewControllerForIndex:(NSInteger)index {
    FRPPhotoModel *photoModel = [self.viewModel photoModelAtIndex:index];
    if (photoModel) {
        FRPPhotoViewModel *photoViewModel = [[FRPPhotoViewModel alloc] initWithModel:photoModel];
        FRPPhotoViewController *photoViewController = [[FRPPhotoViewController alloc] initWithViewModel:photoViewModel index:index];
        return photoViewController;
    }
    return nil;
}

@end

//
//  CHXViewController.m
//  CHXStretchyLayout
//
//  Created by 王晨晓 on 16/3/18.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import "CHXViewController.h"
#import "CHXStretchyLayout.h"

static NSString *const kCHXCellIdentifier = @"Cell";
static NSString *const kCHXHeaderIdentifier = @"Header";

@interface CHXViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation CHXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CHXStretchyLayout *stretchyLayout = [CHXStretchyLayout new];
    stretchyLayout.sectionInset = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
    stretchyLayout.itemSize = CGSizeMake(300, 494);
    stretchyLayout.headerReferenceSize = CGSizeMake(320, 160);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:stretchyLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    
    
    [self.collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:kCHXCellIdentifier];
    [self.collectionView registerClass:[UICollectionReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:kCHXHeaderIdentifier];
}

#pragma mark -
#pragma mark UICollectionView DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

#pragma mark -
#pragma mark UICollectionView Delegate
- (UICollectionReusableView *)collectionView:(UICollectionView *)cv viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *header = [cv dequeueReusableSupplementaryViewOfKind:kind
                                                                               withReuseIdentifier:kCHXHeaderIdentifier
                                                                                      forIndexPath:indexPath];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:header.bounds];
    imageView.image = [UIImage imageNamed:@"psb.jpeg"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    imageView.clipsToBounds = YES;
    [header addSubview:imageView];
    
    return header;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:kCHXCellIdentifier
                                                                                forIndexPath:indexPath];
    
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Thin" size:30.0f], NSForegroundColorAttributeName : [UIColor lightGrayColor]};
    
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:@"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
                                               attributes:attributes];
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.attributedText = attrText;
    [cell addSubview:label];
    
    CGRect textRect = CGRectZero;
    textRect.size = [label sizeThatFits:cell.bounds.size];
    label.frame = textRect;
    
    return cell;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

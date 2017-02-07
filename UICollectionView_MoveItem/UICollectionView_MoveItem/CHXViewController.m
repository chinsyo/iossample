//
//  CHXViewController.m
//  UICollectionView_MoveItem
//
//  Created by Chinsyo on 16/3/19.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

#import "CHXViewController.h"
#import "CHXFlowLayout.h"
#import "CHXCollectionViewCell.h"

static NSString *const kCHXCellIdentifier = @"Cell";

@interface CHXViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (copy, nonatomic) NSMutableArray<NSString *> *dataSource;
@end

@implementation CHXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[CHXFlowLayout new]];
    [self.collectionView registerClass:[CHXCollectionViewCell class] forCellWithReuseIdentifier:kCHXCellIdentifier];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        for (NSInteger i = 0; i < 100; i++) {
            [_dataSource addObject:[NSString stringWithFormat:@"%ld", i]];
        }
    }
    return _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UICollectionView DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

#pragma mark -
#pragma mark UICollectionView Delegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CHXCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kCHXCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    UILongPressGestureRecognizer *panGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(moveItem:)];
    panGesture.delegate = self;
    [cell addGestureRecognizer:panGesture];

    cell.numberLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)moveItem:(UILongPressGestureRecognizer *)panGesture {
    
    CGPoint position = [panGesture locationInView:self.collectionView];
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan: {
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:[self.collectionView indexPathForItemAtPoint:position]];
            break;
        }

        case UIGestureRecognizerStateChanged: {
            [self.collectionView updateInteractiveMovementTargetPosition:position];
            break;
        }
            
        case UIGestureRecognizerStateEnded: {
            [self.collectionView endInteractiveMovement];
            break;
        }
            
        case UIGestureRecognizerStateCancelled: {
            [self.collectionView cancelInteractiveMovement];
            break;
        }
            
        default:
            break;
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {

    NSString *tmp = self.dataSource[sourceIndexPath.row];
    [self.dataSource removeObjectAtIndex:sourceIndexPath.row];
    [self.dataSource insertObject:tmp atIndex:destinationIndexPath.row];
    NSLog(@"%@", self.dataSource);
}

@end

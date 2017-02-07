//
//  CHXViewController.m
//  CHXEstimatingTableView
//
//  Created by 王晨晓 on 16/3/24.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import "CHXViewController.h"
#import "CHXEstimatingTableViewDelegate.h"

@interface CHXViewController ()
{
    NSDate *_loadStartTime;
    id<UITableViewDelegate> _delegate;
}
@end

@implementation CHXViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:style]) {
        
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)loadView {
    [super loadView];
    _loadStartTime = [NSDate date];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isEstimatingEnabled) {
        _delegate = [[CHXEstimatingTableViewDelegate alloc] initWithHeightBlock:^CGFloat(NSIndexPath * _Nonnull indexPath) {
            return [self heightForRowAtIndexPath:indexPath];
        } estimatingHeightBlock:^CGFloat(NSIndexPath * _Nonnull indexPath) {
            return 40;
        }];
    } else {
        _delegate = [[CHXNonEstimatingTableViewDelegate alloc] initWithHeightBlock:^CGFloat(NSIndexPath * _Nonnull indexPath) {
            return [self heightForRowAtIndexPath:indexPath];
        }];
    }
    self.tableView.delegate = _delegate;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSDate *date = [NSDate date];
    NSTimeInterval loadDurationTime = [date timeIntervalSinceDate:_loadStartTime];
    NSLog(@"It total cost %lf seconds to load view.", loadDurationTime);
    _loadStartTime = nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"index: %ld", indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%06ld", indexPath.row];
    return cell;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat result = 0;
    for (NSInteger i =  0; i < 1e5; i++) {
        result = sqrt((double)i);
    }
    result = (indexPath.row % 3 + 1) * 20.0;
    return result;
}

@end

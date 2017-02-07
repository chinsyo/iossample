//
//  MyView.m
//  LifeCycle
//
//  Created by Chinsyo on 16/5/4.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

#import "MyView.h"

#define MyLog NSLog(@"%@ %s", NSStringFromClass([self class]), __FUNCTION__);

@implementation MyView

- (instancetype)init {
    self = [super init];
    if (self) {
        MyLog
        self.backgroundColor = [UIColor blackColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 20, 20)];
        label.backgroundColor = [UIColor redColor];
        [self addSubview:label];
    }
    return self;
}

- (void)layoutSubviews {
    MyLog
}

- (void)drawRect:(CGRect)rect {
    MyLog
}

@end

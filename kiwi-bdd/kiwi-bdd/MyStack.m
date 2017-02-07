//
//  MyStack.m
//  kiwi-bdd
//
//  Created by Chinsyo on 16/5/1.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

#import "MyStack.h"

@interface MyStack ()

@property (nonatomic) NSMutableArray <NSNumber *>*numbers;

@end

@implementation MyStack

- (instancetype)init {
    self = [super init];
    if (self) {
        _numbers = [NSMutableArray array];
    }
    return self;
}

- (void)push:(double)number {
    [self.numbers addObject:@(number)];
}

- (void)pop {
    [self.numbers removeLastObject];
}

- (double)top {
    return [self.numbers lastObject].doubleValue;
}

- (NSUInteger)count {
    return [self.numbers count];
}

@end

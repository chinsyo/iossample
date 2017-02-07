//
//  MyStack.h
//  kiwi-bdd
//
//  Created by Chinsyo on 16/5/1.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyStack : NSObject
- (void)push:(double)number;
- (void)pop;
- (double)top;
- (NSUInteger)count;
@end

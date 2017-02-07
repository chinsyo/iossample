//
//  MyStackSpec.m
//  kiwi-bdd
//
//  Created by Chinsyo on 16/5/1.
//  Copyright 2016年 Chinsyo. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "MyStack.h"


SPEC_BEGIN(MyStackSpec)

describe(@"MyStack", ^{
    context(@"When created", ^{
        __block MyStack *stack = nil;
        beforeEach(^{
            stack = [MyStack new];
        });
        
        afterEach(^{
            stack = nil;
        });
        
        it(@"should have the class MyStack", ^{
            [[[MyStack class] shouldNot] beNil];
        });
        
        it(@"should exist", ^{
            [[stack shouldNot] beNil];
        });
    });
    
});

SPEC_END

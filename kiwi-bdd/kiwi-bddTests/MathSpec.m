//
//  MathSpec.m
//  kiwi-bdd
//
//  Created by Chinsyo on 16/5/1.
//  Copyright 2016年 Chinsyo. All rights reserved.
//

#import <Kiwi/Kiwi.h>

SPEC_BEGIN(MathSpec)

describe(@"Math", ^{
    context(@"Add", ^{
        NSInteger a = 1;
        NSInteger b = 2;
        [[theValue(a + b) should] equal:theValue(3)];
    });
});

SPEC_END

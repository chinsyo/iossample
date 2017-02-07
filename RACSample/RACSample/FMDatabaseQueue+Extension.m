//
//  FMDatabaseQueue+Extension.m
//  RACSample
//
//  Created by 王晨晓 on 16/5/17.
//  Copyright © 2016年 chinsyo. All rights reserved.
//

#import "FMDatabaseQueue+Extension.h"

@implementation FMDatabaseQueue (Extension)

+ (instancetype)sharedInstance {
    static FMDatabaseQueue *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [FMDatabaseQueue databaseQueueWithPath:@""];
    });
    return sharedInstance;
}

@end

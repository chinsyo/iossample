//
//  Logger.m
//  Log
//
//  Created by Chinsyo on 16/5/11.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

#import "Logger.h"
#import <FMDB/FMDB.h>

static NSString *const kTableName = @"log";

@interface Logger ()

@property (nonatomic, strong) FMDatabase *db;

@end

@implementation Logger

+ (instancetype)sharedInstance {
    static Logger *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Logger alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        NSString *docsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *dbPath   = [docsPath stringByAppendingPathComponent:@"test.db"];
        _db = [FMDatabase databaseWithPath:dbPath];
        
        NSString *sql = [NSString stringWithFormat:@"create table %@(time, target, action)", kTableName];
        [_db executeUpdate:sql];
    }
    return self;
}

- (void)insertLogWithTime:(NSTimeInterval)time target:(NSString *)target action:(NSString *)action {
    if (![self.db open]) {
        return;
    }
    [_db executeUpdateWithFormat:@"insert into %@ values(%lf, %@, %@)", kTableName, time, target, action];
    
}

- (void)showLogs {
    FMResultSet *s = [_db executeQuery:@"select * from %@", kTableName];
    NSMutableArray <NSString *>*array = [NSMutableArray array];
    while ([s next]) {
        NSTimeInterval time = [s doubleForColumn:@"time"];
        NSString *target = [s stringForColumn:@"target"];
        NSString *action = [s stringForColumn:@"action"];
        NSString *item = [NSString stringWithFormat:@"time:%lf target:%@ action:%@\n", time, target, action];
        [array addObject:item];
    }
    NSLog(@"%@", array);
}

@end

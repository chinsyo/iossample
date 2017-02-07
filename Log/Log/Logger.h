//
//  Logger.h
//  Log
//
//  Created by Chinsyo on 16/5/11.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Logger : NSObject

+ (instancetype)sharedInstance;

- (void)insertLogWithTime:(NSTimeInterval)time target:(NSString *)target action:(NSString *)action;

- (void)showLogs;

@end

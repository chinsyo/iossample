//
//  Clock.h
//  KVOController
//
//  Created by 王晨晓 on 16/4/19.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Clock : NSObject

+ (instancetype)clock;

@property (strong, readonly, nonatomic) NSDate *date;

@end

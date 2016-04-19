//
//  ClockLayer.h
//  KVOController
//
//  Created by 王晨晓 on 16/4/19.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface ClockLayer : CALayer
+ (NSDictionary *)darkStyle;
+ (NSDictionary *)lightStyle;
@property (strong, nonatomic) NSDate *date;
@end

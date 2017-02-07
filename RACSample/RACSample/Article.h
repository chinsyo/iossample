//
//  Article.h
//  RACSample
//
//  Created by 王晨晓 on 16/5/16.
//  Copyright © 2016年 chinsyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject
@property (copy, nonatomic) NSString *articleId;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *authorname;
@property (copy, nonatomic) NSString *categoryname;
@end

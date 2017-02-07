//
//  NSAttributedString+CHXWatermark.m
//  CHXWatermark
//
//  Created by 王晨晓 on 16/4/27.
//  Copyright © 2016年 chinsyo. All rights reserved.
//

#import "NSAttributedString+CHXWatermark.h"

@implementation NSAttributedString (CHXWatermark)
- (CGSize)textSize {
    NSString *string = self.string;
    NSRange range = NSMakeRange(0, self.length);
    NSRangePointer ptr = &range;
    NSDictionary *attributes = [self attributesAtIndex:0 effectiveRange:ptr];
    CGSize textSize = [string sizeWithAttributes:attributes];
    return textSize;
}
@end

//
//  CHXKVOInfo.m
//  KVOController
//
//  Created by 王晨晓 on 16/4/13.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import "CHXKVOInfo.h"

@implementation CHXKVOInfo

- (BOOL)isEqual:(id)object {
    if (nil == object) {
        return NO;
    }
    if (self == object) {
        return YES;
    }
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return [_keyPath isEqualToString:((CHXKVOInfo *)object)->keyPath];
}

- (NSString *)debugDescription {
    NSMutableString *s = [NSMutableString stringWithFormat:@"<%@:%p keyPath:%@", NSStringFromClass([self class]), self, _keyPath];
    if (0 != _options) {
        [s appendFormat:@" options:%@", describe_option(_options)];
    }
    if (NULL != _action) {
        [s appendFormat:@" action:%@", NSStringFromSelector(_action)];
    }
    if (NULL != _context) {
        [s appendFormat:@" context:%p", _context];
    }
    if (NULL != _block) {
        [s appendFormat:@" block:%p", _block];
    }
    [s appendString:@">"];
    return s;
}
@end

//
//  CHXKVOInfo.m
//  KVOController
//
//  Created by 王晨晓 on 16/4/13.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import "CHXKVOInfo.h"

@implementation CHXKVOInfo

- (instancetype)initWithController:(CHXKVOController *)controller
                           keyPath:(NSString *)keyPath
                           options:(NSKeyValueObservingOptions)options
                             block:(nullable CHXKVONotificationBlock)block
                            action:(nullable SEL)action
                           context:(nullable void *)context {
    
    if (self = [super init]) {
        _controller = controller;
        _keyPath = [keyPath copy];
        _block = [block copy];
        _options = options;
        _action = action;
        _context = context;
    }
    return self;
}

- (instancetype)initWithController:(CHXKVOController *)controller keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options block:(CHXKVONotificationBlock)block {
    
    return [self initWithController:controller keyPath:keyPath options:options block:block action:NULL context:NULL];
}

- (instancetype)initWithController:(CHXKVOController *)controller keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options action:(SEL)action {
    return [self initWithController:controller keyPath:keyPath options:options block:NULL action:action context:NULL];
}

- (instancetype)initWithController:(CHXKVOController *)controller keyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    return [self initWithController:controller keyPath:keyPath options:options block:NULL action:NULL context:context];
}

- (instancetype)initWithController:(CHXKVOController *)controller keyPath:(NSString *)keyPath
{
    return [self initWithController:controller keyPath:keyPath options:0 block:NULL action:NULL context:NULL];
}

- (NSUInteger)hash {
    return [_keyPath hash];
}

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
    return [_keyPath isEqualToString:((CHXKVOInfo *)object)->_keyPath];
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

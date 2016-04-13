//
//  NSObject+CHXKVOController.h
//  KVOController
//
//  Created by 王晨晓 on 16/4/13.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHXKVOController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (CHXKVOController)
@property (strong, nonatomic) CHXKVOController *KVOController;
@property (strong, nonatomic) CHXKVOController *KVOControllerNonRetaining;
@end

NS_ASSUME_NONNULL_END
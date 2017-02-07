//
//  FRPPhotoImporter.h
//  FRP
//
//  Created by Chinsyo on 16/5/16.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FRPPhotoModel;

@interface FRPPhotoImporter : NSObject

+ (RACSignal *)importPhotos;
+ (RACSignal *)fetchPhotoDetails:(FRPPhotoModel *)photoModel;
+ (RACSignal *)logInWithUsername:(NSString *)username password:(NSString *)password;
+ (RACSignal *)voteForPhoto:(FRPPhotoModel *)photoModel;

@end

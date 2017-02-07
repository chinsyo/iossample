//
//  FRPGalleryViewModel.m
//  FRP
//
//  Created by Chinsyo on 16/5/16.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

#import "FRPGalleryViewModel.h"

// Utilities
#import "FRPPhotoImporter.h"

@implementation FRPGalleryViewModel

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    RAC(self, model) = [self importPhotosSignal];
    return self;
}

#pragma mark - Private Methods
- (RACSignal *)importPhotosSignal {
    return [[[FRPPhotoImporter importPhotos] logError] catchTo:[RACSignal empty]];
}

@end

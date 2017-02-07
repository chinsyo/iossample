//
//  CHXSampleViewController.m
//  CHXMenuViewController
//
//  Created by 王晨晓 on 16/3/22.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import "CHXSampleViewController.h"

typedef NS_ENUM(NSInteger, CHXColorTemperature) {
    CHXColorTemperatureDefault = 0,
    CHXColorTemperatureLight,
    CHXColorTemperatureDark,
};

CG_INLINE CGFloat GenerateRandom(CHXColorTemperature t) {
    switch (t) {
        case CHXColorTemperatureDefault:
            return arc4random()%256/256.0;
            break;
            
        case CHXColorTemperatureLight:
            return arc4random()%128/256.0 + 0.5;
            break;
            
        case CHXColorTemperatureDark:
            return arc4random()%128/256.0;
            break;
    }
}

@implementation CHXSampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHue:GenerateRandom(CHXColorTemperatureDefault)
                                           saturation:GenerateRandom(CHXColorTemperatureLight)
                                           brightness:GenerateRandom(CHXColorTemperatureLight)
                                                alpha:1.0];
    // Do any additional setup after loading the view.
}


@end

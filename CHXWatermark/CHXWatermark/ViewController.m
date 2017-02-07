//
//  ViewController.m
//  CHXWatermark
//
//  Created by 王晨晓 on 16/4/27.
//  Copyright © 2016年 chinsyo. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+CHXWatermark.h"

@interface ViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"pic.jpg"];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, image.size.width/2, image.size.height/2)];
    self.imageView.center = self.view.center;
    [self.view addSubview:self.imageView];
    
    NSAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"I❤️MOMO" attributes:@{NSForegroundColorAttributeName:[UIColor redColor], NSFontAttributeName: [UIFont boldSystemFontOfSize:30.f]}];
    UIImage *updatedImage = [UIImage imageWithUIImage:image watermarkText:attrStringß atPosition:CGPositionVerticalBottom|CGPositionHorizontalRight];
    self.imageView.image = updatedImage;
    UIImageWriteToSavedPhotosAlbum(updatedImage, NULL, NULL, nil);
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

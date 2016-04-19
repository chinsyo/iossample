//
//  ClockLayer.m
//  KVOController
//
//  Created by 王晨晓 on 16/4/19.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import "ClockLayer.h"
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

#define NUMBER_LAYER_COUNT 12
#define NUMBER_FONT_NAME @"HelveticaNeue"
#define NUMBER_FONT_SIZE 16.0

#define SECOND_HAND_LENGTH 0.57
#define MINUTE_HAND_LENGTH 0.65
#define HOUR_HAND_LENGTH 0.5

@interface ElipseLayer : CAShapeLayer

@end

@implementation ElipseLayer

- (void)setBounds:(CGRect)bounds {
    if (!CGRectEqualToRect(self.bounds, bounds)) {
        super.bounds = bounds;
        if (CGRectEqualToRect(CGRectZero, bounds)) {
            self.path = NULL;
        } else {
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathAddEllipseInRect(path, nil, bounds);
            self.path = path;
            CGPathRelease(path);
        }
    }
}

@end

static CALayer *hand_layer(CGFloat contentsScale) {
    CALayer *layer = [CALayer layer];
    layer.contentsScale = contentsScale;
    layer.shouldRasterize = YES;
    return layer;
}

static ElipseLayer *elipse_layer(CGFloat contentsScale) {
    ElipseLayer *layer = [ElipseLayer layer];
    layer.contentsScale = contentsScale;
    layer.shouldRasterize = YES;
    return layer;
}

static CATextLayer *number_layer(CGFloat contentsScale, CTFontRef font, NSInteger number) {
    CATextLayer *layer = [CATextLayer layer];
    layer.string = [NSString stringWithFormat:@"%lu", (unsigned long)number];
    layer.alignmentMode = kCAAlignmentCenter;
    layer.fontSize = NUMBER_FONT_SIZE;
    layer.font = font;
    layer.contentsScale = contentsScale;
    return layer;
}

static NSString *const kClockBackgroundColorKey = @"kClockBackgroundColorKey";
static NSString *const kClockForegroundColorKey = @"kClockForegroundColorKey";
static NSString *const kClockAccentColorKey = @"kClockAccentColorKey";

@interface ClockLayer ()
@property (strong, nonatomic) UIColor *clockBackgroundColor;
@property (strong, nonatomic) UIColor *clockForegroundColor;
@property (strong, nonatomic) UIColor *clockAccentColor;
@property (strong, nonatomic) ElipseLayer *faceLayer;
@property (strong, nonatomic) ElipseLayer *largeDotLayer;
@property (strong, nonatomic) ElipseLayer *smallDotLayer;
@property (strong, nonatomic) CALayer *secondHandLayer;
@property (strong, nonatomic) CALayer *minuteHandLayer;
@property (strong, nonatomic) CALayer *hourHandLayer;
@property (strong, nonatomic) NSArray *numberLayers;
@property (assign, nonatomic) CGFloat radius;
@property (assign, nonatomic) BOOL needsFullLayout;
@end

@implementation ClockLayer

// dark style definition
+ (NSDictionary *)darkStyle
{
    return @{kClockBackgroundColorKey: [UIColor blackColor],
             kClockForegroundColorKey: [UIColor whiteColor],
             kClockAccentColorKey: [UIColor redColor]};
}

// light style definition
+ (NSDictionary *)lightStyle
{
    return @{kClockBackgroundColorKey: [UIColor whiteColor],
             kClockForegroundColorKey: [UIColor blackColor],
             kClockAccentColorKey: [UIColor redColor]};
}

// default style definition
+ (id)defaultValueForKey:(NSString *)key
{
    id value = [self darkStyle][key];
    if (nil != value) {
        return value;
    }
    return [super defaultValueForKey:key];
}

#pragma mark - Lifecycle
- (instancetype)init {
    if (self = [super init]) {
        CGFloat contentsScale = [UIScreen mainScreen].scale;
        _faceLayer = elipse_layer(contentsScale);
        _largeDotLayer = elipse_layer(contentsScale);
        _smallDotLayer = elipse_layer(contentsScale);
        
        CTFontRef font = CTFontCreateWithName((CFStringRef)NUMBER_FONT_NAME, NUMBER_FONT_SIZE, NULL);
        NSMutableArray *numberLayers = [NSMutableArray arrayWithCapacity:NUMBER_LAYER_COUNT];
        for (NSInteger i = 0; i < NUMBER_LAYER_COUNT; i++) {
            [numberLayers addObject:number_layer(contentsScale, font, i)];
        }
        _numberLayers = numberLayers;
        _hourHandLayer = hand_layer(contentsScale);
        _minuteHandLayer = hand_layer(contentsScale);
        _secondHandLayer = hand_layer(contentsScale);
        
        NSMutableArray *sublayers = [NSMutableArray arrayWithObjects:_faceLayer, nil];
        [sublayers addObject:_numberLayers];
        [sublayers addObjectsFromArray:@[_largeDotLayer, _hourHandLayer, _minuteHandLayer, _secondHandLayer, _smallDotLayer]];
        self.sublayers = sublayers;
        if (NULL != font) {
            CFRelease(font);
        }
    }
    return self;
}

#pragma mark - Properties

@dynamic clockBackgroundColor;
@dynamic clockForegroundColor;
@dynamic clockAccentColor;

- (void)setStyle:(NSDictionary *)style {
    super.style = style;
    [self _updatedStyle];
}

- (void)setBounds:(CGRect)bounds {
    if (!CGRectEqualToRect(bounds, self.bounds)) {
        _radius = MIN(CGRectGetWidth(bounds), CGRectGetHeight(bounds)/2.0);
        _needsFullLayout = YES;
        super.bounds = bounds;
    }
}

- (void)setDate:(NSDate *)date {
    if (_date != date && ![_date isEqualToDate:date]) {
        _date = date;
        [self setNeedsLayout];
    }
}

#pragma mark - Utilities

- (void)_updatedStyle {
    CGColorRef backgroundColor = self.clockBackgroundColor.CGColor;
    CGColorRef foregroundColor = self.clockForegroundColor.CGColor;
    CGColorRef accentColor = self.clockAccentColor.CGColor;
    
    _faceLayer.fillColor = backgroundColor;
    _largeDotLayer.fillColor = foregroundColor;
    _smallDotLayer.fillColor = accentColor;
    
    [_numberLayers enumerateObjectsUsingBlock:^(CATextLayer *numberLayer, NSUInteger idx, BOOL * _Nonnull stop) {
        numberLayer.foregroundColor = foregroundColor;
    }];
    _hourHandLayer.backgroundColor = foregroundColor;
    _minuteHandLayer.backgroundColor = foregroundColor;
    _secondHandLayer.backgroundColor = accentColor;
}

- (void)_rotateHandLayers
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:_date];
    NSInteger minutesIntoDay = dateComponents.hour * 60 + dateComponents.minute;
    CGFloat percentMinutesIntoDay = (CGFloat)minutesIntoDay / (12.0 * 60.0);
    CGFloat percentMinutesIntoHour = (CGFloat)dateComponents.minute / 60.0;
    CGFloat percentSecondsIntoMinute = (CGFloat)dateComponents.second / 60.0;
    
    _secondHandLayer.transform = CATransform3DMakeRotation(M_PI * 2 * percentSecondsIntoMinute, 0, 0, 1);
    _hourHandLayer.transform = CATransform3DMakeRotation(M_PI * 2 * percentMinutesIntoDay, 0, 0, 1);
    _minuteHandLayer.transform = CATransform3DMakeRotation(M_PI * 2 * percentMinutesIntoHour, 0, 0, 1);
}

- (void)_layoutElipseLayers
{
    CGRect bounds = self.bounds;
    CGPoint center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
    
    _faceLayer.bounds = bounds;
    _faceLayer.position = center;
    
    _smallDotLayer.bounds = CGRectMake(0, 0, 3.0, 3.0);
    _smallDotLayer.position = center;
    
    _largeDotLayer.bounds = CGRectMake(0, 0, 9.0, 9.0);
    _largeDotLayer.position = center;
}

- (void)_layoutNumberLayers
{
    // XXX document
    CGRect bounds = self.bounds;
    CGPoint p = CGPointMake(0, _radius - 14);
    CGFloat tickAngle = 2 * M_PI / NUMBER_LAYER_COUNT;
    
    [_numberLayers enumerateObjectsUsingBlock:^(CALayer *numberLayer, NSUInteger idx, BOOL *stop) {
        CGAffineTransform t = CGAffineTransformMakeRotation(7 * tickAngle + idx * tickAngle);
        CGPoint pp = CGPointApplyAffineTransform(p, t);
        pp.x += bounds.size.width / 2;
        pp.y += bounds.size.height / 2;
        numberLayer.position = pp;
        numberLayer.bounds = CGRectMake(0.0, 0.0, 18.0, 18.0);
    }];
}

- (void)_layoutHandLayers
{
    CGRect bounds = self.bounds;
    CGPoint center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
    
    _secondHandLayer.bounds = CGRectMake(0, 0, 1.0, SECOND_HAND_LENGTH * _radius);
    _secondHandLayer.anchorPoint = CGPointMake(0.5, 1);
    _secondHandLayer.position = center;
    
    _minuteHandLayer.bounds = CGRectMake(0, 0, 2.0, MINUTE_HAND_LENGTH * _radius);
    _minuteHandLayer.anchorPoint = CGPointMake(0.5, 1);
    _minuteHandLayer.position = center;
    _minuteHandLayer.cornerRadius = 1.5;
    
    _hourHandLayer.bounds = CGRectMake(0, 0, 3.0, HOUR_HAND_LENGTH * _radius);
    _hourHandLayer.anchorPoint = CGPointMake(0.5, 1);
    _hourHandLayer.position = center;
    _hourHandLayer.cornerRadius = 1.5;
    
    [self _rotateHandLayers];
}

#pragma mark - Override
- (void)layoutSublayers {
    if (!_needsFullLayout) {
        [self _rotateHandLayers];
    } else {
        [self _layoutElipseLayers];
        [self _layoutNumberLayers];
        [self _layoutHandLayers];
        _needsFullLayout = NO;
    }
}
@end

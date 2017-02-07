//
//  CHXShinyLabel.m
//  CHXShinyLabel
//
//  Created by 王晨晓 on 16/3/16.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import "CHXShinyLabel.h"

@interface CHXShinyLabel()

NS_ASSUME_NONNULL_BEGIN
@property (strong, nonatomic) NSMutableAttributedString *attributedString;
@property (strong, nonatomic) NSMutableArray *characterAnimationDurations;
@property (strong, nonatomic) NSMutableArray *characterAnimationIntervals;
@property (strong, nonatomic) CADisplayLink *displaylink;
NS_ASSUME_NONNULL_END

@property (assign, nonatomic) CFTimeInterval startTime;
@property (assign, nonatomic) CFTimeInterval finishTime;
@property (assign, nonatomic, getter = isFadeOut) BOOL fadeOut;
@property (copy, nonatomic) void(^completion)();

@end

@implementation CHXShinyLabel

#pragma mark -
#pragma mark Initialize Method
- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _shiningDuration = kCHXShinyLabelAnimationDuration;
    _fadeOutDuration = kCHXShinyLabelAnimationDuration;
    _autoStart       = NO;
    _fadeOut        = YES;
    self.textColor  = [UIColor whiteColor];
    
    _characterAnimationDurations = [NSMutableArray array];
    _characterAnimationIntervals = [NSMutableArray array];
    
    _displaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateAttributedString)];
    _displaylink.paused = YES;
    [_displaylink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)didMoveToWindow {
    if (nil != self.window && self.autoStart) {
        [self shine];
    }
}

- (void)setText:(NSString *)text {
    self.attributedText = [[NSAttributedString alloc] initWithString:text];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    self.attributedString = [self initialMutableAttributedStringFromAttributedString:attributedText];
    [super setAttributedText:self.attributedString];
    
    for (NSInteger i = 0; i < attributedText.length; i++) {
        self.characterAnimationIntervals[i] = @(arc4random_uniform(self.shiningDuration / 2 * 100) / 100.0);
        CGFloat remain = self.shiningDuration - [self.characterAnimationIntervals[i] floatValue];
        self.characterAnimationDurations[i] = @(arc4random_uniform(remain * 100) / 100.0);
    }
}

- (void)shine {
    [self shineWithCompletion:NULL];
}

- (void)shineWithCompletion:(void(^)())completion {
    if (!self.isShining && self.isFadeOut) {
        self.completion = completion;
        self.fadeOut = NO;
        [self startAnimationWithDuration:self.shiningDuration];
    }
}

- (void)fadeOut {
    [self fadeOutWithCompletion:NULL];
}

- (void)fadeOutWithCompletion:(void(^)())completion {
    if (!self.isShining && !self.isFadeOut) {
        self.completion = completion;
        self.fadeOut = YES;
        [self startAnimationWithDuration:self.fadeOutDuration];
    }
}

- (BOOL)isShining {
    return !self.displaylink.isPaused;
}

- (BOOL)isVisible {
    return NO == self.isFadeOut;
}


#pragma mark - 
#pragma mark Private methods

- (void)startAnimationWithDuration:(CFTimeInterval)duration {
    self.startTime = CACurrentMediaTime();
    self.finishTime = self.startTime + self.shiningDuration;
    self.displaylink.paused = NO;
}

- (void)updateAttributedString {
    CFTimeInterval now = CACurrentMediaTime();
    for (NSInteger i = 0; i < self.attributedString.length; i++) {
        
        if ([[NSCharacterSet whitespaceAndNewlineCharacterSet] characterIsMember:[self.attributedString.string characterAtIndex:i]]) {
            continue;
        }
        
        [self.attributedString enumerateAttribute:NSForegroundColorAttributeName inRange:NSMakeRange(i, 1) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id value, NSRange range, BOOL *stop) {
            
            CGFloat currentAlpha = CGColorGetAlpha([(UIColor *)value CGColor]);
            BOOL shouldUpdateAlpha = (self.isFadeOut && currentAlpha > 0) || (!self.isFadeOut && currentAlpha < 1) || (now - self.startTime) >= [self.characterAnimationIntervals[i] floatValue];
            
            if (!shouldUpdateAlpha) {
                return;
            }
            
            CGFloat percentage = (now - self.startTime - [self.characterAnimationIntervals[i] floatValue]) / ( [self.characterAnimationDurations[i] floatValue]);
            
            if (self.isFadeOut) {
                percentage = 1 - percentage;
            }
            
            UIColor *color = [self.textColor colorWithAlphaComponent:percentage];
            [self.attributedString addAttribute:NSForegroundColorAttributeName value:color range:range];
        }];
    }
    
    [super setAttributedText:self.attributedString];
    if (now > self.finishTime) {
        self.displaylink.paused = YES;
        if (self.completion) {
            self.completion();
        }
    }
}

- (NSMutableAttributedString *)initialMutableAttributedStringFromAttributedString:(NSAttributedString *)attributedString {
    NSMutableAttributedString *mutableAttributedString = [attributedString mutableCopy];
    UIColor *color = [self.textColor colorWithAlphaComponent:0];
    [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, mutableAttributedString.length)];
    return mutableAttributedString;
}

@end

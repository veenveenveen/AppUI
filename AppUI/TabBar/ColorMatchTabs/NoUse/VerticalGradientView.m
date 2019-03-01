//
//  VerticalGradientView.m
//  AppUI
//
//  Created by Himin on 2019/1/14.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "VerticalGradientView.h"

@interface VerticalGradientView ()

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end

@implementation VerticalGradientView

- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = self.bounds;
    [self.layer insertSublayer:self.gradientLayer atIndex:0];
}

#pragma mark - setter

- (void)setTopColor:(UIColor *)topColor {
    _topColor = topColor;
    [self updateColors];
}

- (void)setBottomColor:(UIColor *)bottomColor {
    _bottomColor = bottomColor;
    [self updateColors];
}

- (void)updateColors {
    if (self.topColor && self.bottomColor) {
        self.gradientLayer.colors = @[(id)self.topColor.CGColor, (id)self.bottomColor.CGColor];
    }
}

@end

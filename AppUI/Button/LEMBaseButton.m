//
//  LEMBaseButton.m
//  AppUI
//
//  Created by Himin on 2019/1/24.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "LEMBaseButton.h"

#define DefaultButtonColor [UIColor colorWithHexString:@"cddeef"]

@implementation LEMBaseButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self defaultSetting];
    }
    return self;
}

- (void)defaultSetting {
    self.layer.backgroundColor = DefaultButtonColor.CGColor;
    self.layer.cornerRadius = 5;
    self.titleLabel.font = [UIFont FZKaiWithFontSize:16];
    [self setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
}

@end

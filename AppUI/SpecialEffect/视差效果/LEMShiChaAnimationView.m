//
//  LEMShiChaAnimationView.m
//  AppUI
//
//  Created by Himin on 2019/1/23.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "LEMShiChaAnimationView.h"

@implementation LEMShiChaAnimationView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_imageView];
    }
    return self;
}

- (void)setContentX:(CGFloat)contentX {
    _contentX = contentX;
    _imageView.frame = CGRectMake(contentX, 0, self.frame.size.width, self.frame.size.height);
}

@end

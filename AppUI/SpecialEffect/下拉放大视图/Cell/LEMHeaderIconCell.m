//
//  LEMHeaderIconCell.m
//  AppUI
//
//  Created by Himin on 2019/1/25.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "LEMHeaderIconCell.h"

// #import <Accelerate/Accelerate.h> Accelerate框架中的内容；（Accelerate专门处理复杂运算和复杂效果用的）
// UIImage+ImageEffects 实现图片的模糊效果模糊效果
#import "UIImage+ImageEffects.h"

static CGFloat headerCellHeight = 220;
static NSString *bgImageName = @"IMG_02.JPG";

@interface LEMHeaderIconCell ()

@property (nonatomic, strong) UIView      *scaleContentView; // 用于缩放的容器视图
@property (nonatomic, strong) UIImageView *backgroundImageView; // 背景图（原图）
@property (nonatomic, strong) UIImageView *blurImageView; // 模糊图 blurImage
@property (nonatomic, strong) UIImageView *grayImageView; // 灰度图 grayScale

@end

@implementation LEMHeaderIconCell

// override

- (void)setupCell {
    [super setupCell];
    self.backgroundColor = UIColor.clearColor;
}

- (void)buildSubview {
    UIViewContentMode imgViewContentMode = UIViewContentModeScaleAspectFill;
    
    CGRect rect = CGRectMake(0, 0, kScreenWidth, headerCellHeight);
    
    // 用于放大效果的视图
    self.scaleContentView = [[UIView alloc] init];
    self.scaleContentView.layer.anchorPoint = CGPointMake(0.5, 1);
    self.scaleContentView.frame = rect;
    self.scaleContentView.clipsToBounds = YES;
    
    self.scaleContentView.backgroundColor = UIColor.blueColor;
    [self addSubview:self.scaleContentView];
    
    // 背景图
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.scaleContentView.bounds];
    self.backgroundImageView.image = [UIImage imageNamed:bgImageName];
    self.backgroundImageView.contentMode = imgViewContentMode;
    [self.scaleContentView addSubview:self.backgroundImageView];
    
    // Blur imageView. 图片的模糊效果
    self.blurImageView             = [[UIImageView alloc] initWithFrame:self.scaleContentView.bounds];
    self.blurImageView.contentMode = imgViewContentMode;
    self.blurImageView.alpha       = 0.f;
    [self.scaleContentView addSubview:self.blurImageView];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [[UIImage imageNamed:bgImageName] blurImage];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.blurImageView.image = image;
        });
    });
    
    // Gray imageView.
    self.grayImageView             = [[UIImageView alloc] initWithFrame:self.scaleContentView.bounds];
    self.grayImageView.contentMode = imgViewContentMode;
    self.grayImageView.alpha       = 0.f;
    [self.scaleContentView addSubview:self.grayImageView];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [[UIImage imageNamed:bgImageName] grayScale];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.grayImageView.image = image;
        });
    });
    
}

- (void)loadContent {
    
}

// scrollview 滚动时调用
- (void)offsetY:(CGFloat)offsetY {
    
    CGFloat calculateY = (offsetY+kStatusBarHeight);// 保证刚开始滑动时值为0
    
    if (calculateY <= 0) {
        // s = y * (1/300) + 1
        CGFloat scale = calculateY * -(1/(headerCellHeight-80)) + 1;
        self.scaleContentView.transform = CGAffineTransformMakeScale(scale, scale);

        self.blurImageView.alpha = calculateY / -100;
        self.grayImageView.alpha = 0.f;
        
    } else {
        
        self.scaleContentView.transform = CGAffineTransformIdentity;

        self.blurImageView.alpha = 0.f;
        self.grayImageView.alpha = calculateY / 100;
    }
}

// class property

+ (CGFloat)cellHeight {
    return headerCellHeight;
}

@end

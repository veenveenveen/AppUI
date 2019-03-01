//
//  LEMColorCarouselCell.m
//  AppUI
//
//  Created by Himin on 2019/1/22.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "LEMColorCarouselCell.h"

@interface LEMColorCarouselCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LEMColorCarouselCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

// 设置数据

- (void)loadContentWithModel:(LEMColorCarouselModel *)dataModel {
    self.dataModel = dataModel;
    
    self.imageView.image = dataModel.image;
}

- (void)setupViews {
    [self.contentView addSubview:self.imageView];
}

#pragma mark -

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.contentView.frame];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

@end

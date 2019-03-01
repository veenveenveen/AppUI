//
//  CustomCarouselCell.m
//  AppUI
//
//  Created by Himin on 2019/1/11.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "CustomCarouselCell.h"

@interface CustomCarouselCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation CustomCarouselCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

// 设置数据

- (void)loadContentWithModel:(CarouselColorModel *)dataModel {
    self.dataModel = dataModel;
    
    self.imageView.image = dataModel.image;
}

- (void)setupViews {
    self.backgroundColor = UIColor.lightGrayColor;
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

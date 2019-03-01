//
//  LEMScaleCell.m
//  AppUI
//
//  Created by Himin on 2019/1/22.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "LEMScaleCell.h"

@interface LEMScaleCell ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation LEMScaleCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)loadContentWithModel:(LEMScaleModel *)dataModel {
    _dataModel = dataModel;
    self.imgView.image = dataModel.image;
}

#pragma mark - private

- (void)setupViews {
    [self.contentView addSubview:self.imgView];
}

#pragma mark -

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:self.contentView.frame];
        _imgView.contentMode = UIViewContentModeScaleToFill;
    }
    return _imgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _titleLabel;
}

@end

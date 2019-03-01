//
//  PerseiMenuCell.m
//  AppUI
//
//  Created by Himin on 2019/1/11.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "PerseiMenuCell.h"
#import "Masonry.h"

@interface PerseiMenuCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

//@property (nonatomic, strong) PerseiMenuItem *menuItem;

@end

@implementation PerseiMenuCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    
    self.backgroundColor = UIColor.orangeColor;
    
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(10);
        make.left.mas_equalTo(self).mas_offset(10);
        make.right.mas_equalTo(self).mas_offset(-10);
        make.bottom.mas_equalTo(self.titleLabel.mas_top).offset(-5);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.left.mas_equalTo(self).mas_offset(5);
        make.right.mas_equalTo(self).mas_offset(-5);
        make.bottom.mas_equalTo(self).mas_offset(-5);
    }];
}

#pragma mark - set data

- (void)applyMenuItem:(PerseiMenuItem *)menuItem {
//    self.menuItem = menuItem;
    
    self.imageView.image = menuItem.image;
    self.titleLabel.text = menuItem.name;
}

#pragma mark -

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end

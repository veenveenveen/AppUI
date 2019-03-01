//
//  LEMCustomNavView.m
//  AppUI
//
//  Created by Himin on 2019/1/22.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "LEMCustomNavView.h"

@interface LEMCustomNavView ()

@property (nonatomic, strong) CAShapeLayer *bgLayer;
@property (nonatomic, strong) UIView *navBarView;        // 导航栏容器视图
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation LEMCustomNavView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupNavBackgroundLayer];
        [self setupNavView];
    }
    return self;
}

- (void)setupNavBackgroundLayer {
    self.bgLayer = [CAShapeLayer layer];
    self.bgLayer.frame = self.bounds;
    [self.layer addSublayer:self.bgLayer];
}

#pragma mark - 修改颜色.

- (void)changeBackgroundViewColor:(UIColor *)color {
    self.bgLayer.backgroundColor = color.CGColor;
}

- (void)changeNavViewColor:(UIColor *)color {
    self.navBarView.backgroundColor = color;
}

#pragma mark - setter.

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

#pragma mark - private.

- (void)setupNavView {
    [self addSubview:self.navBarView];
    [self.navBarView addSubview:self.backButton];
    [self.navBarView addSubview:self.titleLabel];
    
}

#pragma mark - backButton's action.

- (void)backBtnClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(backButtonDidClick:)]) {
        [self.delegate backButtonDidClick:self];
    }
}

#pragma mark - lazy.

- (UIView *)navBarView {
    if (!_navBarView) {
        _navBarView = [[UIView alloc] initWithFrame:self.bounds];
    }
    return _navBarView;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, self.bounds.size.height-32, 50, 20)];
        _backButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_backButton setImage:[UIImage imageNamed:@"icon-back"] forState:UIControlStateNormal];
        [_backButton setTitle:@"返回" forState:UIControlStateNormal];
        [_backButton setTitleColor:UIColor.lightGrayColor forState:UIControlStateNormal];
        
        [_backButton addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        // 设置按钮图片和文字间距
        CGFloat space = 5;
        _backButton.titleEdgeInsets = UIEdgeInsetsMake(0, space*0.5, 0, -space*0.5);
        _backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -space*0.5, 0, space*0.5);
    }
    return _backButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, self.bounds.size.height-32, self.bounds.size.width-140, 20)];
        CGPoint titleLabelCenter = CGPointMake(_titleLabel.center.x, self.backButton.center.y);
        _titleLabel.center = titleLabelCenter;
        _titleLabel.text = @"";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end

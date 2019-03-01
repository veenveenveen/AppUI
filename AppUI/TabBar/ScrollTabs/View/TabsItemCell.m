//
//  TabsItemCell.m
//  AppUI
//
//  Created by Himin on 2019/1/18.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "TabsItemCell.h"

@interface TabsItemCell ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UIView *bottomMark;

@property (nonatomic, readwrite, assign) BOOL markVisible;

@end

@implementation TabsItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.backgroundColor = UIColor.clearColor;
    self.markVisible = NO;// 默认不可见
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.textLabel];
    [self.contentView addSubview:self.bottomMark];
}

- (void)setupDataWith:(UIImage *)image text:(NSString *)text {
    self.imgView.image = image;
    self.textLabel.text = text;
}

- (void)hiddenBottomMark {
    self.markVisible = NO;
    [UIView animateWithDuration:0.1 animations:^{
        self.bottomMark.alpha = 0;
    } completion:^(BOOL finished) {
        self.bottomMark.hidden = YES;
    }];
}

- (void)showBottomMark {
    self.markVisible = YES;
    [UIView animateWithDuration:0.1 animations:^{
        self.bottomMark.alpha = 1;
    } completion:^(BOOL finished) {
        self.bottomMark.hidden = NO;
    }];
}

#pragma mark -

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-22, cellWidth, 20)];
        _textLabel.font = [UIFont systemFontOfSize:14];
        _textLabel.textColor = UIColor.lightGrayColor;
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _textLabel;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cellWidth, self.bounds.size.height-22)];
        _imgView.contentMode = UIViewContentModeCenter;
    }
    return _imgView;
}

- (UIView *)bottomMark {
    if (!_bottomMark) {
        _bottomMark = [[UIView alloc] initWithFrame:CGRectMake(10, self.bounds.size.height-2, cellWidth-20, 2)];
        _bottomMark.backgroundColor = UIColor.darkGrayColor;
        _bottomMark.hidden = YES;
        _bottomMark.alpha = 0;
    }
    return _bottomMark;
}

@end

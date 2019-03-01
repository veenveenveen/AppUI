//
//  TableViewTapAnimationCell.m
//  Animations
//
//  Created by YouXianMing on 15/11/27.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "TableViewTapAnimationCell.h"
#import "TapAnimationModel.h"

// cell高度
const CGFloat tapAnimationCellHeight = 60;

static CGFloat nameLabelHeight = 40;
static CGFloat iconViewHeight = 30;
static CGFloat rectViewHeight = 28;

typedef NS_ENUM(NSUInteger, ETableViewTapAnimationCellState) {
    kNormalState,
    kSelectedState
};

@interface TableViewTapAnimationCell ()

@property (nonatomic, strong) UILabel      *name;
@property (nonatomic, strong) UIImageView  *iconView;
@property (nonatomic, strong) UIView       *lineView;
@property (nonatomic, strong) UIView       *rectView;

@end

@implementation TableViewTapAnimationCell

#pragma mark - 重写父类的方法

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    _rectView = [[UIView alloc] initWithFrame:CGRectMake(width - 60, (tapAnimationCellHeight-rectViewHeight)*0.5, rectViewHeight, rectViewHeight)];
    _rectView.layer.borderWidth = 1.f;
    _rectView.layer.borderColor = [UIColor grayColor].CGColor;
    [self addSubview:_rectView];
    
    _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(width - 62, (tapAnimationCellHeight-iconViewHeight)*0.5, iconViewHeight, iconViewHeight)];
    _iconView.image = [UIImage imageNamed:@"plane"];
    _iconView.alpha = 0.f;
    [self addSubview:_iconView];
    
    _name = [[UILabel alloc] initWithFrame:CGRectMake(30, (tapAnimationCellHeight-nameLabelHeight)*0.5, width-30-70, nameLabelHeight)];
    _name.font  = [UIFont FZYingBiKaiShuWithFontSize:20.f];
    _name.textColor = [UIColor grayColor];
    [self addSubview:_name];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(30, tapAnimationCellHeight-5, 0, 2)];
    _lineView.alpha = 0.f;
    _lineView.backgroundColor = [UIColor redColor];
    [self addSubview:_lineView];
}

- (void)loadContent {
    
    TapAnimationModel *model = self.dataAdapter.data;
    self.name.text           = model.name;
    model.selected ? ([self changeToState:kSelectedState animated:NO]) : ([self changeToState:kNormalState animated:NO]);
}

- (void)selectedEvent {
    [self showSelectedAnimation];
    TapAnimationModel *model = self.dataAdapter.data;
    model.selected ? ((void)(model.selected = NO), [self changeToState:kNormalState animated:YES]) : ((void)(model.selected = YES), [self changeToState:kSelectedState animated:YES]);
}

#pragma mark - private animation

- (void)changeToState:(ETableViewTapAnimationCellState)state animated:(BOOL)animated {
    
    if (state == kNormalState) {
        
        [UIView animateWithDuration:animated ? 0.5 : 0 delay:0 usingSpringWithDamping:7 initialSpringVelocity:4 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                             
            animated ? [self->_iconView setTransform:CGAffineTransformMake(0.5, 0, 0, 0.5, 0, 0)] : 0;
            
            self->_iconView.alpha     = 0.f;
            self->_lineView.alpha     = 0.f;
            self->_lineView.frame     = CGRectMake(30, tapAnimationCellHeight-5, 0, 2);
            self->_name.frame         = CGRectMake(30, (tapAnimationCellHeight-nameLabelHeight)*0.5, kScreenWidth-30-70, nameLabelHeight);
            
            self->_rectView.layer.borderColor  = [UIColor grayColor].CGColor;
            self->_rectView.transform          = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
            self->_rectView.layer.cornerRadius = 0;
                             
         } completion:nil];
        
    } else if (state == kSelectedState) {
        
        animated ? [_iconView setTransform:CGAffineTransformMake(2, 0, 0, 2, 0, 0)] : 0;
        
        [UIView animateWithDuration:animated ? 0.5 : 0 delay:0 usingSpringWithDamping:7 initialSpringVelocity:4 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                             
            self->_iconView.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
            self->_iconView.alpha     = 1.f;
            self->_lineView.alpha     = 1.f;
            self->_lineView.frame     = CGRectMake(30, tapAnimationCellHeight-5, 200, 2);
            self->_name.frame         = CGRectMake(30 + 30, (tapAnimationCellHeight-40)*0.5, kScreenWidth-30-100, 40);
            
            self->_rectView.layer.borderColor  = [UIColor redColor].CGColor;
            self->_rectView.transform          = CGAffineTransformMake(0.8, 0, 0, 0.8, 0, 0);
            self->_rectView.layer.cornerRadius = 4.f;
            
        } completion:nil];
    }
}

- (void)showSelectedAnimation {
    
    UIView *tmpView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, tapAnimationCellHeight)];
    tmpView.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:0.20];
    tmpView.alpha           = 0.f;
    [self addSubview:tmpView];
    
    [UIView animateWithDuration:0.20 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        tmpView.alpha = 0.8f;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.20 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            tmpView.alpha = 0.f;
            
        } completion:^(BOOL finished) {
            
            [tmpView removeFromSuperview];
        }];
    }];
}

@end

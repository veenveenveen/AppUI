//
//  LEMRectPageControl.m
//  AppUI
//
//  Created by Himin on 2019/1/24.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "LEMRectPageControl.h"

static CGFloat itemSpace = 4.f;
static CGFloat itemHeight = 2.f;
static CGFloat itemWidth = 12.f;
static NSTimeInterval animationDuration = 0.3f;

@interface LEMRectPageControl ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, copy) NSArray<UIView *> *rectArray;

@property (nonatomic, strong) UIView *previousView;
@property (nonatomic, strong) UIView *currentView;

@end

@implementation LEMRectPageControl

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // default setting
        _numberOfPages = 0;
        _currentPage = 0;
        _hidesForSinglePage = NO;
        _pageIndicatorTintColor = UIColor.lightGrayColor;
        _currentPageIndicatorTintColor = UIColor.blackColor;
        _rectArray = @[];
        [self buildViews];
    }
    return self;
}

#pragma mark - private

- (void)buildViews {
    [self addSubview:self.contentView];
}

#pragma mark - setter

- (void)setNumberOfPages:(NSInteger)numberOfPages {
    _numberOfPages = numberOfPages > 0 ? numberOfPages : 0;
}

- (void)setCurrentPage:(NSInteger)currentPage {
    if (_numberOfPages <= 0 || currentPage >= _numberOfPages) {
        return;
    }
    
    if (_currentPage != currentPage && currentPage >= 0 && currentPage < self.rectArray.count) {
        self.previousView = [self.rectArray objectAtIndex:_currentPage];
        
        _currentPage = currentPage;
        self.currentView = [self.rectArray objectAtIndex:_currentPage];
        
        // 过渡动画
        [self showAnimation];
    }
    _currentPage = currentPage;
}

- (void)setHidesForSinglePage:(BOOL)hidesForSinglePage {
    _hidesForSinglePage = hidesForSinglePage;
}

#pragma mark - animation

- (void)showAnimation {
    [UIView animateWithDuration:animationDuration animations:^{
        self.previousView.backgroundColor = self.pageIndicatorTintColor;
        self.currentView.backgroundColor = self.currentPageIndicatorTintColor;
    }];
}

#pragma mark - override

- (void)layoutSubviews {
    if (_numberOfPages == 1) {
        self.hidden = _hidesForSinglePage;
    }
    
    if (_numberOfPages > 0) {
        CGFloat width = itemWidth*_numberOfPages + itemSpace*(_numberOfPages-1);
        CGRect rect = CGRectMake((self.bounds.size.width-width)*0.5, (self.bounds.size.height-itemHeight)*0.5, width, itemHeight);
        self.contentView.frame = rect;
    }
    
    NSMutableArray<UIView *> *tmpArray = [@[] mutableCopy];
    for (int i = 0; i < _numberOfPages; i++) {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(i*(itemWidth+itemSpace), 0, itemWidth, itemHeight)];
        v.layer.cornerRadius = itemHeight * 0.5;
        v.backgroundColor = self.pageIndicatorTintColor;
        if (i == self.currentPage) {
            v.backgroundColor = self.currentPageIndicatorTintColor;
            self.previousView = v;
        }
        [self.contentView addSubview:v];
        [tmpArray addObject:v];
    }
    
    self.rectArray = [tmpArray copy];
}

#pragma mark -

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentView.backgroundColor = UIColor.clearColor;
    }
    return _contentView;
}

@end

//
//  LEMCircleNodePageControl.m
//  AppUI
//
//  Created by Himin on 2019/1/24.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "LEMCircleNodePageControl.h"

static CGFloat nodeSpace = 10.f;
static CGFloat nodeSize = 5.f;
static CGFloat nodeScale = 1.4;

static NSTimeInterval animationDuration = 0.5f;

@interface LEMCircleNodePageControl ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, copy) NSArray<UIView *> *viewArray;

@property (nonatomic, strong) UIView *previousView;
@property (nonatomic, strong) UIView *currentView;

@end

@implementation LEMCircleNodePageControl

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // default setting
        _numberOfPages = 0;
        _currentPage = 0;
        _hidesForSinglePage = NO;
        _pageIndicatorTintColor = UIColor.lightGrayColor;
        _currentPageIndicatorTintColor = UIColor.blackColor;
        _viewArray = @[];
        self.backgroundColor = UIColor.clearColor;
        
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
    
    if (_currentPage != currentPage && currentPage >= 0 && currentPage < self.viewArray.count) {
        self.previousView = [self.viewArray objectAtIndex:_currentPage];
        
        _currentPage = currentPage;
        self.currentView = [self.viewArray objectAtIndex:_currentPage];
        
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
        self.previousView.transform = CGAffineTransformIdentity;
        self.currentView.transform = CGAffineTransformMakeScale(nodeScale, nodeScale);
    }];
}

#pragma mark - override

- (void)layoutSubviews {
    if (_numberOfPages == 1) {
        self.hidden = _hidesForSinglePage;
    }
    
    if (_numberOfPages > 0) {
        CGFloat width = nodeSize*_numberOfPages + nodeSpace*(_numberOfPages-1);
        CGRect rect = CGRectMake((self.bounds.size.width-width)*0.5, (self.bounds.size.height-nodeSize)*0.5, width, nodeSize);
        self.contentView.frame = rect;
    }
    
    NSMutableArray<UIView *> *tmpArray = [@[] mutableCopy];
    for (int i = 0; i < _numberOfPages; i++) {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(i*(nodeSize+nodeSpace), 0, nodeSize, nodeSize)];
        v.layer.cornerRadius = nodeSize * 0.5;
        v.backgroundColor = self.pageIndicatorTintColor;
        if (i == self.currentPage) {
            v.backgroundColor = self.currentPageIndicatorTintColor;
            v.transform = CGAffineTransformMakeScale(nodeScale, nodeScale);
            self.previousView = v;
        }
        [self.contentView addSubview:v];
        [tmpArray addObject:v];
    }
    
    self.viewArray = [tmpArray copy];
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

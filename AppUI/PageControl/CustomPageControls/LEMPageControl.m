//
//  LEMPageControl.m
//  AppUI
//
//  Created by Himin on 2019/1/24.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "LEMPageControl.h"

// rect
static CGFloat rectSpace = 4.f;
static CGFloat rectHeight = 2.f;
static CGFloat rectWidth = 12.f;
static NSTimeInterval rectAnimationDuration = 0.3f;

// circleNode
static CGFloat nodeSpace = 10.f;
static CGFloat nodeSize = 5.f;
static CGFloat nodeScale = 1.4;
static NSTimeInterval circleNodeAnimationDuration = 0.5f;

// contentView EdgeInsets UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
UIEdgeInsets const LEMPageControlEdgeInsets = {5.f, 5.f, 5.f, 5.f};//

@interface LEMPageControl ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, copy) NSArray<UIView *> *viewArray;

@property (nonatomic, strong) UIView *previousView;
@property (nonatomic, strong) UIView *currentView;

@end

@implementation LEMPageControl

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // default setting
        _numberOfPages = 0;
        _currentPage = 0;
        _hidesForSinglePage = NO;
        
        _pageIndicatorTintColor = UIColor.lightGrayColor;
        _currentPageIndicatorTintColor = UIColor.blackColor;
        
        _pageControlStyle = LEMPageControlStyleCircleNode;
        _pageControlPosition = LEMPageControlPositionCenter;
        _pageControlDirection = LEMPageControlDirectionHorizontal;
        
        _viewArray = @[];
        
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
        switch (self.pageControlStyle) {
            case LEMPageControlStyleCircleNode:
                [self showCircleNodeAnimation];
                break;
                
            case LEMPageControlStyleRect:
                [self showRectAnimation];
                break;
                
            default:
                break;
        }
        
    }
    _currentPage = currentPage;
}

- (void)setHidesForSinglePage:(BOOL)hidesForSinglePage {
    _hidesForSinglePage = hidesForSinglePage;
}

- (void)setPageControlStyle:(LEMPageControlStyle)pageControlStyle {
    _pageControlStyle = pageControlStyle;
}

- (void)setPageControlPosition:(LEMPageControlPosition)pageControlPosition {
    _pageControlPosition = pageControlPosition;
}

#pragma mark - animation

- (void)showRectAnimation {
    [UIView animateWithDuration:rectAnimationDuration animations:^{
        self.previousView.backgroundColor = self.pageIndicatorTintColor;
        self.currentView.backgroundColor = self.currentPageIndicatorTintColor;
    }];
}

- (void)showCircleNodeAnimation {
    [UIView animateWithDuration:circleNodeAnimationDuration animations:^{
        self.previousView.backgroundColor = self.pageIndicatorTintColor;
        self.currentView.backgroundColor = self.currentPageIndicatorTintColor;
        self.previousView.transform = CGAffineTransformIdentity;
        self.currentView.transform = CGAffineTransformMakeScale(nodeScale, nodeScale);
    }];
}

#pragma mark - override

- (void)layoutSubviews {
    
    if (_numberOfPages <= 0) {
        return;
    }
    
    if (_numberOfPages == 1) {
        self.hidden = _hidesForSinglePage;
    }
    
    NSMutableArray<UIView *> *tmpArray = [@[] mutableCopy];
    
    CGFloat itemWidth = 0;
    CGFloat itemHeight = 0;
    CGFloat itemSpace = 0;
    
    CGFloat originX = 0;
    CGFloat originY = 0;
    
    CGFloat width = 0;
    CGFloat height = 0;
    
    switch (self.pageControlStyle) {
        case LEMPageControlStyleCircleNode:
            itemWidth = nodeSize;
            itemHeight = nodeSize;
            itemSpace = nodeSpace;
            break;
            
        case LEMPageControlStyleRect:
            itemWidth = rectWidth;
            itemHeight = rectHeight;
            itemSpace = rectSpace;
            break;
            
        default:
            break;
    }
    
    switch (self.pageControlDirection) {
        case LEMPageControlDirectionHorizontal:
            
        {
            width = itemWidth*_numberOfPages + itemSpace*(_numberOfPages-1);
            height = itemHeight;
            originY = (self.bounds.size.height-height)*0.5;
            
            switch (self.pageControlPosition) {
                case LEMPageControlPositionLeft:
                    originX = LEMPageControlEdgeInsets.left;
                    DLog(@"originX = %f",originX);
                    break;
                case LEMPageControlPositionCenter:
                    originX = (self.bounds.size.width-width)*0.5;
                    break;
                case LEMPageControlPositionRight:
                    originX = self.bounds.size.width-width-LEMPageControlEdgeInsets.right;
                    break;
                    
                default:
                    break;
            }
            
            self.contentView.frame = CGRectMake(originX, originY, width, height);
            
            for (int i = 0; i < _numberOfPages; i++) {
                CGRect rect = CGRectMake(i*(itemWidth+itemSpace), 0, itemWidth, itemHeight);
                
                UIView *v = [[UIView alloc] initWithFrame:rect];
                v.layer.cornerRadius = itemHeight * 0.5;
                v.backgroundColor = self.pageIndicatorTintColor;
                if (i == self.currentPage) {
                    v.backgroundColor = self.currentPageIndicatorTintColor;
                    if (self.pageControlStyle == LEMPageControlStyleCircleNode) {
                        v.transform = CGAffineTransformMakeScale(nodeScale, nodeScale);
                    }
                    self.previousView = v;
                }
                [self.contentView addSubview:v];
                [tmpArray addObject:v];
            }
        }
            break;
            
        case LEMPageControlDirectionVertical:
        {
            width = itemHeight;
            height = itemWidth*_numberOfPages + itemSpace*(_numberOfPages-1);
            originX = (self.bounds.size.width-width)*0.5;
            
            switch (self.pageControlPosition) {
                case LEMPageControlPositionLeft://top
                    originY = LEMPageControlEdgeInsets.top;
                    DLog(@"originX = %f",originX);
                    break;
                case LEMPageControlPositionCenter:
                    originY = (self.bounds.size.height-height)*0.5;
                    break;
                case LEMPageControlPositionRight://bottom
                    originY = self.bounds.size.height-height-LEMPageControlEdgeInsets.bottom;
                    break;
                    
                default:
                    break;
            }
            
            self.contentView.frame = CGRectMake(originX, originY, width, height);
            
            for (int i = 0; i < _numberOfPages; i++) {
                CGRect rect = CGRectMake(0, i*(itemWidth+itemSpace), itemHeight, itemWidth);
                
                UIView *v = [[UIView alloc] initWithFrame:rect];
                v.layer.cornerRadius = itemHeight * 0.5;
                v.backgroundColor = self.pageIndicatorTintColor;
                if (i == self.currentPage) {
                    v.backgroundColor = self.currentPageIndicatorTintColor;
                    if (self.pageControlStyle == LEMPageControlStyleCircleNode) {
                        v.transform = CGAffineTransformMakeScale(nodeScale, nodeScale);
                    }
                    self.previousView = v;
                }
                [self.contentView addSubview:v];
                [tmpArray addObject:v];
            }
        }
            
            break;
            
        default:
            break;
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

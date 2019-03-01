//
//  LEMScaleScollView.m
//  AppUI
//
//  Created by Himin on 2019/1/22.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "LEMScaleScollView.h"
#import "LEMScaleFlowLayout.h"
#import "LEMScaleCell.h"

// 总共的item数
#define TOTAL_ITEMS_COUNT (self.models.count * 10000) //轮播图使用

static NSString *cellID = @"ScaleScroll_cell";

@interface LEMScaleScollView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) LEMScaleFlowLayout *flowLayout;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, assign) CGFloat dragStartX;
@property (nonatomic, assign) CGFloat dragEndX;

// 当前选中位置
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation LEMScaleScollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setModels:(NSArray<LEMScaleModel *> *)models {
    _models = models;
    self.pageControl.numberOfPages = models.count;
}

#pragma mark - private

- (void)setupViews {
    self.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
}

#pragma mark -
#pragma mark cell scroll
//配置cell居中
- (void)fixCellToCenter {
    //最小滚动距离
    float dragMiniDistance = self.bounds.size.width/20.0f;
    if (_dragStartX -  _dragEndX >= dragMiniDistance) {
        _selectedIndex -= 1;//向右
    }else if(_dragEndX -  _dragStartX >= dragMiniDistance){
        _selectedIndex += 1;//向左
    }
    NSInteger maxIndex = [_collectionView numberOfItemsInSection:0] - 1;
    _selectedIndex = _selectedIndex <= 0 ? 0 : _selectedIndex;
    _selectedIndex = _selectedIndex >= maxIndex ? maxIndex : _selectedIndex;
    
    [self scrollToCenter];
}

//滚动到中间
- (void)scrollToCenter {
    
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    [self updatePageControl];
    
    if ([self.delegate respondsToSelector:@selector(scaleScollViewDidScrollToIndex:)]) {
        [self.delegate scaleScollViewDidScrollToIndex:_selectedIndex];
    }
}

- (void)updatePageControl {
    self.pageControl.currentPage = _selectedIndex;
}

#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.models.count;
//    return TOTAL_ITEMS_COUNT;//轮播图
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LEMScaleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    [cell loadContentWithModel:self.models[indexPath.row]];
//    [cell loadContentWithModel:self.models[indexPath.row%5]];//轮播图
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _selectedIndex = indexPath.row;
    [self scrollToCenter];
    
    if ([self.delegate respondsToSelector:@selector(scaleScollViewDidSelectIndex:)]) {
        [self.delegate scaleScollViewDidSelectIndex:_selectedIndex];
    }
}

#pragma mark - UIScrollView's delegate.

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    DLog(@"scroll content offsetX = %f", scrollView.contentOffset.x);
}

//手指拖动开始
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _dragStartX = scrollView.contentOffset.x;
}

//手指拖动停止
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    _dragEndX = scrollView.contentOffset.x;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self fixCellToCenter];
    });
}

#pragma mark - Init flowLayout. / Init UICollectionView. PageControl.

- (LEMScaleFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[LEMScaleFlowLayout alloc] init];
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        CGRect rect = CGRectMake(0, kNavAndStatusBarHeight+20, self.bounds.size.width, self.bounds.size.height-(kNavAndStatusBarHeight+150));
        _collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:self.flowLayout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        _collectionView.backgroundColor = [UIColor clearColor];
        
        _collectionView.delegate   = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[LEMScaleCell class] forCellWithReuseIdentifier:cellID];
    }
    return _collectionView;
}


- (UIPageControl *)pageControl {
    if(!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(80, CGRectGetMaxY(self.collectionView.frame)+5, self.bounds.size.width-160, 30)];
        
        _pageControl.pageIndicatorTintColor = UIColor.lightGrayColor;
        _pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"643455"];
        _pageControl.userInteractionEnabled = NO;
    }
    return _pageControl;
}

@end

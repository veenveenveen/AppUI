//
//  CarouselView.m
//  AppUI
//
//  Created by Himin on 2019/1/11.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "CarouselView.h"
#import "CarouselFlowLayout.h"
#import "CarouselColorModel.h"

// 总共的item数
#define TOTAL_ITEMS (self.models.count * 10000)

static NSString *cellReuseIdentifier = @"cellReuseIdentifier";

@interface CarouselView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) CarouselFlowLayout *flowLayout;
@property (nonatomic, strong) NSTimer *currentTimer;
@property (nonatomic, readwrite, assign) NSInteger currentPage;
@property (nonatomic, assign) BOOL isAnimating;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, readonly, assign) NSInteger cellCount;

@end

@implementation CarouselView

#pragma mark - life cycle

- (void)dealloc {
    DLog(@"%@, dealloc",[self class]);
}

- (instancetype)initWithFrame:(CGRect)frame models:(NSArray *)data {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = UIColor.orangeColor;
        
        // data setting.
        self.models = data;
        
        // default setting.
        [self defaultSetting];
        
        // add views
        [self setupViews];
    }
    return self;
}

- (void)defaultSetting {
    self.currentPage = 0;
    self.scrollTimeInterval = 3.f;
}

- (void)setupViews {
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
    
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:(TOTAL_ITEMS/2) inSection:0];
    
    [self.collectionView scrollToItemAtIndexPath:newIndexPath
                                atScrollPosition:(self.flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal ? UICollectionViewScrollPositionLeft : UICollectionViewScrollPositionTop)
                                        animated:NO];
}

// Animation

- (void)startLoopAnimation {
    _isAnimating = YES;
    [self setupTimer];
}

- (void)stopLoopAnimation {
    _isAnimating = NO;
    [self invalidateTimer];
}

#pragma mark - Timer's event.

- (void)setupTimer {
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.scrollTimeInterval target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    _currentTimer = timer;
}

- (void)invalidateTimer {
    
    [_currentTimer invalidate];
    _currentTimer = nil;
}

- (void)timerAction {
    
    if (self.models.count == 0) {
        return;
    }
    
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    
    NSInteger newRow = currentIndexPath.row + 1;
    if (newRow >= self.cellCount) {
        newRow = 0;
    }
    
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:newRow inSection:0];
    
    [self.collectionView scrollToItemAtIndexPath:newIndexPath
                                atScrollPosition:(self.flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal ? UICollectionViewScrollPositionLeft : UICollectionViewScrollPositionTop)
                                        animated:YES];
}

#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.cellCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCarouselCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    [cell loadContentWithModel:self.models[indexPath.row % self.models.count]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(carouselView:didSelectedAtIndex:data:)]) {

        [self.delegate carouselView:self didSelectedAtIndex:indexPath.row data:self.models[indexPath.row % self.models.count]];
    }
}

#pragma mark - UIScrollView's delegate.

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if (_isAnimating) {
        
        [self invalidateTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (_isAnimating) {
        
        [self setupTimer];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (self.models.count == 0) {
        return;
    }

    NSInteger newValue = [self currentIndex] % self.models.count;

    if (_currentPage != newValue) {

        _currentPage = newValue;
        
        self.pageControl.currentPage = _currentPage;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(carouselView:didScrollToIndex:data:)]) {

            [self.delegate carouselView:self didScrollToIndex:_currentPage data:self.models[_currentPage]];
        }
    }
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if ([self currentIndex] + 1 > self.cellCount) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath
                                    atScrollPosition:(self.flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal ? UICollectionViewScrollPositionLeft : UICollectionViewScrollPositionTop)
                                            animated:NO];
    }
}

// 计算当前的index
- (NSInteger)currentIndex {
    
    NSInteger index = 0;
    
    if (_flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        
        index = (_collectionView.contentOffset.x + _flowLayout.itemSize.width * 0.5) / _flowLayout.itemSize.width;
        
    } else {
        
        index = (_collectionView.contentOffset.y + _flowLayout.itemSize.height * 0.5) / _flowLayout.itemSize.height;
    }
    
    return index;
}

- (NSInteger)cellCount {
    if (!self.models || self.models.count == 0) {
        return 0;
    }
    return TOTAL_ITEMS;
}

#pragma mark - Init flowLayout. / Init UICollectionView. PageControl.

- (CarouselFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[CarouselFlowLayout alloc] initWithStyle:CarouselStyleNormal scrollDirection:UICollectionViewScrollDirectionHorizontal];
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator   = NO;
        
        _collectionView.pagingEnabled                  = YES;
        _collectionView.backgroundColor                = [UIColor clearColor];
        
        _collectionView.delegate   = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[CustomCarouselCell class] forCellWithReuseIdentifier:cellReuseIdentifier];
    }
    return _collectionView;
}


- (UIPageControl *)pageControl {
    if(!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width-120, self.frame.size.height-30, 120, 30)];
        
        _pageControl.pageIndicatorTintColor = [UIColor blackColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.userInteractionEnabled = NO;
        
        _pageControl.numberOfPages = self.models.count;
    }
    return _pageControl;
}

@end

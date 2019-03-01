//
//  CWCarousel.m
//  CWCarousel
//
//  Created by WangChen on 2018/4/3.
//  Copyright © 2018年 ChenWang. All rights reserved.
//

#import "CWCarousel.h"

@interface CWCarousel ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger        numbers;
@property (nonatomic, assign) NSInteger        currentIndex;
@property (nonatomic, assign) NSInteger        infactIndex;
@property (nonatomic, assign) CGFloat          addHeight;

/**
 当前展示在中间的cell下标
 */
@property (nonatomic, strong) NSIndexPath      *currentIndexPath;

@end
@implementation CWCarousel

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<CWCarouselDelegate>)delegate flowLayout:(CWFlowLayout *)flowLayout {
    
    if (self = [super initWithFrame:frame]) {
        CGFloat addHeight = 0;
        frame.size.height += addHeight;
        self.addHeight = addHeight;
        
        _flowLayout = flowLayout;
        self.delegate = delegate;
        
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void)dealloc {
    DLog(@"%s", __func__);
}

- (void)freshCarousel {
    if([self numbers] <= 0) {
        return;
    }
    [self.collectionView reloadData];
    [self.collectionView layoutIfNeeded];
    [self.collectionView scrollToItemAtIndexPath:[self originIndexPath] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}
#pragma mark - < Scroll Delegate >

/// 将要结束拖拽
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    if(velocity.x > 0) {
        //左滑,下一张
        self.currentIndexPath = [NSIndexPath indexPathForRow:self.currentIndexPath.row + 1 inSection:self.currentIndexPath.section];
    }else if (velocity.x < 0) {
        //右滑,上一张
        self.currentIndexPath = [NSIndexPath indexPathForRow:self.currentIndexPath.row - 1 inSection:self.currentIndexPath.section];
    }else if (velocity.x == 0) {
        //还有一种情况,当滑动后手指按住不放,然后松开,此时的加速度其实是为0的
        [self adjustErrorCell:NO];
    }
}

/// 开始减速
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if(self.currentIndexPath != nil &&
       self.currentIndexPath.row < [self infactNumbers] &&
       self.currentIndexPath.row >= 0) {
        // 中间一张轮播,居中显示
        [self.collectionView scrollToItemAtIndexPath:self.currentIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}

/// 滚动动画完成
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self checkOutofBounds];
}

// 滚动中
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
}

#pragma mark - < Logic Helper >
- (NSIndexPath *)originIndexPath {
    NSInteger centerIndex = [self infactNumbers] / [self numbers];
    if(centerIndex <= 1) {
        self.currentIndexPath = [NSIndexPath indexPathForRow:self.numbers inSection:0];
    }else {
        self.currentIndexPath = [NSIndexPath indexPathForRow:centerIndex / 2 * [self numbers] inSection:0];
    }
    return self.currentIndexPath;
}

- (void)checkOutofBounds {
    // 越界检查
    if(self.currentIndexPath.row == [self infactNumbers] - 1) {
        //最后一张
        NSIndexPath *origin = [self originIndexPath];
        NSInteger index = [self caculateIndex:self.currentIndexPath.row] - 1;
        self.currentIndexPath = [NSIndexPath indexPathForRow:origin.row + index inSection:origin.section];
        [self.collectionView scrollToItemAtIndexPath:self.currentIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }else if(self.currentIndexPath.row == 0) {
        //第一张
        NSIndexPath *origin = [self originIndexPath];
        NSInteger index = [self caculateIndex:self.currentIndexPath.row];
        self.currentIndexPath = [NSIndexPath indexPathForRow:origin.row + index inSection:origin.section];
        [self.collectionView scrollToItemAtIndexPath:self.currentIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }
}

- (void)pageControlClick:(UIPageControl *)sender {
    if (![sender isKindOfClass:[UIPageControl class]]) {
        return;
    }
    NSInteger page = sender.currentPage;
    NSInteger prePage = [self caculateIndex:self.currentIndexPath.row];
    if(page == prePage) {
        return;
    }
    NSIndexPath *indexPath = nil;
    if(prePage - page == [self numbers] - 1) {
        //最后一张跳到第一张
        indexPath = [NSIndexPath indexPathForRow:self.currentIndexPath.row + 1 inSection:0];
    }else if(page - prePage == [self numbers] - 1) {
        //第一张跳到最后一张
        indexPath = [NSIndexPath indexPathForRow:self.currentIndexPath.row - 1 inSection:0];
    }else {
        indexPath = [NSIndexPath indexPathForRow:self.currentIndexPath.row + page - prePage inSection:0];
    }
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    self.currentIndexPath = indexPath;
}

// 实际下标转换成业务需求下标 @param factIndex 实际下标 @return 业务需求下标
- (NSInteger)caculateIndex:(NSInteger)factIndex {
    if (self.numbers <= 0) {
        return 0;
    }
    NSInteger row = factIndex % [self numbers];
    return row;
}

- (void)adjustErrorCell:(BOOL)isScroll {
    NSArray <NSIndexPath *> *indexPaths = [self.collectionView indexPathsForVisibleItems];
    NSMutableArray <UICollectionViewLayoutAttributes *> *attriArr = [NSMutableArray arrayWithCapacity:indexPaths.count];
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UICollectionViewLayoutAttributes *attri = [self.collectionView layoutAttributesForItemAtIndexPath:obj];
        [attriArr addObject:attri];
    }];
    CGFloat centerX = self.collectionView.contentOffset.x + CGRectGetWidth(self.collectionView.frame) * 0.5;
    __block CGFloat minSpace = MAXFLOAT;
    BOOL shouldSet = YES;
    if (self.flowLayout.style != CWCarouselStyle_Normal && indexPaths.count <= 2)
    {
        shouldSet = NO;
    }
    [attriArr enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.zIndex = 0;
        if(ABS(minSpace) > ABS(obj.center.x - centerX) && shouldSet) {
            minSpace = obj.center.x - centerX;
            self.currentIndexPath = obj.indexPath;
        }
    }];
    if(isScroll) {
        [self scrollViewWillBeginDecelerating:self.collectionView];
    }
}

#pragma mark - < Delegate, Datasource >
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor cyanColor];
    UIImageView *imgView = [cell.contentView viewWithTag:666];
    if(!imgView) {
        imgView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
        imgView.tag = 666;
        imgView.backgroundColor = [UIColor redColor];
        [cell.contentView addSubview:imgView];
        cell.layer.masksToBounds = YES;
        cell.layer.cornerRadius = 8;
    }
    
    NSString *name = [NSString stringWithFormat:@"%02ld.jpg", [self caculateIndex:indexPath.row] + 1];
    UIImage *img = [UIImage imageNamed:name];
    if(!img) {
        DLog(@"%@", name);
    }
    [imgView setImage:img];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self numbers] > 0 ? [self infactNumbers] : 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self adjustErrorCell:YES];
    if(self.delegate && [self.delegate respondsToSelector:@selector(CWCarousel:didSelectedAtIndex:)]) {
        [self.delegate CWCarousel:self didSelectedAtIndex:[self caculateIndex:indexPath.row]];
    }
}

#pragma mark - < getter >

- (UICollectionView *)collectionView {
    if(!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.addHeight * 0.5, self.frame.size.width, self.frame.size.height - self.addHeight) collectionViewLayout:self.flowLayout];
        
        _collectionView.backgroundColor = UIColor.clearColor;
        _collectionView.clipsToBounds = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    }
    return _collectionView;
}


- (CWCarouselStyle)style {
    if(self.flowLayout)
    {
        return self.flowLayout.style;
    }
    return CWCarouselStyle_Unknow;
}


// 业务需求需要展示轮播图个数
- (NSInteger)numbers {
    return 5;
}

// 轮播图实际加载视图个数
- (NSInteger)infactNumbers {
    return 10;
}

@end



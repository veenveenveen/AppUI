//
//  ScrollTabs.m
//  AppUI
//
//  Created by Himin on 2019/1/18.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "ScrollTabs.h"
#import "TabsItemCell.h"

static NSString *cellID = @"TabsItemCell_id";
static CGFloat itemSpace = 5;

@interface ScrollTabs () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) NSInteger currentSelectedIndex;

@end

@implementation ScrollTabs

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [self addSubview:self.collectionView];
    [self defaultSetting];
}

- (void)defaultSetting {
    self.currentSelectedIndex = 0;
}

#pragma mark -



#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.tabsDataSource && [self.tabsDataSource respondsToSelector:@selector(numberOfItemsInScrollTabs:)]) {
        return [self.tabsDataSource numberOfItemsInScrollTabs:self];
    }
    return 0;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TabsItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if (!cell) {
        cell = [[TabsItemCell alloc] init];
    }
    
    if (self.tabsDataSource && [self.tabsDataSource respondsToSelector:@selector(numberOfItemsInScrollTabs:)]) {
        [cell setupDataWith:[self.tabsDataSource scrollTabs:self iconAtIndex:indexPath.row] text:[self.tabsDataSource scrollTabs:self textAtIndex:indexPath.row]];
        if (indexPath.row == 0) {
            [cell showBottomMark];
            [self updateColorForItemAtIndex:0];
        }
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tabsDelegate && [self.tabsDelegate respondsToSelector:@selector(scrollTabs:didSelectItemAtIndex:)]) {
        if (indexPath.row == self.currentSelectedIndex) {
            return;
        }
        
        [self.tabsDelegate scrollTabs:self didSelectItemAtIndex:indexPath.row];
        
        // 修改 collectionView 的 contentSize.
        [self scrollItemToCenterAtIndex:indexPath.row];
        
        // 更改 bottomMark.
        NSIndexPath *preIndexPath = [NSIndexPath indexPathForRow:self.currentSelectedIndex inSection:0];
        TabsItemCell *preCell = (TabsItemCell *)[collectionView cellForItemAtIndexPath:preIndexPath];
        [preCell hiddenBottomMark];
        
        TabsItemCell *currentCell = (TabsItemCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [currentCell showBottomMark];
        
        // 修改背景色.
        [self updateColorForItemAtIndex:indexPath.row];
        
        self.currentSelectedIndex = indexPath.row;
    }
}

#pragma mark - 修改 collectionView 的 contentSize

- (void)scrollItemToCenterAtIndex:(NSInteger)index {
    DLog(@"currentSelectedIndex = %zd, now index = %zd",self.currentSelectedIndex,index);
    
    NSInteger count = [self.tabsDataSource numberOfItemsInScrollTabs:self];
    
    if (count <= numberPerPage) {
        return;
    }
    
    CGFloat alignOffsetX = 0;
    // 计算每个cell应该对齐的位置 {count = 8 时, (0 1 2 固定), (5 6 7 固定), (3 4 根据index计算得到)}
    if (index > numberPerPage/2) {
        if (index < [self.tabsDataSource numberOfItemsInScrollTabs:self] - (numberPerPage/2+1)) {
            alignOffsetX = (index - numberPerPage/2) * (cellWidth+itemSpace);
        } else {// 默认每页能看到的个数为5个(TabsItemCell.h中修改) count需要大于5
            alignOffsetX = (count - numberPerPage) * (cellWidth+itemSpace);
        }
    }
    
    [self.collectionView setContentOffset:CGPointMake(alignOffsetX, 0) animated:YES];
}

- (void)updateColorForItemAtIndex:(NSInteger)index {
    // 修改背景色.
    if ([self.tabsDataSource respondsToSelector:@selector(scrollTabs:tintColorAtIndex:)]) {
        self.collectionView.backgroundColor = [[self.tabsDataSource scrollTabs:self tintColorAtIndex:index] colorWithAlphaComponent:0.2];
    }
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    // 解决选中的cell划出屏幕时再点击别的cell, 再滑动让之前的cell出现时cell的bottomMark未消失的情况
    NSArray *cellArr = self.collectionView.visibleCells;
    for (TabsItemCell *cell in cellArr) {
        NSInteger index = [self.collectionView indexPathForCell:cell].row;
        
        if (self.currentSelectedIndex != index && cell.markVisible) {
            [cell hiddenBottomMark];
            DLog(@"hiddenBottomMark");
        }
    }
}

#pragma mark -

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(cellWidth, self.bounds.size.height-6);
        layout.sectionInset = UIEdgeInsetsMake(4, itemSpace, 2, itemSpace);
        layout.minimumLineSpacing = itemSpace;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = UIColor.orangeColor;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerClass:[TabsItemCell class] forCellWithReuseIdentifier:cellID];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}


@end

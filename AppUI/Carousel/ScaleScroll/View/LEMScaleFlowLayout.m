//
//  LEMScaleFlowLayout.m
//  AppUI
//
//  Created by Himin on 2019/1/22.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "LEMScaleFlowLayout.h"

// 居中卡片宽高与屏幕宽高比例
static CGFloat CardWidthScale = 0.72f;
static CGFloat CardHeightScale = 0.9f;

@implementation LEMScaleFlowLayout

// 初始化方法, 该方法是准备布局，会在cell显示之前调用，可以在该方法中设置布局的一些属性，比如滚动方向，cell之间的水平间距，以及行间距等
// 建议在这个方法中做布局的初始化操作，不建议在init方法中初始化，这个时候可能CollectionView还没有创建
- (void)prepareLayout {
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.sectionInset = UIEdgeInsetsMake(0, [self collectionInset], 0, [self collectionInset]);
}

//设置缩放动画
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    //扩大控制范围，防止出现闪屏现象
    CGRect bigRect = rect;
    bigRect.size.width = rect.size.width + 2*[self cellWidth];
    bigRect.origin.x = rect.origin.x - [self cellWidth];
    
    NSArray *arr = [self getCopyOfAttributes:[super layoutAttributesForElementsInRect:bigRect]];
    //屏幕中线
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width/2.0f;
    //刷新cell缩放
    for (UICollectionViewLayoutAttributes *attributes in arr) {
        CGFloat distance = fabs(attributes.center.x - centerX);
        //移动的距离和屏幕宽度的的比例
        CGFloat apartScale = distance/self.collectionView.bounds.size.width;
        //把卡片移动范围固定到 -π/4到 +π/4这一个范围内
        CGFloat scale = fabs(cos(apartScale * M_PI/4));
        //设置cell的缩放 按照余弦函数曲线 越居中越趋近于1
        attributes.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return arr;
}

#pragma mark - getter

- (CGFloat)perScrollDistance {
    return [self cellWidth] + [self cellMargin];
}

#pragma mark -
#pragma mark 配置方法

//卡片宽度
- (CGFloat)cellWidth {
    return self.collectionView.bounds.size.width * CardWidthScale;
}

//卡片间隔
- (CGFloat)cellMargin {
    return (self.collectionView.bounds.size.width - [self cellWidth])/30;
//    return 0;
}

//设置左右缩进
- (CGFloat)collectionInset {
    return (self.collectionView.bounds.size.width - [self cellWidth])/2.0f;
}

#pragma mark -
#pragma mark 约束设定
//设置同一行中cell之间的最小间距
- (CGFloat)minimumLineSpacing {
    return [self cellMargin];
}
//cell大小
- (CGSize)itemSize {
    return CGSizeMake([self cellWidth],self.collectionView.bounds.size.height * CardHeightScale);
}

#pragma mark -
#pragma mark 其他设定
//是否实时刷新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return true;
}

//防止报错 先复制attributes
- (NSArray *)getCopyOfAttributes:(NSArray *)attributes {
    NSMutableArray *copyArr = [NSMutableArray new];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        [copyArr addObject:[attribute copy]];
    }
    return copyArr;
}

@end

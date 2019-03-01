//
//  CarouselFlowLayout.m
//  AppUI
//
//  Created by Himin on 2019/1/12.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "CarouselFlowLayout.h"

@interface CarouselFlowLayout ()
// 默认轮播图宽度
@property (nonatomic, assign) CGFloat defaultItemWidth;
@property (nonatomic, assign) CGFloat factItemSpace;
    
@end

@implementation CarouselFlowLayout

#pragma mark - life cycle.

- (instancetype)initWithStyle:(CarouselStyle)style scrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    if(self = [super init]) {
        self.style = style;
        self.scrollDirection = scrollDirection;
        [self initial];
    }
    return self;
}

- (void)dealloc {
    DLog(@"%s", __func__);
}

- (void)initial {
    self.itemSpace = 0;
    self.minScale = 0.8;
    self.maxScale = 1.2;
}

- (void)prepareLayout {
    switch (self.style) {
        case CarouselStyleNormal: {
            CGFloat width = CGRectGetWidth(self.collectionView.frame);
            CGFloat height = CGRectGetHeight(self.collectionView.frame);
            self.itemWidth = width;
            self.itemSize = CGSizeMake(width, height);
            if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
                self.minimumLineSpacing = self.itemSpace;
            } else {
                self.minimumInteritemSpacing = self.itemSpace;
            }
        }
            break;
        case CarouselStyleCustom1: {
            CGFloat width = self.itemWidth == 0 ? self.defaultItemWidth : self.itemWidth;
            self.itemWidth = width;
            CGFloat height = CGRectGetHeight(self.collectionView.frame);
            self.itemSize = CGSizeMake(width, height);
            if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
                self.minimumLineSpacing = self.itemSpace;
            } else {
                self.minimumInteritemSpacing = self.itemSpace;
            }
            break;
        }
        case CarouselStyleCustom2:
        case CarouselStyleCustom3: {
            CGFloat width = self.itemWidth == 0 ? self.defaultItemWidth : self.itemWidth;
            self.itemWidth = width;
            CGFloat height = CGRectGetHeight(self.collectionView.frame);
            self.itemSize = CGSizeMake(width, self.style == CarouselStyleCustom3 ? height / self.maxScale : height);
            self.factItemSpace = 0;
            if(width * (1 - self.minScale) * 0.5 < self.itemSpace) {
                self.factItemSpace = self.itemSpace - width * (1 - self.minScale) * 0.5;
            }
            self.minimumLineSpacing = self.factItemSpace;
        }
            break;
        default:
            break;
    }
    
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    if(self.style != CarouselStyleNormal &&
       self.style != CarouselStyleUnknow &&
       self.style != CarouselStyleCustom1) {
        NSArray<UICollectionViewLayoutAttributes *> *arr = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
        CGFloat centerX = self.collectionView.contentOffset.x + CGRectGetWidth(self.collectionView.frame) * 0.5;
        CGFloat width = self.itemWidth;
        __block CGFloat maxScale = 0;
        __block UICollectionViewLayoutAttributes *attri = nil;
        [arr enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat space = ABS(obj.center.x - centerX);
            if(space > 0) {
                CGFloat scale = 1;
                if (self.style == CarouselStyleCustom2) {
                    scale = (self.minScale - 1) / (self.itemWidth + self.factItemSpace) * space + 1;
                }else {
                    scale = -((self.maxScale - 1) / width) * space + self.maxScale;
                }
                obj.transform = CGAffineTransformMakeScale(scale, scale);
                if(maxScale < scale) {
                    maxScale = scale;
                    attri = obj;
                }
            }
            obj.zIndex = 0;
        }];
        if (attri) {
            attri.zIndex = 1;
        }
        return arr;
    }else {
        return [super layoutAttributesForElementsInRect:rect];
    }
}

#pragma mark - Property
- (CGFloat)defaultItemWidth {
    switch (self.style) {
        case CarouselStyleUnknow:
        case CarouselStyleNormal:
            return self.collectionView.frame.size.width;
            break;
        case CarouselStyleCustom1:
        case CarouselStyleCustom2:
        case CarouselStyleCustom3:
            return self.collectionView.frame.size.width * 0.75;
            break;
        default:
            break;
    }
}

- (void)setMaxScale:(CGFloat)maxScale {
    _maxScale = maxScale;
    if(maxScale < 1) {
        _maxScale = 1;
    }
}

- (void)setMinScale:(CGFloat)minScale {
    _minScale = minScale;
    if(minScale < 0) {
        _minScale = 0.1;
    }
    if (minScale >= 1) {
        _minScale = 1;
    }
}
    
@end

//
//  LEMColorCarouselFlowLayout.m
//  AppUI
//
//  Created by Himin on 2019/1/22.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "LEMColorCarouselFlowLayout.h"

@interface LEMColorCarouselFlowLayout ()

/**
 * 横向/纵向滚动时,每张轮播图之间的间距
 */
@property (nonatomic, assign) CGFloat itemSpace;

@end

@implementation LEMColorCarouselFlowLayout

#pragma mark - life cycle.

- (instancetype)initWithScrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    if(self = [super init]) {
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
}

- (void)prepareLayout {
    CGFloat width = CGRectGetWidth(self.collectionView.frame);
    CGFloat height = CGRectGetHeight(self.collectionView.frame);
    self.itemSize = CGSizeMake(width, height);
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        self.minimumLineSpacing = self.itemSpace;
    } else {
        self.minimumInteritemSpacing = self.itemSpace;
    }
}

@end

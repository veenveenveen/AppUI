//
//  LEMCarouselView.h
//  AppUI
//
//  Created by Himin on 2019/1/22.
//  Copyright © 2019 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEMColorCarouselCell.h"

NS_ASSUME_NONNULL_BEGIN

@class LEMColorCarouselView;

@protocol LEMColorCarouselDelegate <NSObject>

- (void)carouselView:(LEMColorCarouselView *)carouselView didScrollToIndex:(NSInteger)index data:(LEMColorCarouselModel *)model;
- (void)carouselView:(LEMColorCarouselView *)carouselView didSelectedAtIndex:(NSInteger)index data:(LEMColorCarouselModel *)model;

@end

@interface LEMColorCarouselView : UIView

@property (nonatomic, weak) id<LEMColorCarouselDelegate> delegate;

/**
 *  图片数组
 */
@property (nonatomic, strong) NSArray *models;

/**
 *  滚动时间间隔，默认 3s.
 */
@property (nonatomic, assign) NSTimeInterval  scrollTimeInterval;

/**
 *  Start the loop animation.
 */
- (void)startLoopAnimation;

/**
 *  Stop the loop animation.
 */
- (void)stopLoopAnimation;

/**
 *  Current page value.
 */
@property (nonatomic, readonly, assign) NSInteger currentPage;

- (instancetype)initWithFrame:(CGRect)frame models:(NSArray *)data;

NS_ASSUME_NONNULL_END

@end

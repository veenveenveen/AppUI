//
//  CarouselView.h
//  AppUI
//
//  Created by Himin on 2019/1/11.
//  Copyright © 2019 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCarouselCell.h"

NS_ASSUME_NONNULL_BEGIN

@class CarouselView;

@protocol CarouselViewDelegate <NSObject>

- (void)carouselView:(CarouselView *)carouselView didScrollToIndex:(NSInteger)index data:(CarouselColorModel *)model;
- (void)carouselView:(CarouselView *)carouselView didSelectedAtIndex:(NSInteger)index data:(CarouselColorModel *)model;

@end

@interface CarouselView : UIView

@property (nonatomic, weak) id<CarouselViewDelegate> delegate;

/**
 *  图片数组
 */
@property (nonatomic, strong) NSArray *models;

/**
 *  滚动时间间隔，默认 3s.
 */
@property (nonatomic, assign) NSTimeInterval  scrollTimeInterval;

/**
 *  Stop the loop animation and let the image model's array equal nil.
 */
//- (void)reset;

/**
 *  Before start the loop animation, you should run this method before.
 */
//- (void)prepare;

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

@end

NS_ASSUME_NONNULL_END

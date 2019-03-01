//
//  CarouselFlowLayout.h
//  AppUI
//
//  Created by Himin on 2019/1/12.
//  Copyright © 2019 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CarouselStyle) {
    CarouselStyleUnknow = 0,     /// 未知样式
    CarouselStyleNormal,         /// 普通样式,一张图占用整个屏幕宽度
    CarouselStyleCustom1,        /// 自定义样式一, 中间一张居中,前后2张图有部分内容在屏幕内可以预览到
    CarouselStyleCustom2,        /// 自定义样式二, 中间一张居中,前后2张图有部分内容在屏幕内可以预览到,并且中间一张图正常大小,前后2张图会缩放
    CarouselStyleCustom3,        /// 自定义样式三, 中间一张居中,前后2张图有部分内容在屏幕内可以预览到,中间一张有放大效果,前后2张正常大小
};

@interface CarouselFlowLayout : UICollectionViewFlowLayout

/**
 * 轮播图风格
 */
@property (nonatomic, assign) CarouselStyle style;

/**
 * 横向/纵向滚动时,每张轮播图之间的间距
 * style = CarouselStyleCustom3 样式时设置无效
 */
@property (nonatomic, assign) CGFloat itemSpace;

/**
 * 横向滚动时,每张轮播图的宽度
 * style = CarouselStyleNormal 时设置无效
 */
@property (nonatomic, assign) CGFloat itemWidth;

/**
 * style = CarouselStyleCustom2 有效
 * 前后2张图的缩小比例 (0.0 ~ 1.0)
 * 默认: 0.8
 */
@property (nonatomic, assign) CGFloat minScale;

/**
 * style = CarouselStyleCustom3 有效
 * 中间一张图相对两边的图的放大比例，中间一张的cell的比例始终是原始size, 这个比例是相对两边cell的size的相对比例，该值越大,那么两边的cell就会越小.
 * 默认: 1.2
 */
@property (nonatomic, assign) CGFloat maxScale;

/**
 * 构造方法
 * @param style 轮播图风格
 * @return 实例对象
 */
- (instancetype)initWithStyle:(CarouselStyle)style scrollDirection:(UICollectionViewScrollDirection)scrollDirection;

@end

NS_ASSUME_NONNULL_END

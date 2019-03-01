//
//  CWCarousel.h
//  CWCarousel
//
//  Created by WangChen on 2018/4/3.
//  Copyright © 2018年 ChenWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWCarouselProtocol.h"
#import "CWFlowLayout.h"

@interface CWCarousel : UIView

/**
 相关代理
 */
@property (nonatomic, assign) id <CWCarouselDelegate> _Nullable delegate;

/**
 布局自定义layout
 */
@property (nonatomic, strong, readonly) CWFlowLayout    * _Nonnull flowLayout;


/**
 样式风格
 */
@property (nonatomic, assign, readonly) CWCarouselStyle   style;

/**
 实际的轮播图内容的视图(其实就是基于collectionView实现的)
 */
@property (nonatomic, strong, readonly) UICollectionView  * _Nonnull collectionView;

#pragma mark - < 相关方法 >
/**
 创建实例构造方法

 @param frame 尺寸大小
 @param delegate 代理
 @param flowLayout 自定义flowlayout
 @return 实例对象
 */
- (instancetype _Nullable )initWithFrame:(CGRect)frame
                        delegate:(id<CWCarouselDelegate> _Nullable)delegate
                       flowLayout:(nonnull CWFlowLayout *)flowLayout;

/**
 刷新轮播图
 */
- (void)freshCarousel;

@end

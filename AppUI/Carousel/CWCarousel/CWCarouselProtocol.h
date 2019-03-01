//
//  CWCarouselProtocol.h
//  CWCarousel
//
//  Created by WangChen on 2018/4/3.
//  Copyright © 2018年 ChenWang. All rights reserved.
//

#ifndef CWCarouselProtocol_h
#define CWCarouselProtocol_h

@class CWCarousel;
@protocol CWCarouselDelegate<NSObject>
/**
 轮播图点击代理

 @param carousel 轮播图实例对象
 @param index 被点击的下标
 */
- (void)CWCarousel:(CWCarousel *)carousel didSelectedAtIndex:(NSInteger)index;
@end

#endif /* CWCarouselProtocol_h */



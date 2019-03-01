//
//  LEMTransition.h
//  AppUI
//
//  Created by Himin on 2019/1/25.
//  Copyright © 2019 Himin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LEMTransitionType) {
    LEMTransitionTypeFade,                 // 淡化效果
    LEMTransitionTypePush,                 // push效果
    LEMTransitionTypeReveal,               // 揭开效果
    LEMTransitionTypeMoveIn,               // 覆盖效果
    LEMTransitionTypeCube,                 // 立方体效果
    LEMTransitionTypeSuckEffect,           // 吮吸效果
    LEMTransitionTypeOglFlip,              // 翻转效果
    LEMTransitionTypeRippleEffect,         // 波纹效果
    LEMTransitionTypePageCurl,             // 翻页效果
    LEMTransitionTypePageUnCurl,           // 反翻页效果
    LEMTransitionTypeCameraIrisHollowOpen, // 开镜头效果
    LEMTransitionTypeCameraIrisHollowClose,// 关镜头效果
    LEMTransitionTypeCurlDown,             // 下翻页效果
    LEMTransitionTypeCurlUp,               // 上翻页效果
    LEMTransitionTypeFlipFromLeft,         // 左翻转效果
    LEMTransitionTypeFlipFromRight         // 右翻转效果
};

typedef NS_ENUM(NSUInteger, LEMTransitionSubType) {
    LEMTransitionSubTypeTop,
    LEMTransitionSubTypeLeft,
    LEMTransitionSubTypeBottom,
    LEMTransitionSubTypeRight
};

@interface LEMTransitionAnimation : NSObject

+ (void)transitionWithType:(LEMTransitionType)type onView:(UIView *)view;// default subType: LEMTransitionSubTypeLeft

+ (void)transitionWithType:(LEMTransitionType)type subType:(LEMTransitionSubType)subType onView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END

//
//  LEMToast.h
//  LEMUtility
//
//  Created by Himin on 2018/11/27.
//  Copyright © 2018 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LEMLoadingStyle) {
    LEMLoadingStyleSystem = 0,
    LEMLoadingStyleSandClock = 1,
    LEMLoadingStyleOrbitView = 2
};

@interface LEMToastConfig : NSObject

// 提示的宽度(当有图片时显示的宽度 || 当只有文字时为文字显示的最大宽度)
@property (nonatomic, assign) CGFloat toastWidth;

// 文字
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont  *textFont;

// 图片
@property (nonatomic, assign) CGFloat imageHeight;
@property (nonatomic, assign) UIViewContentMode contentMode;

// 圆角
@property (nonatomic, assign) CGFloat cornerRadius;

@end

@interface LEMToast : NSObject

/* ------ 文字 ------ */

// 只显示文字 (时间默认1.5s)
+ (void)showToastWithText:(NSString *)text;
// 只显示文字
+ (void)showToastWithText:(NSString *)text time:(NSTimeInterval)timeInterval;
// 自定义配置的文字提示
+ (void)showToastWithConfig:(LEMToastConfig *)toastConfig text:(NSString *)text time:(NSTimeInterval)timeInterval;

/* ------ 图片 ------ */

// 只显示图片 (时间默认1.5s)
+ (void)showToastWithImage:(UIImage *)image;
// 只显示图片
+ (void)showToastWithImage:(UIImage *)image time:(NSTimeInterval)timeInterval;
// 自定义配置的图片提示
+ (void)showToastWithConfig:(LEMToastConfig *)toastConfig image:(UIImage *)image time:(NSTimeInterval)timeInterval;

/* ---- 图片和文字 ---- */

// 显示图片和文字提示
+ (void)showToastWithText:(NSString *)text image:(UIImage *)image time:(NSTimeInterval)timeInterval;
// 自定义配置的图片和文字提示
+ (void)showToastWithConfig:(LEMToastConfig *)toastConfig text:(NSString *)text image:(UIImage *)image time:(NSTimeInterval)timeInterval;

/* ---- 自定义显示视图 ---- */
+ (void)showToastWithCustomView:(UIView *)view time:(NSTimeInterval)timeInterval ;

/* ------ 加载 ------ */

// 加载显示
+ (void)showLoading:(LEMLoadingStyle)loadingStyle;
// 加载隐藏
+ (void)hideLoading;

@end

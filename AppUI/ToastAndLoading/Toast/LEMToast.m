//
//  LEMToast.m
//  LEMUtility
//
//  Created by Himin on 2018/11/27.
//  Copyright © 2018 Himin. All rights reserved.
//

#import "LEMToast.h"

#import "SandClockView.h"
#import "XYZOrbitView.h"

#import "UIColor+HexColor.h"
#import "NSString+LEMSize.h"

#define pUIScreenWidth [UIScreen mainScreen].bounds.size.width
#define pUIScreenHeight [UIScreen mainScreen].bounds.size.height
#define pAPPKeyWindow [UIApplication sharedApplication].keyWindow

// 默认背景色
#define pBackgroundColor [UIColor colorWithHexString:@"F6F6F6"];
// 默认文字颜色
#define pTextColor [UIColor colorWithHexString:@"434343"];
// 默认字体
#define pFont [UIFont systemFontOfSize:15];
// 默认(最小)宽度
static CGFloat minWidth = 100;
// 默认圆角半径
static CGFloat defaultRadius = 5;
// 只有图片时的默认高度
static CGFloat viewImageOnlyHeight = 80;
// 允许图片显示的最大、最小高度
static CGFloat maxImageHeight = 50;
static CGFloat minImageHeight = 15;

static NSInteger waitingTime = 0;

@implementation LEMToast

// 只显示文字 (时间默认1.5s)
+ (void)showToastWithText:(NSString *)text {
    [self showToastWithText:text time:1.5];
}
// 只显示文字
+ (void)showToastWithText:(NSString *)text time:(NSTimeInterval)timeInterval {
    [self showToastWithConfig:nil text:text time:timeInterval];
}
// 自定义配置的文字提示
+ (void)showToastWithConfig:(LEMToastConfig *)toastConfig text:(NSString *)text time:(NSTimeInterval)timeInterval {
    [self showToastWithConfig:toastConfig text:text image:nil time:timeInterval];
}

/* ---------------- */

// 只显示图片 (时间默认)
+ (void)showToastWithImage:(UIImage *)image {
    [self showToastWithImage:image time:1.5];
}
// 只显示图片
+ (void)showToastWithImage:(UIImage *)image time:(NSTimeInterval)timeInterval {
    [self showToastWithConfig:nil image:image time:timeInterval];
}
// 自定义配置的图片提示
+ (void)showToastWithConfig:(LEMToastConfig *)toastConfig image:(UIImage *)image time:(NSTimeInterval)timeInterval {
    [self showToastWithConfig:toastConfig text:nil image:image time:timeInterval];
}

#pragma mark - 图片和文字

// 显示图片和文字提示
+ (void)showToastWithText:(NSString *)text image:(UIImage *)image time:(NSTimeInterval)timeInterval {
    [self showToastWithConfig:nil text:text image:image time:timeInterval];
}

// 自定义配置的提示
+ (void)showToastWithConfig:(LEMToastConfig *)toastConfig text:(NSString *)text image:(UIImage *)image time:(NSTimeInterval)timeInterval {
    if ((text == nil || [text isEqualToString:@""]) && image == nil) { return; }// 图片文字同时为空什么也不做
    
    CGFloat toastWidth = minWidth;
    
    UIColor *backgroundColor = pBackgroundColor;
    UIColor *textColor = pTextColor;
    UIFont  *textFont = pFont;
    
    CGFloat imageHeight = image.size.height;
    if (imageHeight < minImageHeight) {
        imageHeight = minImageHeight;
    } else if (imageHeight > maxImageHeight) {
        imageHeight = maxImageHeight;
    }
    UIViewContentMode contentMode = UIViewContentModeScaleAspectFit;
    
    CGFloat cornerRadius = defaultRadius;
    
    if (toastConfig) {
        // 限制最小和最大宽度
        if (toastConfig.toastWidth) {
            if (toastConfig.toastWidth < minWidth) {
                toastWidth = minWidth;
            } else if (toastConfig.toastWidth > (pUIScreenWidth-20)) {
                toastWidth = pUIScreenWidth-20;
            } else {
                toastWidth = toastConfig.toastWidth;
            }
        }
        if (toastConfig.backgroundColor) { backgroundColor = toastConfig.backgroundColor; }
        if (toastConfig.textColor) { textColor = toastConfig.textColor; }
        if (toastConfig.textFont) { textFont = toastConfig.textFont; }
        // 限制图片高度
        if (toastConfig.imageHeight) {
            if (toastConfig.imageHeight) {
                if (toastConfig.imageHeight < minImageHeight) {
                    imageHeight = minImageHeight;
                } else if (toastConfig.imageHeight > maxImageHeight) {
                    imageHeight = maxImageHeight;
                } else {
                    imageHeight = toastConfig.imageHeight;
                }
            }
        }
        if (toastConfig.contentMode) { contentMode = toastConfig.contentMode; }
        // 限制圆角半径
        if (toastConfig.cornerRadius) {
            if (toastConfig.cornerRadius < 0) {
                cornerRadius = 0;
            } else if (toastConfig.cornerRadius > 30) {
                cornerRadius = 30;
            } else {
                cornerRadius = toastConfig.cornerRadius;
            }
        }
    }
    
    [self showToastWithText:text textFont:textFont textColor:textColor image:image imageHeight:imageHeight imageContentMode:contentMode backgroundColor:backgroundColor toastWidth:toastWidth viewCornerRadius:cornerRadius time:timeInterval];
}

+ (void)showToastWithText:(NSString *)text
                 textFont:(UIFont *)textFont
                textColor:(UIColor *)textColor
                    image:(UIImage *)image
              imageHeight:(CGFloat)imageHeight
         imageContentMode:(UIViewContentMode)contentMode
          backgroundColor:(UIColor *)backgroundColor
               toastWidth:(CGFloat)toastWidth
         viewCornerRadius:(CGFloat)radius
                     time:(NSTimeInterval)timeInterval {
    
    UIView *bgView = [[UIView alloc] initWithFrame:pAPPKeyWindow.bounds];
    bgView.backgroundColor = UIColor.clearColor;
    bgView.alpha = 0;
    [pAPPKeyWindow addSubview:bgView];
    
    CGFloat imgOriginY = 0;
    CGFloat imgHeight = 0;
    CGFloat imgWidth = toastWidth;
    
    CGFloat labOriginY = 0;
    CGFloat labHeight = 0;
    
    CGFloat viewWidth = 0;
    CGFloat viewHeight = 0;
    
    CGFloat leftMargin = 10;
    CGFloat verticalMargin = 10;
    CGFloat contentWidth = toastWidth - 2 * leftMargin;
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = backgroundColor;
    view.layer.cornerRadius = radius;
    [bgView addSubview:view];
    
    UIImageView *imgV;
    UILabel *lab;
    
    if (image) {
        viewWidth = imgWidth;
        imgV = [[UIImageView alloc] initWithImage:image];
        imgOriginY = verticalMargin+3;
        imgHeight = imageHeight;
        imgV.frame = CGRectMake(leftMargin, imgOriginY, contentWidth, imgHeight);
        imgV.contentMode = contentMode;
        [view addSubview:imgV];
    }
    
    labOriginY = imgOriginY + imgHeight + verticalMargin;
    
    if (text == nil || [text isEqualToString:@""]) {
        if (image) {
            viewHeight = viewImageOnlyHeight;
            imgV.frame = CGRectMake(leftMargin, (viewHeight-imageHeight)/2, contentWidth, imgHeight);
        }
    } else {
        if (image) {
            labOriginY = imgOriginY + imgHeight + (verticalMargin-3);
        }
        UIFont *font = textFont;
        CGSize labSize = [text sizeWithFont:font maxWidth:contentWidth];
        labHeight = labSize.height;
        
        viewWidth = MAX(viewWidth, labSize.width+2*leftMargin);

        lab = [[UILabel alloc] initWithFrame:CGRectMake((viewWidth-labSize.width)/2, labOriginY, labSize.width, labHeight)];
        lab.text = text;
        lab.font = font;
        lab.textColor = textColor;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.numberOfLines = 0;
        [view addSubview:lab];
        
        viewHeight = labOriginY + labHeight + verticalMargin;
    }
    
    view.frame = CGRectMake((pUIScreenWidth-viewWidth)/2, (pUIScreenHeight-viewHeight)/2, viewWidth, viewHeight);
    view.center = CGPointMake(bgView.center.x, bgView.center.y-50);
    
    view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    [UIView animateWithDuration:0.3 animations:^{
        bgView.alpha = 1;
        view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.3 animations:^{
                bgView.alpha = 0;
                view.transform = CGAffineTransformMakeScale(0.1, 0.1);
            } completion:^(BOOL finished) {
                [bgView removeFromSuperview];
            }];
        });
    }];
}


/* ---- 自定义显示视图 ---- */
+ (void)showToastWithCustomView:(UIView *)view time:(NSTimeInterval)timeInterval  {
    UIView *bgView = [[UIView alloc] initWithFrame:pAPPKeyWindow.bounds];
    bgView.backgroundColor = UIColor.clearColor;
    bgView.alpha = 0;
    [pAPPKeyWindow addSubview:bgView];
    
    [bgView addSubview:view];
    
    view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    [UIView animateWithDuration:0.3 animations:^{
        bgView.alpha = 1;
        view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.3 animations:^{
                bgView.alpha = 0;
                view.transform = CGAffineTransformMakeScale(0.1, 0.1);
            } completion:^(BOOL finished) {
                [bgView removeFromSuperview];
            }];
        });
    }];
}

#pragma mark - 加载Loading

+ (void)showLoading:(LEMLoadingStyle)loadingStyle {
    waitingTime += 1;
    if (waitingTime == 1) {
        UIView *bgView = [[UIView alloc] initWithFrame:pAPPKeyWindow.bounds];
        bgView.backgroundColor = UIColor.clearColor;
        bgView.tag = 110;
        [pAPPKeyWindow addSubview:bgView];
        
        [self loadingViewOn:bgView withLoadingStyle:loadingStyle];
    }
}

+ (void)loadingViewOn:(UIView *)view withLoadingStyle:(LEMLoadingStyle)loadingStyle {
    CGFloat rectWidth = view.frame.size.width;
    CGFloat rectHeight = view.frame.size.height;
    if (loadingStyle == LEMLoadingStyleSystem) {
        
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(rectWidth/2 - 30, rectHeight/2 - 30, 60, 60)];
        v.layer.cornerRadius = 10;
        v.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1.0];
        
        UIActivityIndicatorView *wait = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        wait.color = [UIColor colorWithWhite:0.4 alpha:1];
        wait.center = CGPointMake(v.frame.size.width * 0.5+1, v.frame.size.height * 0.5+1.5);
        [v addSubview:wait];
        
        [wait startAnimating];
        [view addSubview:v];
        
    } else if (loadingStyle == LEMLoadingStyleSandClock) {
        
        SandClockView *sandView = [[SandClockView alloc] initWithFrame:CGRectMake(rectWidth*0.5-30, rectHeight*0.5-30, 60, 60)];
        sandView.tag = 112;
        [view addSubview:sandView];
        [sandView startAnimation];
        
    } else if (loadingStyle == LEMLoadingStyleOrbitView) {
        
        XYZOrbitView *orbitView = [[XYZOrbitView alloc] initWithFrame:CGRectMake(rectWidth*0.5-30, rectHeight*0.5-30, 60, 60)];
        orbitView.tag = 113;
        [view addSubview:orbitView];
        [orbitView launchOrbit];
    }
}

// 隐藏加载
+ (void)hideLoading {
    if (waitingTime > 0) {
        waitingTime -= 1;
    }
    if (waitingTime == 0) {
        if (pAPPKeyWindow.subviews.count > 0) {
            for (UIView *view in pAPPKeyWindow.subviews) {
                //                if (view.tag == 112) {
                //                    if ([view isKindOfClass:[SandClockView class]]) {
                //                        [(SandClockView *)view stopAnimation];
                //                        [view removeFromSuperview];
                //                    }
                //                }
                if (view.tag == 110) {
                    [UIView animateWithDuration:0.25 animations:^{
                        view.alpha = 0;
                    } completion:^(BOOL finished) {
                        [view removeFromSuperview];
                    }];
                }
            }
        }
    }
}

@end

@implementation LEMToastConfig
@end

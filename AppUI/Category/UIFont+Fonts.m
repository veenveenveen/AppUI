//
//  UIFont+Fonts.m
//  

#import "UIFont+Fonts.h"

@implementation UIFont (Fonts)

#pragma mark - Added font.

// 哈天随性字体
+ (UIFont *)HTSuiXingWithFontSize:(CGFloat)size {
    return [UIFont fontWithName:@"HaTian-SuiXing" size:size];
}

// 迷你简细行楷
+ (UIFont *)MNJianxiWithFontSize:(CGFloat)size {
    return [UIFont fontWithName:@"迷你简细行楷" size:size];
}

// 方正楷体简体
+ (UIFont *)FZKaiWithFontSize:(CGFloat)size {
    return [UIFont fontWithName:@"FZKai-Z03S" size:size];
}

// 方正硬笔楷书 YRDZST
+ (UIFont *)FZYingBiKaiShuWithFontSize:(CGFloat)size {
    return [UIFont fontWithName:@"FZYingBiKaiShu-S15" size:size];
}

// 杨任东竹石体 YRDZST
+ (UIFont *)YRDZSTWithFontSize:(CGFloat)size {
    return [UIFont fontWithName:@"YRDZST" size:size];
}

#pragma mark - System font.

+ (UIFont *)AppleSDGothicNeoThinWithFontSize:(CGFloat)size {

    return [UIFont fontWithName:@"AppleSDGothicNeo-Thin" size:size];
}

+ (UIFont *)AvenirWithFontSize:(CGFloat)size {

    return [UIFont fontWithName:@"Avenir" size:size];
}

+ (UIFont *)AvenirLightWithFontSize:(CGFloat)size {

    return [UIFont fontWithName:@"Avenir-Light" size:size];
}

+ (UIFont *)HeitiSCWithFontSize:(CGFloat)size {

    return [UIFont fontWithName:@"Heiti SC" size:size];
}

+ (UIFont *)HelveticaNeueFontSize:(CGFloat)size {

    return [UIFont fontWithName:@"HelveticaNeue" size:size];
}

+ (UIFont *)HelveticaNeueBoldFontSize:(CGFloat)size {
    
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:size];
}

@end

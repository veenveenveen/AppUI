//
//  UIFont+Fonts.h
//  

#import <UIKit/UIKit.h>

@interface UIFont (Fonts)

#pragma mark - Added font.
/**
 *  HaTian-SuiXing (哈天随性字体) font (added by plist).
 *  @param size Font's size.
 *  @return Font.
 */
+ (UIFont *)HTSuiXingWithFontSize:(CGFloat)size;

/**
 *  迷你简细行楷 font (added by plist).
 *  @param size Font's size.
 *  @return Font.
 */
+ (UIFont *)MNJianxiWithFontSize:(CGFloat)size;

/**
 *  方正楷体 font (added by plist).
 *  @param size Font's size.
 *  @return Font.
 */
+ (UIFont *)FZKaiWithFontSize:(CGFloat)size;

/**
 *  方正硬笔楷书 font (added by plist).
 *  @param size Font's size.
 *  @return Font.
 */
+ (UIFont *)FZYingBiKaiShuWithFontSize:(CGFloat)size;

/**
 *  杨任东竹石体 YRDZSTfont (added by plist).
 *  @param size Font's size.
 *  @return Font.
 */
+ (UIFont *)YRDZSTWithFontSize:(CGFloat)size;

#pragma mark - System font.

/**
 *  AppleSDGothicNeo-Thin font.
 *
 *  @param size Font's size.
 *
 *  @return Font.
 */
+ (UIFont *)AppleSDGothicNeoThinWithFontSize:(CGFloat)size;

/**
 *  Avenir font.
 *
 *  @param size Font's size.
 *
 *  @return Font.
 */
+ (UIFont *)AvenirWithFontSize:(CGFloat)size;

/**
 *  Avenir-Light font.
 *
 *  @param size Font's size.
 *
 *  @return Font.
 */
+ (UIFont *)AvenirLightWithFontSize:(CGFloat)size;

/**
 *  Heiti SC font.
 *
 *  @param size Font's size.
 *
 *  @return Font.
 */
+ (UIFont *)HeitiSCWithFontSize:(CGFloat)size;

/**
 *  HelveticaNeue font.
 *
 *  @param size Font's size.
 *
 *  @return Font.
 */
+ (UIFont *)HelveticaNeueFontSize:(CGFloat)size;

/**
 *  HelveticaNeue-Bold font.
 *
 *  @param size Font's size.
 *
 *  @return Font.
 */
+ (UIFont *)HelveticaNeueBoldFontSize:(CGFloat)size;

@end

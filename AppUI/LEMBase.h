//
//  LEMBase.h
//  LEMUtility
//
//  Created by Himin on 2018/11/27.
//  Copyright © 2018 Himin. All rights reserved.
//

// 宏

#ifndef LEMBase_h
#define LEMBase_h

#pragma mark - 是否为空

// 字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO)
// 数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
// 字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
// 是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

#pragma mark - 屏幕宽度与高度、导航栏、TabBar、设备、适配

// 屏宽
#define kMainWidth \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.width)
// 屏高
#define kMainHeight \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.height)
// 屏的size(宽、高)
#define kMainSize \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale) : [UIScreen mainScreen].bounds.size)

// 判断是否为iPhone
#define kIsIPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
// 判断是否为iPad
#define kIsIPad   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
// 屏幕宽高
#define kScreenBounds    ([[UIScreen mainScreen] bounds])
#define kScreenWidth     ([[UIScreen mainScreen] bounds].size.width)
#define kScreenHeight    ([[UIScreen mainScreen] bounds].size.height)
#define kScreenMaxLength (MAX(kScreenWidth, kScreenHeight))
#define kScreenMinLength (MIN(kScreenWidth, kScreenHeight))
// iphone型号：4、5、6(6/7/8)、plus、X(X/XS)、XR(XR/XSMax)
#define kIsIPhone4OrLess (kIsIPhone && kScreenMaxLength < 568.0)
#define kIsIPhone5       (kIsIPhone && kScreenMaxLength == 568.0)
#define kIsIPhone6       (kIsIPhone && kScreenMaxLength == 667.0)
#define kIsIPhonePLUS    (kIsIPhone && kScreenMaxLength == 736.0)
#define kIsIPhoneX       (kIsIPhone && kScreenWidth == 375.0f && kScreenHeight == 812.0f) // X/XS
#define kIsIPhoneXR      (kIsIPhone && kScreenWidth == 414.0f && kScreenHeight == 896.0f) // XR/XSMax
#define kIsFullScreen    (kIsIPhoneX || kIsIPhoneXR) // X/XS/XR/XSMax 全面屏系列

// 底部 安全高度 (iPhoneX)
#define kBottomSafeHeight (kIsFullScreen ? 34 : 0)
// 系统 手势高度 (iPhoneX)
#define kSystemGestureHeight (kIsFullScreen ? 13 : 0)

// TabBar高度
#define kTabBarHeight (49 + kBottomSafeHeight)
// 状态栏高度
//UIApplication.sharedApplication.statusBarFrame.size.height
#define kStatusBarHeight (kIsFullScreen ? 44 : 20)
// 导航栏高度
#define kNavBarHeight 44
// 导航栏+状态栏高度
#define kNavAndStatusBarHeight (kStatusBarHeight + kNavBarHeight)

// 适配 320/568 375/667 414/736
#define kAutoLayoutWidth(w)  (kScreenWidth/375 * w)
#define kAutoLayoutHeigth(h) (kScreenHeight/667 * h)

#pragma mark - 版本号、当前语言

// APP版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
// 系统版本号
#define kSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]
// 获取当前语言
#define kCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

// 检测用户系统版本号
#define kiOS12      (kSystemVersion >= 12.0)
#define kiOS11      (kSystemVersion >= 11.0 && kSystemVersion < 12.0)
#define kiOS10      (kSystemVersion >= 10.0 && kSystemVersion < 11.0)
#define kiOS9       (kSystemVersion >= 9.0 && kSystemVersion < 10.0)
#define kiOS8       (kSystemVersion >= 8.0 && kSystemVersion < 9.0)
#define kiOS12Later (kSystemVersion >= 12.0)
#define kiOS11Later (kSystemVersion >= 11.0)
#define kiOS10Later (kSystemVersion >= 10.0)
#define kiOS9Later  (kSystemVersion >= 9.0)
#define kiOS8Later  (kSystemVersion >= 8.0)

#pragma mark - 单例

// 定义
#define DEF_SINGLETON + (instancetype)sharedInstance;
// 实现
#define IMP_SINGLETON \
+ (instancetype)sharedInstance { \
static id sharedObject = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
sharedObject = [[self alloc] init]; \
}); \
return sharedObject; \
}\
- (id)copyWithZone:(NSZone*)zone{\
return self;\
}

#pragma mark - 一些常用的缩写：

// APP对象（单例对象）
#define kApplication [UIApplication sharedApplication]
// 主窗口（keyWindow）
#define kKeyWindow [UIApplication sharedApplication].keyWindow
// APP对象的delegate
#define kAppDelegate [UIApplication sharedApplication].delegate
// NSUserDefaults实例化
#define kUserDefaults [NSUserDefaults standardUserDefaults]
// 通知中心（单例对象）
#define kNotificationCenter [NSNotificationCenter defaultCenter]

#pragma mark - NSUserDefaults

// NSUserDefaults set/get/remove
#define NSUserDefaultsSet(obj,key) \
[kUserDefaults setObject:obj forKey:key]; \
[kUserDefaults synchronize]

#define NSUserDefaultsGet(key)    [kUserDefaults objectForKey:key]
#define NSUserDefaultsRemove(key) [kUserDefaults removeObjectForKey:key]

#pragma mark - 沙盒路径

// 获取沙盒的Document路径
#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
// 获取沙盒的temp路径
#define kTempPath NSTemporaryDirectory()
// 获取沙盒的Cache路径
#define kCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

#pragma mark - DEBUG

// 开发的时候打印，但是发布的时候不打印的NSLog
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d]\n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#define NSLog(...)
#endif

#pragma mark - 颜色color、图片image、字体font

// RGB格式
#define kRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// RGBA格式 （A：alpha）
#define kRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
// 随机色生成
#define kRandomColor KRGBColor(arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0)
// 16进制形式
#define kColorWithHex(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]
// 清除背景色
#define kClearColor [UIColor clearColor]
// 背景色
#define kBgColor [UIColor colorWithRed:242.0/255.0 green:236.0/255.0 blue:231.0/255.0 alpha:1.0]

// 读取本地图片
#define kLoadImage(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:file ofType:ext]]
// 定义UIImage对象（路径）
#define kImage(name) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:nil]]
// 定义UIImage对象
#define kImageName(str) [UIImage imageNamed:str inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil]

// 字体
#define kSystemFontLight(s) [UIFont systemFontOfSize:s]
#define kSystemFontBold(s)  [UIFont boldSystemFontOfSize:s]
#define kPingFangFontLight(s)   (kiOS9Later ? [UIFont fontWithName:@"PingFangSC-Light" size:s] : kSystemFontLight(s))
#define kPingFangFontRegular(s) (kiOS9Later ? [UIFont fontWithName:@"PingFangSC-Regular" size:s] : kSystemFontLight(s))
#define kPingFangFontBold(s)    (kiOS9Later ? [UIFont fontWithName:@"PingFangSC-Medium" size:s] : kSystemFontBold(s))

#pragma mark - 弱引用/强引用

// 弱引用/强引用
#define kWeakSelf(type) __weak typeof(type) weak##type = type;
#define kStrongSelf(type) __strong typeof(type) type = weak##type;

/**
 Synthsize a weak or strong reference.
 
 Example:
 @weakify(self)
 [self doSomething^{
 @strongify(self)
 if (!self) return;
 ...
 }];
 
 */
#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif

#pragma mark - 角度/弧度

// 由角度转换为弧度
#define kDegreesToRadian(x) (M_PI * (x) / 180.0)
// 由弧度转换为角度
#define kRadianToDegrees(radian) (radian * 180.0) / (M_PI)

#pragma mark - 获取一段时间间隔

// 获取一段时间间隔
#define kStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define kEndTime  NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)

#endif /* LEMBase_h */

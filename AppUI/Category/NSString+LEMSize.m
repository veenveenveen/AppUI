//
//  NSString+LEMSize.m
//  LEMUtility
//
//  Created by Himin on 2018/11/27.
//  Copyright © 2018 Himin. All rights reserved.
//

#import "NSString+LEMSize.h"

@implementation NSString (LEMSize)

// 根据字符串计算的size
- (CGSize)sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth {
    CGRect rect = [self boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{ NSFontAttributeName: font } context:nil];
    return rect.size;
}

// 根据字体计算的一行的文字的高度
+ (CGFloat)oneLineHeightOfTextWithFont:(UIFont *)font {
    
    NSParameterAssert(font);
    
    CGFloat height = 0;
    CGRect rect    = [@"One" boundingRectWithSize:CGSizeMake(200, MAXFLOAT)
                                          options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                       attributes:@{NSFontAttributeName: font}
                                          context:nil];
    
    height = rect.size.height;
    return height;
}

@end

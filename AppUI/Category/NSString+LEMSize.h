//
//  NSString+LEMSize.h
//  LEMUtility
//
//  Created by Himin on 2018/11/27.
//  Copyright © 2018 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LEMSize)

// 根据字符串计算label的size
- (CGSize)sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;

+ (CGFloat)oneLineHeightOfTextWithFont:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END

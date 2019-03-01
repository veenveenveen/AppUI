//
//  LEMTabBarItem.h
//  AppUI
//
//  Created by Himin on 2019/1/19.
//  Copyright © 2019 Himin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LEMTabBarItem : NSObject

@property (nonatomic, strong, nullable) UIImage *itemImage;
@property (nonatomic, strong, nullable) UIImage *leftImage;
@property (nonatomic, strong, nullable) UIImage *rightImage;

- (instancetype)initWithItemImage:(UIImage * _Nullable)itemImage
                    leftItemImage:(UIImage * _Nullable)leftItemImage
                   rightItemImage:(UIImage * _Nullable)rightItemImage;

@end

NS_ASSUME_NONNULL_END

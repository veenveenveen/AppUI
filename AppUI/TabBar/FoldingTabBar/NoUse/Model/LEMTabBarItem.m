//
//  LEMTabBarItem.m
//  AppUI
//
//  Created by Himin on 2019/1/19.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "LEMTabBarItem.h"

@implementation LEMTabBarItem

- (instancetype)initWithItemImage:(UIImage *)itemImage
                    leftItemImage:(UIImage *)leftItemImage
                   rightItemImage:(UIImage *)rightItemImage {
    self = [super init];
    if (self) {
        _itemImage = itemImage;
        _leftImage = leftItemImage;
        _rightImage = rightItemImage;
    }
    return self;
}

@end

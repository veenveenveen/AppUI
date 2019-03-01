//
//  LEMScaleModel.m
//  AppUI
//
//  Created by Himin on 2019/1/22.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "LEMScaleModel.h"

@implementation LEMScaleModel

- (instancetype)initWithImage:(UIImage *)image title:(nonnull NSString *)title {
    if (self = [super init]) {
        self.image = image;
        self.title = title;
    }
    return self;
}

+ (NSArray *)createModels {
    LEMScaleModel *item1 = [[LEMScaleModel alloc] initWithImage:[UIImage imageNamed:@"IMG_0.jpg"] title:@"6F016F"];
    LEMScaleModel *item2 = [[LEMScaleModel alloc] initWithImage:[UIImage imageNamed:@"IMG_1.jpg"] title:@"850ADD"];
    LEMScaleModel *item3 = [[LEMScaleModel alloc] initWithImage:[UIImage imageNamed:@"IMG_2.jpg"] title:@"A03C3C"];
    LEMScaleModel *item4 = [[LEMScaleModel alloc] initWithImage:[UIImage imageNamed:@"IMG_0.jpg"] title:@"3C3CA0"];
    LEMScaleModel *item5 = [[LEMScaleModel alloc] initWithImage:[UIImage imageNamed:@"IMG_1.jpg"] title:@"7B7814"];
    LEMScaleModel *item6 = [[LEMScaleModel alloc] initWithImage:[UIImage imageNamed:@"IMG_2.jpg"] title:@"A03C3C"];
    LEMScaleModel *item7 = [[LEMScaleModel alloc] initWithImage:[UIImage imageNamed:@"IMG_0.jpg"] title:@"6F016F"];
    LEMScaleModel *item8 = [[LEMScaleModel alloc] initWithImage:[UIImage imageNamed:@"IMG_1.jpg"] title:@"850ADD"];
    LEMScaleModel *item9 = [[LEMScaleModel alloc] initWithImage:[UIImage imageNamed:@"IMG_2.jpg"] title:@"A03C3C"];
    return @[item1,item2,item3,item4,item5,item6,item7,item8,item9];
}

@end

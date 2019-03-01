//
//  LEMColorCarouselModel.m
//  AppUI
//
//  Created by Himin on 2019/1/22.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "LEMColorCarouselModel.h"

@implementation LEMColorCarouselModel

- (instancetype)initWithImage:(UIImage *)image hexColor:(nonnull NSString *)hexColor {
    if (self = [super init]) {
        self.image = image;
        self.hexColor = hexColor;
    }
    return self;
}

+ (NSArray *)createModels {
    LEMColorCarouselModel *item1 = [[LEMColorCarouselModel alloc] initWithImage:[UIImage imageNamed:@"01.jpg"] hexColor:@"6F016F"];
    LEMColorCarouselModel *item2 = [[LEMColorCarouselModel alloc] initWithImage:[UIImage imageNamed:@"02.jpg"] hexColor:@"850ADD"];
    LEMColorCarouselModel *item3 = [[LEMColorCarouselModel alloc] initWithImage:[UIImage imageNamed:@"03.jpg"] hexColor:@"A03C3C"];
    LEMColorCarouselModel *item4 = [[LEMColorCarouselModel alloc] initWithImage:[UIImage imageNamed:@"04.jpg"] hexColor:@"3C3CA0"];
    LEMColorCarouselModel *item5 = [[LEMColorCarouselModel alloc] initWithImage:[UIImage imageNamed:@"05.jpg"] hexColor:@"7B7814"];
    return @[item1,item2,item3,item4,item5];
}

@end

//
//  CarouselColorModel.m
//  AppUI
//
//  Created by Himin on 2019/1/11.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "CarouselColorModel.h"

@implementation CarouselColorModel

- (instancetype)initWithImage:(UIImage *)image hexColor:(nonnull NSString *)hexColor {
    if (self = [super init]) {
        self.image = image;
        self.hexColor = hexColor;
    }
    return self;
}

+ (NSArray *)createModels {
    CarouselColorModel *item1 = [[CarouselColorModel alloc] initWithImage:[UIImage imageNamed:@"01.jpg"] hexColor:@"6F016F"];
    CarouselColorModel *item2 = [[CarouselColorModel alloc] initWithImage:[UIImage imageNamed:@"02.jpg"] hexColor:@"850ADD"];
    CarouselColorModel *item3 = [[CarouselColorModel alloc] initWithImage:[UIImage imageNamed:@"03.jpg"] hexColor:@"A03C3C"];
    CarouselColorModel *item4 = [[CarouselColorModel alloc] initWithImage:[UIImage imageNamed:@"04.jpg"] hexColor:@"3C3CA0"];
    CarouselColorModel *item5 = [[CarouselColorModel alloc] initWithImage:[UIImage imageNamed:@"05.jpg"] hexColor:@"7B7814"];
    return @[item1,item2,item3,item4,item5];
}


@end

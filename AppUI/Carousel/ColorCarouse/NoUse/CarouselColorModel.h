//
//  CarouselColorModel.h
//  AppUI
//
//  Created by Himin on 2019/1/11.
//  Copyright © 2019 Himin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CarouselColorModel : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *hexColor;

- (instancetype)initWithImage:(UIImage *)image hexColor:(NSString *)hexColor;

+ (NSArray *)createModels;

@end

NS_ASSUME_NONNULL_END

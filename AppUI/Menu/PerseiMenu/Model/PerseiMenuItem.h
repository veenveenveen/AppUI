//
//  PerseiMenuItem.h
//  AppUI
//
//  Created by Himin on 2019/1/11.
//  Copyright © 2019 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PerseiMenuItem : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *name;

- (instancetype)initWithImage:(UIImage *)image name:(NSString *)name;

+ (NSArray *)createMenuItems;

@end

NS_ASSUME_NONNULL_END

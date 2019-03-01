//
//  LEMFoldingTabBarController.h
//  AppUI
//
//  Created by Himin on 2019/1/19.
//  Copyright © 2019 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LEMFoldingTabBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface LEMFoldingTabBarController : UITabBarController

@property (nonatomic, copy) NSArray *leftBarItems;
@property (nonatomic, copy) NSArray *rightBarItems;
@property (nonatomic, strong) UIImage *centerButtonImage;

@property (nonatomic, assign) CGFloat tabBarViewHeight;

@property (nonatomic, strong) LEMFoldingTabBar *tabBarView;

@end

NS_ASSUME_NONNULL_END

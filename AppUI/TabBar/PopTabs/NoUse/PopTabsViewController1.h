//
//  PopTabsViewController1.h
//  AppUI
//
//  Created by Himin on 2019/1/16.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class PopTabsViewController1;

/*
 * PopTabsViewControllerDataSource 数据源协议
 */
@protocol PopTabsViewControllerDataSource <NSObject>

- (NSInteger)numberOfItemsInController:(PopTabsViewController1 *)controller;
//- (UIViewController *)tabsViewController:(PopTabsViewController1 *)controller viewControllerAtIndex:(NSInteger)index;
//- (NSString *)tabsViewController:(PopTabsViewController1 *)controller titleAtIndex:(NSInteger)index;
- (UIImage *)tabsViewController:(PopTabsViewController1 *)controller iconAtIndex:(NSInteger)index;
- (UIImage *)tabsViewController:(PopTabsViewController1 *)controller hightlightedIconAtIndex:(NSInteger)index;
- (UIColor *)tabsViewController:(PopTabsViewController1 *)controller tintColorAtIndex:(NSInteger)index;

@end

/*
 * PopTabsViewControllerDelegate 代理协议
 */
@protocol PopTabsViewControllerDelegate <NSObject>

- (void)tabsViewController:(PopTabsViewController1 *)controller didSelectItemAtIndex:(NSInteger)index;

@end

/*
 * PopTabsViewController1 Class
 */
@interface PopTabsViewController1 : BaseViewController

@property (nonatomic, weak) id<PopTabsViewControllerDataSource> tabBarDataSource;
@property (nonatomic, weak) id<PopTabsViewControllerDelegate> tabBarDelegate;


@property (nonatomic, strong) UIButton *circleMenuButton;           /* UIButton */

// 加载数据 调用该方法前需要先设置好数据
- (void)reloadData;

@end

NS_ASSUME_NONNULL_END

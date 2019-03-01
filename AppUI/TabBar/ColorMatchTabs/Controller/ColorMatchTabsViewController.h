//
//  ColorMatchTabsViewController.h
//  AppUI
//
//  Created by Himin on 2019/1/14.
//  Copyright © 2019 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ColorMatchTabsViewController;

/*
 * ColorMatchTabsViewController 数据源协议
 */
@protocol ColorMatchTabsViewControllerDataSource <NSObject>

- (NSInteger)numberOfItemsInController:(ColorMatchTabsViewController *)controller;
- (UIViewController *)tabsViewController:(ColorMatchTabsViewController *)controller viewControllerAtIndex:(NSInteger)index;
- (NSString *)tabsViewController:(ColorMatchTabsViewController *)controller titleAtIndex:(NSInteger)index;
- (UIImage *)tabsViewController:(ColorMatchTabsViewController *)controller iconAtIndex:(NSInteger)index;
- (UIImage *)tabsViewController:(ColorMatchTabsViewController *)controller hightlightedIconAtIndex:(NSInteger)index;
- (UIColor *)tabsViewController:(ColorMatchTabsViewController *)controller tintColorAtIndex:(NSInteger)index;

@end

/*
 * ColorMatchTabsViewController 代理协议
 */
@protocol ColorMatchTabsViewControllerDelegate <NSObject>

- (void)tabsViewController:(ColorMatchTabsViewController *)controller didSelectItemAtIndex:(NSInteger)index;

@end

/*
 * ColorMatchTabsViewController Class
 */
@interface ColorMatchTabsViewController : UITabBarController

@property (nonatomic, weak) id<ColorMatchTabsViewControllerDataSource> tabBarDataSource;
@property (nonatomic, weak) id<ColorMatchTabsViewControllerDelegate> tabBarDelegate;

// 加载数据 调用该方法前需要先设置好数据
- (void)reloadData;

@end

NS_ASSUME_NONNULL_END

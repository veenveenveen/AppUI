//
//  PopTabsViewController.h
//  AppUI
//
//  Created by Himin on 2019/1/16.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class PopTabsViewController;

/*
 * PopTabsViewControllerDataSource 数据源协议
 */
@protocol PopTabsViewControllerDataSource <NSObject>

- (NSInteger)numberOfItemsInController:(PopTabsViewController *)controller;
- (UIViewController *)tabsViewController:(PopTabsViewController *)controller viewControllerAtIndex:(NSInteger)index;
- (NSString *)tabsViewController:(PopTabsViewController *)controller titleAtIndex:(NSInteger)index;
- (UIImage *)tabsViewController:(PopTabsViewController *)controller iconAtIndex:(NSInteger)index;
- (UIImage *)tabsViewController:(PopTabsViewController *)controller hightlightedIconAtIndex:(NSInteger)index;
- (UIColor *)tabsViewController:(PopTabsViewController *)controller tintColorAtIndex:(NSInteger)index;

@end

/*
 * PopTabsViewControllerDelegate 代理协议
 */
@protocol PopTabsViewControllerDelegate <NSObject>

- (void)tabsViewController:(PopTabsViewController *)controller didSelectItemAtIndex:(NSInteger)index;

@end

/*
 * PopTabsViewController Class
 */
@interface PopTabsViewController : BaseViewController

@property (nonatomic, weak) id<PopTabsViewControllerDataSource> tabBarDataSource;
@property (nonatomic, weak) id<PopTabsViewControllerDelegate> tabBarDelegate;

@end

NS_ASSUME_NONNULL_END

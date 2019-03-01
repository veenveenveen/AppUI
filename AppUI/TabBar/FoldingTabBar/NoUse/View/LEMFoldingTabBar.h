//
//  LEMFoldingTabBar.h
//  AppUI
//
//  Created by Himin on 2019/1/19.
//  Copyright © 2019 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LEMFoldingTabBar;
@class LEMFoldingTabBarController;

/*
 * LEMFoldingTabBarDataSource, LEMFoldingTabBar数据源协议
 */
@protocol LEMFoldingTabBarDataSource <NSObject>

- (NSArray *)leftTabBarItemsInTabBarView:(LEMFoldingTabBar *)tabBarView;
- (NSArray *)rightTabBarItemsInTabBarView:(LEMFoldingTabBar *)tabBarView;
- (UIImage *)centerImageInTabBarView:(LEMFoldingTabBar *)tabBarView;

@end

/*
 * LEMFoldingTabBarDelegate, LEMFoldingTabBar代理协议
 */
@protocol LEMFoldingTabBarDelegate <NSObject>

//@optional
- (void)tabBar:(LEMFoldingTabBar *)tabBar didSelectItemAtIndex:(NSUInteger)index;
- (BOOL)tabBar:(LEMFoldingTabBar *)tabBar shouldSelectItemAtIndex:(NSUInteger)index;

- (void)tabBarWillFold:(LEMFoldingTabBar *)tabBar;
- (void)tabBarWillExpand:(LEMFoldingTabBar *)tabBar;

- (void)tabBarDidFold:(LEMFoldingTabBar *)tabBar;
- (void)tabBarDidExpand:(LEMFoldingTabBar *)tabBar;

@end

/*
 * TabBar的状态 折叠/展开
 */
typedef NS_ENUM(NSUInteger, LEMTabBarState) {
    LEMTabBarStateFolded,
    LEMTabBarStateExpanded
};

/*
 * LEMFoldingTabBar
 */
@interface LEMFoldingTabBar : UIView

- (instancetype)initWithController:(LEMFoldingTabBarController *)controller;

@property (nonatomic, assign) LEMTabBarState state;
@property (nonatomic, assign) NSUInteger selectedTabBarItemIndex;

@property (nonatomic, copy) UIColor *tabBarColor;
@property (nonatomic, copy) UIColor *dotColor;
@property (nonatomic, assign) UIEdgeInsets tabBarViewEdgeInsets;
@property (nonatomic, assign) UIEdgeInsets tabBarItemsEdgeInsets;
@property (nonatomic, assign) CGFloat extraTabBarItemHeight;
@property (nonatomic, assign) CGFloat offsetForExtraTabBarItems;

@end

NS_ASSUME_NONNULL_END

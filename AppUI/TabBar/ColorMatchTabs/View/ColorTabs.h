//
//  ColorTabs.h
//  AppUI
//
//  Created by Himin on 2019/1/14.
//  Copyright © 2019 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ColorTabs;

/*
 * ColorTabsDataSource
 */
@protocol ColorTabsDataSource <NSObject>

- (NSInteger)numberOfItemsInTabSwitcher:(ColorTabs *)tabSwitcher;
- (NSString *)tabSwitcher:(ColorTabs *)tabSwitcher titleAtIndex:(NSInteger)index;
- (UIImage *)tabSwitcher:(ColorTabs *)tabSwitcher iconAtIndex:(NSInteger)index;
- (UIImage *)tabSwitcher:(ColorTabs *)tabSwitcher hightlightedIconAtIndex:(NSInteger)index;
- (UIColor *)tabSwitcher:(ColorTabs *)tabSwitcher tintColorAtIndex:(NSInteger)index;

@end

/*
 * ColorTabs
 */
@interface ColorTabs : UIControl

@property (nonatomic, weak) id<ColorTabsDataSource> dataSource;

@property (nonatomic, strong) UIColor *titleTextColor;
@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, assign) NSInteger selectedSegmentIndex;

- (void)reloadData;

- (void)scrollMenuDidScrollToIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END

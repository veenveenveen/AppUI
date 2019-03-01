//
//  ScrollTabs.h
//  AppUI
//
//  Created by Himin on 2019/1/18.
//  Copyright © 2019 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ScrollTabs;

/*
 * ScrollTabsDelegate
 */
@protocol ScrollTabsDelegate <NSObject>

- (void)scrollTabs:(ScrollTabs *)scrollTabs didSelectItemAtIndex:(NSInteger)index;

@end

/*
 * ScrollTabsDataSource
 */
@protocol ScrollTabsDataSource <NSObject>

- (NSInteger)numberOfItemsInScrollTabs:(ScrollTabs *)scrollTabs;
- (UIImage *)scrollTabs:(ScrollTabs *)scrollTabs iconAtIndex:(NSInteger)index;
- (NSString *)scrollTabs:(ScrollTabs *)scrollTabs textAtIndex:(NSInteger)index;

@optional

//- (UIViewController *)scrollTabs:(ScrollTabs *)scrollTabs viewControllerAtIndex:(NSInteger)index;
- (UIColor *)scrollTabs:(ScrollTabs *)scrollTabs tintColorAtIndex:(NSInteger)index;

@end

@interface ScrollTabs : UIView

@property (nonatomic, weak) id<ScrollTabsDelegate> tabsDelegate;
@property (nonatomic, weak) id<ScrollTabsDataSource> tabsDataSource;

@end

NS_ASSUME_NONNULL_END

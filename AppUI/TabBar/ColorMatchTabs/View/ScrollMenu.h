//
//  ScrollMenu.h
//  AppUI
//
//  Created by Himin on 2019/1/14.
//  Copyright © 2019 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ScrollMenu;

/*
 * ScrollMenuDelegate
 */
@protocol ScrollMenuDelegate <NSObject>

- (void)scrollMenu:(ScrollMenu *)scrollMenu didScrolledToItemAtIndex:(NSInteger)index;

@end

/*
 * ScrollMenuDataSource
 */
@protocol ScrollMenuDataSource <NSObject>

- (NSInteger)numberOfItemsInScrollMenu:(ScrollMenu *)scrollMenu;
- (UIViewController *)scrollMenu:(ScrollMenu *)scrollMenu viewControllerAtIndex:(NSInteger)index;

@end

/*
 * ScrollMenu
 */
@interface ScrollMenu : UIScrollView

@property (nonatomic, weak) id<ScrollMenuDelegate> scrollMenuDelegate;
@property (nonatomic, weak) id<ScrollMenuDataSource> scrollMenuDataSource;

@property (nonatomic, assign) NSInteger destinationIndex;

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END

//
//  PopoverViewController.h
//  AppUI
//
//  Created by Himin on 2019/1/16.
//  Copyright © 2019 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleMenu.h"

NS_ASSUME_NONNULL_BEGIN

@class PopoverViewController;

/*
 * PopoverViewControllerDelegate
 */
@protocol PopoverViewControllerDelegate <NSObject>

- (void)popoverViewController: (PopoverViewController *)controller didSelectItemAtIndex:(NSInteger)index;

@end

/*
 * PopoverViewControllerDataSource
 */
@protocol PopoverViewControllerDataSource <NSObject>

- (NSInteger)numberOfItemsInPopoverViewController:(PopoverViewController *)controller;
- (UIImage *)popoverViewController:(PopoverViewController *)controller iconAtIndex:(NSInteger)index;
- (UIImage *)popoverViewController:(PopoverViewController *)controller hightlightedIconAtIndex:(NSInteger)index;

@end

@interface PopoverViewController : UIViewController

@property (nonatomic, weak) id<PopoverViewControllerDataSource> popoverDataSource;
@property (nonatomic, weak) id<PopoverViewControllerDelegate> popoverDelegate;

@property (nonatomic, assign) NSInteger highlightedItemIndex;

@property (nonatomic, strong) CircleMenu *menu;

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END

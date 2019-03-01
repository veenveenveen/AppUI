//
//  CircleMenu.h
//  AppUI
//
//  Created by Himin on 2019/1/16.
//  Copyright © 2019 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CircleMenu;

/*
 * CircleMenuDelegate
 */
@protocol CircleMenuDelegate <NSObject>

- (void)circleMenuWillDisplayItems:(CircleMenu *)circleMenu;
- (void)circleMenuWillHideItems:(CircleMenu *)circleMenu;
- (void)circleMenu:(CircleMenu *)circleMenu didSelectItemAtIndex:(NSInteger)index;

@end

/*
 * CircleMenuDataSource
 */
@protocol CircleMenuDataSource <NSObject>

- (NSInteger)numberOfItemsInMenu:(CircleMenu *)circleMenu;
- (UIColor *)circleMenu:(CircleMenu *)circleMenu tintColorAtIndex:(NSInteger)index;

@end

/*
 * CircleMenuDataSource
 */
@interface CircleMenu : UIControl

@property (nonatomic, weak) id<CircleMenuDelegate> delegate;
@property (nonatomic, weak) id<CircleMenuDataSource> dataSource;

@property (nonatomic, strong) UIImage *image;

- (void)reloadData;

- (CGPoint)centerOfItemAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END

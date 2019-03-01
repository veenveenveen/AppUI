//
//  CustomCell.h
//  Animations
//
//  Created by YouXianMing on 16/1/5.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellDataAdapter.h"

@class CustomCell;

/*
 * CustomCellDelegate 协议
 */
@protocol CustomCellDelegate <NSObject>

@optional

// CustomCell's event.
- (void)customCell:(CustomCell *)cell event:(id)event;

@end

/*
 * CustomCell 类
 */
@interface CustomCell : UITableViewCell

#pragma mark - 属性.

// CustomCell's delegate.
@property (nonatomic, weak) id<CustomCellDelegate> delegate;

// CustomCell's dataAdapter.
@property (nonatomic, weak) CellDataAdapter *dataAdapter;

// CustomCell's data.
@property (nonatomic, weak) id data;

// CustomCell's indexPath.
@property (nonatomic, weak) NSIndexPath *indexPath;

// TableView.
@property (nonatomic, weak) UITableView *tableView;

#pragma mark - 使用该类的子类时重写以下方法

- (void)setupCell;

- (void)buildSubview;

- (void)loadContent;

#pragma mark - Useful method.

// cell选中事件, you should use this method in 'tableView:didSelectRowAtIndexPath:' to make it effective.
- (void)selectedEvent;

// Used for delegate event.
- (void)delegateEvent;

#pragma mark - Constructor method.

/**
 *  Create the cell's dataAdapter.
 *
 *  @param reuseIdentifier Cell reuseIdentifier, can be nil.
 *  @param data            Cell's data, can be nil.
 *  @param height          Cell's height.
 *  @param type            Cell's type.
 *
 *  @return Cell's dataAdapter.
 */
+ (CellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier
                                                   data:(id)data
                                             cellHeight:(CGFloat)height
                                                   type:(NSInteger)type;

/**
 *  Create the cell's dataAdapter.
 *
 *  @param reuseIdentifier Cell reuseIdentifier, can be nil.
 *  @param data            Cell's data, can be nil.
 *  @param height          Cell's height.
 *  @param cellWidth       Cell's width.
 *  @param type            Cell's type.
 *
 *  @return Cell's dataAdapter.
 */
+ (CellDataAdapter *)dataAdapterWithCellReuseIdentifier:(NSString *)reuseIdentifier
                                                   data:(id)data
                                             cellHeight:(CGFloat)height
                                              cellWidth:(CGFloat)cellWidth
                                                   type:(NSInteger)type;

#pragma mark - Register cell with tableView.

// Register to tableView with the reuseIdentifier you specified.
+ (void)registerToTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier;

// Register to tableView with the The class name.
+ (void)registerToTableView:(UITableView *)tableView;

@end

//
//  LEMMenuViewController.m
//  AppUI
//
//  Created by Himin on 2019/1/21.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "LEMMenuViewController.h"

static CGFloat cellHeight = 240;

/*
 * MenuItemCell
 */
@interface MenuItemCell : UITableViewCell

+ (CGFloat)cellHeight;
- (void)setupImage:(UIImage *)image;

// private
@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation MenuItemCell

+ (CGFloat)cellHeight {
    return cellHeight;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.backgroundColor = UIColor.clearColor;
    [self.contentView addSubview:self.imgView];
}

- (void)setupImage:(UIImage *)image {
    self.imgView.image = image;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        CGRect rect = CGRectMake(30, 10, kScreenWidth-60, cellHeight-20);
        _imgView = [[UIImageView alloc] initWithFrame:rect];
        _imgView.layer.cornerRadius = 10;
        _imgView.layer.masksToBounds = YES;
        _imgView.contentMode = UIViewContentModeScaleToFill;
    }
    return _imgView;
}

@end

/*
 * ExampleDisplayController
 */

static NSString *cellID = @"cell_id";

@interface LEMMenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray<UIImage *> *imgArray;

@end

@implementation LEMMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imgArray = @[[UIImage imageNamed:@"product_card1"],
                      [UIImage imageNamed:@"product_card2"],
                      [UIImage imageNamed:@"venue_card1"],
                      [UIImage imageNamed:@"venue_card2"]
                      ];
    
    self.view.frame = CGRectMake(0, kNavAndStatusBarHeight, 70, self.view.bounds.size.height-kNavAndStatusBarHeight);
    self.view.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.tableView];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imgArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MenuItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[MenuItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    [cell setupImage:self.imgArray[indexPath.row]];
    return cell;
}

#pragma mark -

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = UIColor.orangeColor;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = [MenuItemCell cellHeight];
        [_tableView registerClass:[MenuItemCell class] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}

@end

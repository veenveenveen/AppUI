//
//  ExampleDisplayController.m
//  AppUI
//
//  Created by Himin on 2019/1/17.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "ExampleDisplayController.h"

static CGFloat cellHeight = 240;

/*
 * ExampleCustomCell
 */
@interface ExampleCustomCell : UITableViewCell

+ (CGFloat)cellHeight;
- (void)setupImage:(UIImage *)image;

// private
@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation ExampleCustomCell

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

@interface ExampleDisplayController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray<UIImage *> *imgArray;

@end

@implementation ExampleDisplayController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imgArray = @[[UIImage imageNamed:@"product_card1"],
                      [UIImage imageNamed:@"product_card2"],
                      [UIImage imageNamed:@"venue_card1"],
                      [UIImage imageNamed:@"venue_card2"]
                      ];

    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-kNavAndStatusBarHeight)];
    [self.view addSubview:self.tableView];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imgArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ExampleCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ExampleCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    [cell setupImage:self.imgArray[indexPath.row]];
    return cell;
}

#pragma mark -

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = UIColor.clearColor;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = [ExampleCustomCell cellHeight];
        [_tableView registerClass:[ExampleCustomCell class] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}

@end

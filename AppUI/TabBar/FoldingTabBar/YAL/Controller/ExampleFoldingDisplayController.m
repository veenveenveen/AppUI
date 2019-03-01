//
//  ExampleFoldingDisplayController.m
//  AppUI
//
//  Created by Himin on 2019/1/21.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "ExampleFoldingDisplayController.h"
#import "YALAnimatingTabBarConstants.h"

static CGFloat cellHeight = 240;

/*
 * ExampleFoldingCustomCell
 */
@interface ExampleFoldingCustomCell : UITableViewCell

+ (CGFloat)cellHeight;
- (void)setupImage:(UIImage *)image;

// private
@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation ExampleFoldingCustomCell

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

static NSString *cellID = @"folding_cell_id";

@interface ExampleFoldingDisplayController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray<UIImage *> *imgArray;

@end

@implementation ExampleFoldingDisplayController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imgArray = @[[UIImage imageNamed:@"product_card1"],
                      [UIImage imageNamed:@"product_card2"],
                      [UIImage imageNamed:@"venue_card1"],
                      [UIImage imageNamed:@"venue_card2"]
                      ];
    
    CGFloat tabBarHeight = YALTabBarViewDefaultHeight;
    self.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-tabBarHeight);

    [self.view addSubview:self.tableView];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imgArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ExampleFoldingCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ExampleFoldingCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
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
        _tableView.rowHeight = [ExampleFoldingCustomCell cellHeight];
        [_tableView registerClass:[ExampleFoldingCustomCell class] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}

@end

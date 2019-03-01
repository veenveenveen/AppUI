//
//  NormalTitleTableViewController.m
//  Animations
//
//  Created by YouXianMing on 2017/7/31.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "NormalTitleTableViewController.h"
#import "TableViewTapAnimationCell.h"
#import "TapAnimationModel.h"

@interface NormalTitleTableViewController () <UITableViewDelegate, UITableViewDataSource, CustomCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation NormalTitleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // automaticallyAdjustsScrollViewInsets = YES 根据所在界面的status bar，navigationbar，与tabbar的高度，自动调整scrollview的 inset
    // 设置为no，不让viewController调整，我们自己修改布局
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupSubViews];
    [self setupDataSource];
}

#pragma mark - private.

- (void)setupDataSource {
    self.adapters = [NSMutableArray array];
    // Models
    NSArray *array = @[[TapAnimationModel modelWithName:@"YouXianMing" selected:YES],
                       [TapAnimationModel modelWithName:@"NoZuoNoDie" selected:NO],
                       [TapAnimationModel modelWithName:@"Animations" selected:NO],
                       [TapAnimationModel modelWithName:@"UITableView状态切换效果" selected:NO],
                       [TapAnimationModel modelWithName:@"YouXianMing" selected:YES],
                       [TapAnimationModel modelWithName:@"NoZuoNoDie" selected:NO],
                       [TapAnimationModel modelWithName:@"Animations" selected:NO],
                       [TapAnimationModel modelWithName:@"UITableView状态切换效果" selected:NO],
                       [TapAnimationModel modelWithName:@"YouXianMing" selected:YES],
                       [TapAnimationModel modelWithName:@"NoZuoNoDie" selected:NO],
                       [TapAnimationModel modelWithName:@"Animations" selected:NO],
                       [TapAnimationModel modelWithName:@"UITableView状态切换效果" selected:NO],
                       [TapAnimationModel modelWithName:@"YouXianMing" selected:YES],
                       [TapAnimationModel modelWithName:@"NoZuoNoDie" selected:NO],
                       [TapAnimationModel modelWithName:@"Animations" selected:NO],
                       [TapAnimationModel modelWithName:@"UITableView状态切换效果" selected:NO],
                       [TapAnimationModel modelWithName:@"YouXianMing" selected:YES],
                       [TapAnimationModel modelWithName:@"NoZuoNoDie" selected:NO],
                       [TapAnimationModel modelWithName:@"Animations" selected:NO],
                       [TapAnimationModel modelWithName:@"UITableView状态切换效果" selected:NO],
                       [TapAnimationModel modelWithName:@"YouXianMing" selected:YES],
                       [TapAnimationModel modelWithName:@"NoZuoNoDie" selected:NO],
                       [TapAnimationModel modelWithName:@"Animations" selected:NO],
                       [TapAnimationModel modelWithName:@"UITableView状态切换效果" selected:NO]];
    
    // Adapters
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self.adapters addObject:[TableViewTapAnimationCell dataAdapterWithCellReuseIdentifier:nil data:array[idx] cellHeight:tapAnimationCellHeight type:0]];
    }];
    DLog(@"familyNames：%@",[UIFont familyNames]);
}

- (void)setupSubViews {
    
    self.tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavAndStatusBarHeight, kScreenWidth, kScreenHeight - kNavAndStatusBarHeight)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    // Register cells
    [TableViewTapAnimationCell registerToTableView:self.tableView];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.adapters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CellDataAdapter *adapter = self.adapters[indexPath.row];
    
    TableViewTapAnimationCell *cell = [tableView dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
    cell.dataAdapter = adapter;
    cell.data        = adapter.data;
    cell.tableView   = tableView;
    cell.indexPath   = indexPath;
    cell.delegate    = self;
    [cell loadContent];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell selectedEvent];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.adapters[indexPath.row].cellHeight;
}

#pragma mark - CustomCellDelegate

- (void)customCell:(CustomCell *)cell event:(id)event {
    DLog(@"event event");
}

@end

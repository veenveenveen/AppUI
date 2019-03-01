//
//  ExampleScaleImageController.m
//  AppUI
//
//  Created by Himin on 2019/1/25.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "ExampleScaleImageController.h"
#import "LEMHeaderIconCell.h"
#import "LEMTableViewCell.h"

static NSString *headerCellReuseID = @"headerCellReuseID";
static NSString *tableViewCellReuseID = @"tableViewCellReuseID";

@interface ExampleScaleImageController () <UITableViewDelegate, UITableViewDataSource, CustomCellDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) NSMutableArray<CellDataAdapter *> *adapters;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) LEMHeaderIconCell *headerCell;

@end

@implementation ExampleScaleImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;

    [self createDataSource];
    [self createTableViewAndRegisterCells];
    [self setupNavBackBtn];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL isHideNav = ([viewController isKindOfClass:[ExampleScaleImageController class]]);
    
    [self.navigationController setNavigationBarHidden:isHideNav animated:YES];
}

#pragma mark - Data source.

- (void)createDataSource {
    
    self.adapters = [NSMutableArray array];
    [self.adapters addObject:[LEMHeaderIconCell dataAdapterWithCellReuseIdentifier:headerCellReuseID data:nil cellHeight:LEMHeaderIconCell.cellHeight type:0]];
    
    for (int i = 0; i < 20; i++) {
        [self.adapters addObject:[LEMTableViewCell dataAdapterWithCellReuseIdentifier:tableViewCellReuseID data:@"table11" cellHeight:LEMTableViewCell.cellHeight type:0]];
    }
    
}

#pragma mark - UITableView related.

- (void)createTableViewAndRegisterCells {
//    self.automaticallyAdjustsScrollViewInsets = NO;
    CGRect rect = CGRectMake(0, -kStatusBarHeight, self.view.bounds.size.width, self.view.bounds.size.height+kStatusBarHeight);
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[LEMHeaderIconCell class] forCellReuseIdentifier:headerCellReuseID];
    [self.tableView registerClass:[LEMTableViewCell class] forCellReuseIdentifier:tableViewCellReuseID];
//    [LEMHeaderIconCell  registerToTableView:self.tableView];
//    [ContentIconCell registerToTableView:self.tableView];
//    [ColorSpaceCell  registerToTableView:self.tableView];
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _adapters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CellDataAdapter *adapter = _adapters[indexPath.row];
    CustomCell *cell  = [tableView dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
    cell.dataAdapter         = adapter;
    cell.data                = adapter.data;
    cell.indexPath           = indexPath;
    cell.tableView           = tableView;
    cell.delegate            = self;
    [cell loadContent];
    
    if (_headerCell == nil && [cell isKindOfClass:[LEMHeaderIconCell class]]) {

        _headerCell = (LEMHeaderIconCell *)cell;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return _adapters[indexPath.row].cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [(CustomCell *)[tableView cellForRowAtIndexPath:indexPath] selectedEvent];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    DLog(@"%f",scrollView.contentOffset.y);
    [_headerCell offsetY:scrollView.contentOffset.y];
}

#pragma mark - CustomCellDelegate

- (void)customCell:(CustomCell *)cell event:(id)event {
    
    DLog(@"%@", event);
}

#pragma mark - 设置返回

- (void)setupNavBackBtn {
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 50, 30)];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [backBtn setImage:[UIImage imageNamed:@"icon-back"] forState:UIControlStateNormal];
    
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backBtn];
}

- (void)backBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

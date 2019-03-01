//
//  ViewController.m
//  AppUI
//
//  Created by Himin on 2019/1/9.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "ViewController.h"
#import "DataModel.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray *dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.lightGrayColor;
    
    // data
    self.dataArr = [DataModel createDataModels];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - action

// did select actions
- (void)didSelectItem:(Item *)item {
    UIViewController *vc = [[item.object alloc] init];
    vc.title = item.name;
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    DataModel *model = self.dataArr[section];
    return model.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    DataModel *model = self.dataArr[indexPath.section];
    Item *item = model.items[indexPath.row];
    
    cell.textLabel.text = item.name;
    cell.textLabel.font = [UIFont HTSuiXingWithFontSize:15];
    cell.detailTextLabel.text = NSStringFromClass(item.object);
    
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    DataModel *model = self.dataArr[section];
//    return model.title;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DataModel *model = self.dataArr[section];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    view.backgroundColor = [UIColor colorWithHexString:@"cddeef"];//eeeefe
    CGRect rect = CGRectMake(13, 0, kScreenWidth-26, 30);
    UILabel *lab = [[UILabel alloc] initWithFrame:rect];
    lab.font = [UIFont FZKaiWithFontSize:18];
    lab.text = model.title;
    lab.textAlignment = NSTextAlignmentCenter;
    [view addSubview:lab];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DataModel *model = self.dataArr[indexPath.section];
    Item *item = model.items[indexPath.row];
    
    DLog(@"section = %zd, row = %zd",indexPath.section,indexPath.row);
    [self didSelectItem:item];
}

#pragma mark - lazy

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 40;
    }
    return _tableView;
}


@end

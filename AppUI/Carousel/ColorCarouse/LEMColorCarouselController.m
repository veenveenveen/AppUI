//
//  LEMColorCarouselController.m
//  AppUI
//
//  Created by Himin on 2019/1/22.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "LEMColorCarouselController.h"
#import "LEMCustomNavView.h"
#import "LEMColorCarouselView.h"
#import "MJRefresh.h"

#define pCarouseHeight 160
#define pFirstCellHeight 160

@interface LEMColorCarouselController () <LEMColorCarouselDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate, LEMCustomNavViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LEMColorCarouselView *carouselView;
@property (nonatomic, strong) LEMCustomNavView *customNavBar;

@property (nonatomic, strong) NSArray<LEMColorCarouselModel *> *models; // 数据

@property (nonatomic, strong) CAShapeLayer *topLayer;

@end

@implementation LEMColorCarouselController

- (void)dealloc {
    [self.carouselView stopLoopAnimation];
    DLog(@"%@, dealloc",[self class]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
    
    self.models = [LEMColorCarouselModel createModels];
    
    [self setupViews];
    [self addRefresh];
}

- (void)setupViews {
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.customNavBar];
    
    // default setting
    self.customNavBar.title = self.title;
    
    LEMColorCarouselModel *startModel = self.models[_carouselView.currentPage];
    [self changeColorWith:startModel];
}

#pragma mark - private

// 根据不同的page改变背景色
- (void)changeColorWith:(LEMColorCarouselModel *)model {
    UIColor *color = [UIColor colorWithHexString:model.hexColor];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.topLayer.fillColor = color.CGColor;
        [self.customNavBar changeBackgroundViewColor:color];
        
    } completion:^(BOOL finished) {}];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL isHideNav = ([viewController isKindOfClass:[LEMColorCarouselController class]]);
    
    [self.navigationController setNavigationBarHidden:isHideNav animated:YES];
}

#pragma mark - CarouselView's delegate.

- (void)carouselView:(LEMColorCarouselView *)carouselView didScrollToIndex:(NSInteger)index data:(nonnull LEMColorCarouselModel *)model {
    DLog(@"current page = %zd", index);
    [self changeColorWith:model];
}

- (void)carouselView:(LEMColorCarouselView *)carouselView didSelectedAtIndex:(NSInteger)index data:(LEMColorCarouselModel *)model {
    DLog(@"selected page = %zd", index);
}

#pragma mark - LEMCustomNavViewDelegate

- (void)backButtonDidClick:(LEMCustomNavView *)customNavView {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

// UITableView's dataSource.
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id_0"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_id_0"];
        }
        [cell.contentView.layer addSublayer:self.topLayer];
        [cell.contentView addSubview:self.carouselView];
        
        return cell;
    } else {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_id"];
        }
        
        cell.textLabel.text = [NSString stringWithFormat:@"string - %zd - %zd",indexPath.section, indexPath.row];
        
        return cell;
    }
}

// 设置header.

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.customNavBar.frame), CGRectGetHeight(self.customNavBar.frame))];
        v.backgroundColor = UIColor.clearColor;
        return v;
    } else {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, CGRectGetWidth(v.frame)-30, 30)];
        lab.textColor = UIColor.brownColor;
        lab.textAlignment = NSTextAlignmentLeft;
        lab.font = [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
        lab.center = CGPointMake(lab.center.x, v.center.y);
        lab.text = [NSString stringWithFormat:@"Section %zd",section];
        
        [v addSubview:lab];
        v.backgroundColor = UIColor.cyanColor;
        return v;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? CGRectGetHeight(self.customNavBar.frame) : 40;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return section == 0 ? @"" : [NSString stringWithFormat:@"section %zd",section];
}

// 设置cell高度.

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return pFirstCellHeight;
    } else {
        return 44;
    }
}

// scrollView's delegate.

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.tableView bringSubviewToFront:self.customNavBar];
    
    if (scrollView.contentOffset.y >= pCarouseHeight-20) {
        [self.customNavBar changeNavViewColor:UIColor.whiteColor];
    } else {
        [self.customNavBar changeNavViewColor:UIColor.clearColor];
    }
    CGFloat originY = scrollView.contentOffset.y;
    DLog(@"originY = %f", originY);
    
    CGRect newFrame = CGRectZero;
    
    if (originY >= -kStatusBarHeight) {
        newFrame = CGRectMake(0, originY+kStatusBarHeight, CGRectGetWidth(self.customNavBar.frame), CGRectGetHeight(self.customNavBar.frame));
    } else {
        newFrame = CGRectMake(0, 0, CGRectGetWidth(self.customNavBar.frame), CGRectGetHeight(self.customNavBar.frame));
    }
    self.customNavBar.frame = newFrame;
    
}

#pragma mark - 设置下拉刷新 refresh

- (void)addRefresh {
    //默认下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    //默认上拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

-(void)refreshData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
}

-(void)loadMoreData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    });
}

#pragma mark - lazy

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -kStatusBarHeight, self.view.bounds.size.width, self.view.bounds.size.height+kStatusBarHeight) style:UITableViewStylePlain];
        DLog(@"self.view.bounds.size.height = %f", self.view.bounds.size.height);
        _tableView.backgroundColor = UIColor.whiteColor;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (LEMColorCarouselView *)carouselView {
    if (!_carouselView) {
        // origin.y pNavBarHeight+10
        _carouselView = [[LEMColorCarouselView alloc] initWithFrame:CGRectMake(15, 0, UIScreen.mainScreen.bounds.size.width-30, pCarouseHeight) models:self.models];
        _carouselView.delegate = self;
        [_carouselView startLoopAnimation];
    }
    return _carouselView;
}

- (LEMCustomNavView *)customNavBar {
    if (!_customNavBar) {
        _customNavBar = [[LEMCustomNavView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavAndStatusBarHeight)];
        _customNavBar.delegate = self;
    }
    return _customNavBar;
}

- (CAShapeLayer *)topLayer {
    if (!_topLayer) {
        _topLayer = [CAShapeLayer layer];
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        CGFloat viewWidth = self.view.bounds.size.width;
        
        // kNavAndStatusBarHeight
        [path moveToPoint:CGPointMake(0, -2)];
        [path addLineToPoint:CGPointMake(0, 40)];
        
        [path addQuadCurveToPoint:CGPointMake(viewWidth, 40) controlPoint:CGPointMake(viewWidth*0.5, 130)];
        
        [path addLineToPoint:CGPointMake(viewWidth, -2)];
        [path closePath];
        
        _topLayer.path = path.CGPath;
        _topLayer.fillColor = UIColor.clearColor.CGColor;
    }
    return _topLayer;
}

@end

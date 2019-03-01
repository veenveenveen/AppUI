//
//  ExampleTabsViewController.m
//  AppUI
//
//  Created by Himin on 2019/1/14.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "ExampleTabsViewController.h"

@interface ExampleTabsViewController () <ColorMatchTabsViewControllerDataSource, ColorMatchTabsViewControllerDelegate>

@property (nonatomic, copy) NSArray<UIImage *> *normalImgArr;
@property (nonatomic, copy) NSArray<UIImage *> *hightlightedImgArr;
@property (nonatomic, copy) NSArray<NSString *> *titleArr;
@property (nonatomic, copy) NSArray<UIColor *> *tintColorArr;

@end

@implementation ExampleTabsViewController

- (void)dealloc {
    DLog(@"dealloc");
}

- (void)viewDidLoad {
    self.tabBarDataSource = self;// 代理在 [super viewDidLoad] 之前设置
    self.tabBarDelegate = self;
    
    // 先设置数据
    self.normalImgArr = @[[UIImage imageNamed:@"products_normal"],
                          [UIImage imageNamed:@"venues_normal"],
                          [UIImage imageNamed:@"reviews_normal"],
                          [UIImage imageNamed:@"users_normal"],
                          ];
    self.hightlightedImgArr = @[[UIImage imageNamed:@"products_highlighted"],
                                [UIImage imageNamed:@"venues_highlighted"],
                                [UIImage imageNamed:@"reviews_highlighted"],
                                [UIImage imageNamed:@"users_highlighted"],
                                ];
    self.titleArr = @[@"Products", @"Places", @"Reviews", @"Friends"];
    self.tintColorArr = @[[UIColor colorWithHexString:@"88B94A"],
                          [UIColor colorWithHexString:@"60B3F2"],
                          [UIColor colorWithHexString:@"EC9C38"],
                          [UIColor colorWithHexString:@"DE898A"]
                          ];
    
    [super viewDidLoad];
    
    // 自定义导航栏返回按钮
    [self setupNavBackBtn];
    
    // 再加载数据
    [self reloadData];
}

#pragma mark -

- (void)setupNavBackBtn {
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 50, 20)];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [backBtn setImage:[UIImage imageNamed:@"icon-back"] forState:UIControlStateNormal];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:UIColor.lightGrayColor forState:UIControlStateNormal];
    
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 设置按钮图片和文字间距
    CGFloat space = 5;
    backBtn.titleEdgeInsets = UIEdgeInsetsMake(0, space*0.5, 0, -space*0.5);
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -space*0.5, 0, space*0.5);
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

- (void)backBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - <ColorMatchTabsViewControllerDataSource, ColorMatchTabsViewControllerDelegate>

- (NSInteger)numberOfItemsInController:(nonnull ColorMatchTabsViewController *)controller {
    return 4;
}

- (nonnull UIImage *)tabsViewController:(nonnull ColorMatchTabsViewController *)controller iconAtIndex:(NSInteger)index {
    return self.normalImgArr[index];
}

- (nonnull UIImage *)tabsViewController:(nonnull ColorMatchTabsViewController *)controller hightlightedIconAtIndex:(NSInteger)index {
    return self.hightlightedImgArr[index];
}

- (nonnull UIColor *)tabsViewController:(nonnull ColorMatchTabsViewController *)controller tintColorAtIndex:(NSInteger)index {
    return self.tintColorArr[index];
}

- (nonnull NSString *)tabsViewController:(nonnull ColorMatchTabsViewController *)controller titleAtIndex:(NSInteger)index {
    return self.titleArr[index];
}

- (nonnull UIViewController *)tabsViewController:(nonnull ColorMatchTabsViewController *)controller viewControllerAtIndex:(NSInteger)index {
    
    UIViewController *vc = [[UIViewController alloc] init];
    
    {
        vc.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-kNavAndStatusBarHeight)];
        vc.view.backgroundColor = [self.tintColorArr[index] colorWithAlphaComponent:0.5];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
        view.backgroundColor = UIColor.whiteColor;
        [vc.view addSubview:view];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:view.bounds];
        lab.text = [NSString stringWithFormat:@"vc %zd",index];
        lab.textAlignment = NSTextAlignmentCenter;
        [view addSubview:lab];
    }
    
    return vc;
}

- (void)tabsViewController:(ColorMatchTabsViewController *)controller didSelectItemAtIndex:(NSInteger)index {
   DLog(@"tabsViewController didSelectItemAtIndex = %zd", index);
}

@end

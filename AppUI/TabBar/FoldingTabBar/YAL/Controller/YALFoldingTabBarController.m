// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project

#import "YALFoldingTabBarController.h"

#import "ExampleFoldingDisplayController.h"

#import "YALTabBarItem.h"
#import "YALFoldingTabBar.h"
#import "YALAnimatingTabBarConstants.h"

@interface YALFoldingTabBarController () <YALTabBarDelegate, YALTabBarDataSource>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, copy) NSArray<UIViewController *> *controllers;

@property (nonatomic, copy) NSArray<NSString *> *titleArr;
@property (nonatomic, copy) NSArray<UIColor *> *tintColorArr;

@end

@implementation YALFoldingTabBarController

#pragma mark - View & LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleArr = @[@"Products", @"Places", @"Reviews", @"Friends"];
    self.tintColorArr = @[[UIColor colorWithHexString:@"88B94A"],
                          [UIColor colorWithHexString:@"60B3F2"],
                          [UIColor colorWithHexString:@"EC9C38"],
                          [UIColor colorWithHexString:@"DE898A"]
                          ];
    
    // 自定义导航栏返回按钮
    [self setupNavBackBtn];
    [self setupNavTitle];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.controllers = @[[[ExampleFoldingDisplayController alloc] init],
                         [[ExampleFoldingDisplayController alloc] init],
                         [[ExampleFoldingDisplayController alloc] init],
                         [[ExampleFoldingDisplayController alloc] init]
                         ];
    [self setupData];
    [self setupTabbar];
    [self setupChildControllersWith:self.controllers];
    
    [self updateSelectedControllerAtIndex:0];
}

#pragma mark - setter

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    self.titleLabel.text = title ;
}

#pragma mark - Private

- (void)setupData {
    //prepare leftBarItems
    YALTabBarItem *item1 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"products_normal"]];
    YALTabBarItem *item2 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"venues_normal"]];
    self.leftBarItems = @[item1, item2];
    
    //prepare rightBarItems
    YALTabBarItem *item3 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"reviews_normal"]];
    YALTabBarItem *item4 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"users_normal"]];
    self.rightBarItems = @[item3, item4];
    
    self.centerButtonImage = [UIImage imageNamed:@"addCircle"];
}

- (void)setupTabbar {
    // 隐藏系统自带的tabbar
    self.tabBar.hidden = YES;
    for (UIView *tabBar in self.tabBar.subviews) {
        [tabBar removeFromSuperview];
    }
    // 设置自定义的tabbar
    [self setupTabBarView];
}

- (void)setupTabBarView {
    self.tabBarView = [[YALFoldingTabBar alloc] initWithController:self];
    
    //custom tabBarView
    self.tabBarView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
//    self.tabBarView.tabBarColor = [UIColor colorWithRed:72.f/255.f green:211.f/255.f blue:178.f/255.f alpha:1.f];
    self.tabBarView.tabBarColor = [UIColor colorWithHexString:@"dddddd"];
    self.tabBarView.tabBarViewEdgeInsets = YALTabBarViewHDefaultEdgeInsets;
    self.tabBarView.tabBarItemsEdgeInsets = YALTabBarViewItemsDefaultEdgeInsets;
    
    CGFloat height = YALTabBarViewDefaultHeight;
    self.tabBarView.frame = CGRectMake(0, self.view.bounds.size.height-height, self.view.bounds.size.width, height);
    [self.view addSubview:self.tabBarView];
}

- (void)setupChildControllersWith:(NSArray<UIViewController *> *)controllers {
    for (UIViewController *vc in controllers) {
        [self addChildViewController:vc];
    }
}

#pragma mark - YALTabBarViewDataSource

- (NSArray *)leftTabBarItemsInTabBarView:(YALFoldingTabBar *)tabBarView {
    return self.leftBarItems;
}

- (NSArray *)rightTabBarItemsInTabBarView:(YALFoldingTabBar *)tabBarView {
    return self.rightBarItems;
}

- (UIImage *)centerImageInTabBarView:(YALFoldingTabBar *)tabBarView {
    return self.centerButtonImage;
}

#pragma mark - YALTabBarViewDelegate

- (void)tabBarWillCollapse:(YALFoldingTabBar *)tabBarView {
}

-(void)tabBarDidCollapse:(YALFoldingTabBar *)tabBarView {
}

-(void)tabBarWillExpand:(YALFoldingTabBar *)tabBarView {
}

- (void)tabBarDidExpand:(YALFoldingTabBar *)tabBarView {
}

- (BOOL)tabBar:(YALFoldingTabBar *)tabBar shouldSelectItemAtIndex:(NSUInteger)index {
    return YES;
}

- (void)tabBar:(YALFoldingTabBar *)tabBar didSelectItemAtIndex:(NSUInteger)index {
    if (self.selectedIndex == index) {
        return;
    }
    
    [self updateSelectedControllerAtIndex:index];
}

- (void)updateSelectedControllerAtIndex:(NSInteger)index {
    DLog(@"did select index = %zd", index);
    self.selectedIndex = index;
    
    self.titleLabel.text = self.titleArr[index];
    self.titleLabel.textColor = self.tintColorArr[index];
//    self.view.backgroundColor = [self.tintColorArr[index] colorWithAlphaComponent:0.2];
    self.selectedViewController.view.backgroundColor = [self.tintColorArr[index] colorWithAlphaComponent:0.2];
}

#pragma mark - 设置导航栏

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

#pragma mark -

- (void)setupNavTitle {
    self.titleLabel.frame = CGRectMake(0, 0, 120, 40);
    self.titleLabel.text = self.title;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = self.titleLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

@end

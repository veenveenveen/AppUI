//
//  ColorMatchTabsViewController.m
//  AppUI
//
//  Created by Himin on 2019/1/14.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "ColorMatchTabsViewController.h"
#import "MenuView.h"

#define pNavBarHeight (UIApplication.sharedApplication.statusBarFrame.size.height + 44)

@interface ColorMatchTabsViewController () <ColorTabsDataSource, ScrollMenuDataSource, ScrollMenuDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) MenuView *menuView;

@property (nonatomic, assign) BOOL scrollEnabled;

@end

@implementation ColorMatchTabsViewController

- (void)loadView {
    [super loadView];
    
    CGRect rect = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
    self.view = [[UIView alloc] initWithFrame:rect];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    
    [self setupAll];
}

- (void)reloadData {
    [self.menuView.tabs reloadData];
    [self.menuView.scrollMenu reloadData];
    [self updateTitleColorForSelectedIndex:0];
}

#pragma mark - override

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    self.titleLabel.text = title ;
}

#pragma setup

- (void)setupAll {
    
    [self.view addSubview:self.menuView];
    
    [self setupNavigationBar];
    [self setupTabSwitcher];
    [self setupScrollMenu];
    [self setupCircleMenu];
    
    [self updateTitleColorForSelectedIndex:0];
    [self updateScrollEnabled:YES];
}

- (void)setupNavigationBar {
    self.navigationController.navigationBar.shadowImage = [UIImage imageNamed:@"TransparentPixel"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Pixel"] forBarMetrics:UIBarMetricsDefault];
    
    self.titleLabel.frame = CGRectMake(0, 0, 120, 40);
    self.titleLabel.text = self.title;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = self.titleLabel;
}

- (void)setupTabSwitcher {
    self.menuView.tabs.selectedSegmentIndex = 0;
    self.menuView.tabs.dataSource = self;
    [self.menuView.tabs addTarget:self action:@selector(changeContent:) forControlEvents:UIControlEventValueChanged];
}

- (void)setupScrollMenu {
    self.menuView.scrollMenu.scrollMenuDataSource = self;
    self.menuView.scrollMenu.scrollMenuDelegate = self;
}

- (void)setupCircleMenu {
    [self.menuView.circleMenuButton addTarget:self action:@selector(showPopover:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - update'method

- (void)updateTitleColorForSelectedIndex:(NSInteger)index {
    if (self.tabBarDataSource && [self.tabBarDataSource respondsToSelector:@selector(tabsViewController:tintColorAtIndex:)]) {
        UIColor *color = [self.tabBarDataSource tabsViewController:self tintColorAtIndex:index];
        self.titleLabel.textColor = color;
        self.menuView.scrollMenu.backgroundColor = [color colorWithAlphaComponent:0.5];//0.2
    }
}

- (void)updateScrollEnabled:(BOOL)scrollEnabled {
    self.menuView.scrollMenu.scrollEnabled = scrollEnabled;
}

#pragma mark - setter

- (void)setScrollEnabled:(BOOL)scrollEnabled {
    [self updateScrollEnabled:scrollEnabled];
}

#pragma mark - circleMenuButton's target. ... ColorTabs's target.

- (void)showPopover:(UIButton *)sender {
    DLog(@"%s",__func__);
}

- (void)changeContent:(ColorTabs *)sender {
    NSInteger index = sender.selectedSegmentIndex;
    [self updateTitleColorForSelectedIndex:index];
    self.menuView.scrollMenu.destinationIndex = index;//
}

#pragma mark - <ColorTabsDataSource>

- (NSInteger)numberOfItemsInTabSwitcher:(nonnull ColorTabs *)tabSwitcher {
    if (self.tabBarDataSource && [self.tabBarDataSource respondsToSelector:@selector(numberOfItemsInController:)]) {
        return [self.tabBarDataSource numberOfItemsInController:self];
    } else {
        return 0;
    }
}

- (nonnull UIImage *)tabSwitcher:(nonnull ColorTabs *)tabSwitcher iconAtIndex:(NSInteger)index {
    if (self.tabBarDataSource && [self.tabBarDataSource respondsToSelector:@selector(tabSwitcher:tintColorAtIndex:)]) {
        return [self.tabBarDataSource tabsViewController:self iconAtIndex:index];
    } else {
        return nil;
    }
}

- (nonnull UIImage *)tabSwitcher:(nonnull ColorTabs *)tabSwitcher hightlightedIconAtIndex:(NSInteger)index {
    if (self.tabBarDataSource && [self.tabBarDataSource respondsToSelector:@selector(tabSwitcher:hightlightedIconAtIndex:)]) {
        return [self.tabBarDataSource tabsViewController:self hightlightedIconAtIndex:index];
    } else {
        return nil;
    }
}

- (nonnull UIColor *)tabSwitcher:(nonnull ColorTabs *)tabSwitcher tintColorAtIndex:(NSInteger)index {
    if (self.tabBarDataSource && [self.tabBarDataSource respondsToSelector:@selector(tabSwitcher:tintColorAtIndex:)]) {
        return [self.tabBarDataSource tabsViewController:self tintColorAtIndex:index];
    } else {
        return nil;
    }
}

- (nonnull NSString *)tabSwitcher:(nonnull ColorTabs *)tabSwitcher titleAtIndex:(NSInteger)index {
    if (self.tabBarDataSource && [self.tabBarDataSource respondsToSelector:@selector(tabSwitcher:titleAtIndex:)]) {
        return [self.tabBarDataSource tabsViewController:self titleAtIndex:index];
    } else {
        return nil;
    }
}

#pragma mark - <ScrollMenuDataSource, ScrollMenuDelegate>

- (NSInteger)numberOfItemsInScrollMenu:(nonnull ScrollMenu *)scrollMenu {
    if (self.tabBarDataSource && [self.tabBarDataSource respondsToSelector:@selector(numberOfItemsInController:)]) {
        return [self.tabBarDataSource numberOfItemsInController:self];
    } else {
        return 0;
    }
}

- (nonnull UIViewController *)scrollMenu:(nonnull ScrollMenu *)scrollMenu viewControllerAtIndex:(NSInteger)index {
    if (self.tabBarDataSource && [self.tabBarDataSource respondsToSelector:@selector(tabsViewController:viewControllerAtIndex:)]) {
        return [self.tabBarDataSource tabsViewController:self viewControllerAtIndex:index];
    } else {
        return [UIViewController new];
    }
}

- (void)scrollMenu:(nonnull ScrollMenu *)scrollMenu didScrolledToItemAtIndex:(NSInteger)index {
    if (self.menuView.tabs.selectedSegmentIndex != index) {
        [self.menuView.tabs scrollMenuDidScrollToIndex:index];
        
        [self updateTitleColorForSelectedIndex:index];
        
        if (self.tabBarDelegate && [self.tabBarDelegate respondsToSelector:@selector(tabsViewController:didSelectItemAtIndex:)]) {
            [self.tabBarDelegate tabsViewController:self didSelectItemAtIndex:index];
        }
    }
}

#pragma mark - lazy

- (MenuView *)menuView {
    if (!_menuView) {
        _menuView = [[MenuView alloc] initWithFrame:CGRectMake(0, pNavBarHeight, self.view.frame.size.width, self.view.frame.size.height-pNavBarHeight)];
    }
    return _menuView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

@end

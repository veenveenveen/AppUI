//
//  ScrollTabViewController.m
//  AppUI
//
//  Created by Himin on 2019/1/18.
//  Copyright © 2019 Himin. All rights reserved.
//

// 使用时可以直接使用ScrollTabs

#import "ScrollTabViewController.h"
#import "ScrollTabView.h"

@interface ScrollTabViewController () <ScrollTabsDataSource, ScrollTabsDelegate>

@property (nonatomic, strong) ScrollTabView *scrollTabView;

@property (nonatomic, copy) NSArray<UIImage *> *normalImgArr;
@property (nonatomic, copy) NSArray<UIImage *> *hightlightedImgArr;
@property (nonatomic, copy) NSArray<NSString *> *titleArr;
@property (nonatomic, copy) NSArray<UIColor *> *tintColorArr;

@end

@implementation ScrollTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    
    // 设置数据
    self.normalImgArr = @[[UIImage imageNamed:@"products_normal"],
                          [UIImage imageNamed:@"venues_normal"],
                          [UIImage imageNamed:@"reviews_normal"],
                          [UIImage imageNamed:@"users_normal"],
                          [UIImage imageNamed:@"products_normal"],
                          [UIImage imageNamed:@"venues_normal"],
                          [UIImage imageNamed:@"reviews_normal"],
                          [UIImage imageNamed:@"users_normal"]
                          ];
    self.hightlightedImgArr = @[[UIImage imageNamed:@"products_highlighted"],
                                [UIImage imageNamed:@"venues_highlighted"],
                                [UIImage imageNamed:@"reviews_highlighted"],
                                [UIImage imageNamed:@"users_highlighted"],
                                [UIImage imageNamed:@"products_highlighted"],
                                [UIImage imageNamed:@"venues_highlighted"],
                                [UIImage imageNamed:@"reviews_highlighted"],
                                [UIImage imageNamed:@"users_highlighted"]
                                ];
    self.titleArr = @[@"Products", @"Places", @"Reviews", @"Friends", @"Products", @"Places", @"Reviews", @"Friends"];
    self.tintColorArr = @[[UIColor colorWithHexString:@"88B94A"],
                          [UIColor colorWithHexString:@"60B3F2"],
                          [UIColor colorWithHexString:@"EC9C38"],
                          [UIColor colorWithHexString:@"DE898A"],
                          [UIColor colorWithHexString:@"88B94A"],
                          [UIColor colorWithHexString:@"60B3F2"],
                          [UIColor colorWithHexString:@"EC9C38"],
                          [UIColor colorWithHexString:@"DE898A"]
                          ];
    
}

- (void)setupViews {
    [self.view addSubview:self.scrollTabView];
}

#pragma mark -

- (ScrollTabView *)scrollTabView {
    if (!_scrollTabView) {
        _scrollTabView = [[ScrollTabView alloc] initWithFrame:CGRectMake(0, kNavAndStatusBarHeight, self.view.bounds.size.width, self.view.bounds.size.height-kNavAndStatusBarHeight)];
        _scrollTabView.scrollTabs.tabsDataSource = self;
        _scrollTabView.scrollTabs.tabsDelegate = self;
    }
    return _scrollTabView;
}


- (NSInteger)numberOfItemsInScrollTabs:(nonnull ScrollTabs *)scrollTabs {
    return self.normalImgArr.count;
}

- (nonnull UIImage *)scrollTabs:(nonnull ScrollTabs *)scrollTabs iconAtIndex:(NSInteger)index {
    return self.normalImgArr[index];
}

- (nonnull NSString *)scrollTabs:(nonnull ScrollTabs *)scrollTabs textAtIndex:(NSInteger)index {
    return self.titleArr[index];
}

- (nonnull UIColor *)scrollTabs:(nonnull ScrollTabs *)scrollTabs tintColorAtIndex:(NSInteger)index {
    return self.tintColorArr[index];
}

- (void)scrollTabs:(ScrollTabs *)scrollTabs didSelectItemAtIndex:(NSInteger)index {
    DLog(@"scrollTabs did selected index = %zd", index);
    // 可以做一些数据的更新并显示
    [self updateDataAtIndex:index];
}

#pragma mark - update data

- (void)updateDataAtIndex:(NSInteger)index {
    
}

@end

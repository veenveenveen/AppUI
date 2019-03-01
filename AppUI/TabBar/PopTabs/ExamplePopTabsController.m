//
//  ExamplePopTabsController.m
//  AppUI
//
//  Created by Himin on 2019/1/16.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "ExamplePopTabsController.h"
#import "ExampleDisplayController.h"

@interface ExamplePopTabsController () <PopTabsViewControllerDataSource, PopTabsViewControllerDelegate>

@property (nonatomic, copy) NSArray<UIImage *> *normalImgArr;
@property (nonatomic, copy) NSArray<UIImage *> *hightlightedImgArr;
@property (nonatomic, copy) NSArray<NSString *> *titleArr;
@property (nonatomic, copy) NSArray<UIColor *> *tintColorArr;

@property (nonatomic, copy) NSArray<UIViewController *> *controllers;

@end

@implementation ExamplePopTabsController

- (void)viewDidLoad {
    self.tabBarDataSource = self;
    self.tabBarDelegate = self;
    
    // 先设置数据
    self.normalImgArr = @[[UIImage imageNamed:@"products_normal"],
                          [UIImage imageNamed:@"venues_normal"],
                          [UIImage imageNamed:@"reviews_normal"],
                          [UIImage imageNamed:@"users_normal"]
                          ];
    self.hightlightedImgArr = @[[UIImage imageNamed:@"products_highlighted"],
                                [UIImage imageNamed:@"venues_highlighted"],
                                [UIImage imageNamed:@"reviews_highlighted"],
                                [UIImage imageNamed:@"users_highlighted"]
                                ];
    self.titleArr = @[@"Products", @"Places", @"Reviews", @"Friends"];
    self.tintColorArr = @[[UIColor colorWithHexString:@"88B94A"],
                          [UIColor colorWithHexString:@"60B3F2"],
                          [UIColor colorWithHexString:@"EC9C38"],
                          [UIColor colorWithHexString:@"DE898A"]
                          ];
    self.controllers = @[[[ExampleDisplayController alloc] init],
                          [[ExampleDisplayController alloc] init],
                          [[ExampleDisplayController alloc] init],
                          [[ExampleDisplayController alloc] init]
                          ];
    
    [super viewDidLoad];
}

#pragma mark - <PopTabsViewControllerDataSource, PopTabsViewControllerDelegate>

- (NSInteger)numberOfItemsInController:(nonnull PopTabsViewController *)controller {
    return self.normalImgArr.count;
}

- (nonnull UIImage *)tabsViewController:(nonnull PopTabsViewController *)controller hightlightedIconAtIndex:(NSInteger)index {
    return self.hightlightedImgArr[index];
}

- (nonnull UIImage *)tabsViewController:(nonnull PopTabsViewController *)controller iconAtIndex:(NSInteger)index {
    return self.normalImgArr[index];
}

- (nonnull NSString *)tabsViewController:(nonnull PopTabsViewController *)controller titleAtIndex:(NSInteger)index {
    return self.titleArr[index];
}

- (nonnull UIColor *)tabsViewController:(nonnull PopTabsViewController *)controller tintColorAtIndex:(NSInteger)index {
    return self.tintColorArr[index];
}

- (nonnull UIViewController *)tabsViewController:(nonnull PopTabsViewController *)controller viewControllerAtIndex:(NSInteger)index {
    if (!self.controllers) {
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
    } else {
        UIViewController *vc = self.controllers[index];
        vc.view.backgroundColor = [self.tintColorArr[index] colorWithAlphaComponent:0.5];
        return vc;
    }
}


- (void)tabsViewController:(nonnull PopTabsViewController *)controller didSelectItemAtIndex:(NSInteger)index {
    DLog(@"tabsViewController didSelectItemAtIndex = %zd", index);
}

@end

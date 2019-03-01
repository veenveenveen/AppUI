//
//  LEMFoldingTabBarController.m
//  AppUI
//
//  Created by Himin on 2019/1/19.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "LEMFoldingTabBarController.h"
#import "ExampleDisplayController.h"

//model
#import "LEMTabBarItem.h"

#import "YALAnimatingTabBarConstants.h"

@interface LEMFoldingTabBarController () <LEMFoldingTabBarDelegate, LEMFoldingTabBarDataSource>


@property (nonatomic, copy) NSArray<UIViewController *> *controllers;

@end

@implementation LEMFoldingTabBarController

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupTabBarView];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setupTabBarView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupTabBarView];
    }
    return self;
}

#pragma mark - View & LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tabBar setBackgroundImage:[[UIImage alloc] init]];
    [self.tabBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.tabBarView.frame = self.tabBar.bounds;
    
    for (UIView *view in self.tabBar.subviews) {
        [view removeFromSuperview];
    }
    
    [self.tabBar addSubview:self.tabBarView];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    
    self.tabBarView.selectedTabBarItemIndex = selectedIndex;
    [self.tabBarView setNeedsLayout];
}

- (void)setTabBarViewHeight:(CGFloat)tabBarViewHeight {
    CGRect newFrame = self.tabBar.frame;
    newFrame.size.height = tabBarViewHeight;
    [self.tabBar setFrame:newFrame];
}

- (CGFloat)tabBarViewHeight {
    return self.tabBar.frame.size.height;
}

#pragma mark - Private

- (void)setupTabBarView {
    for (UIView *view in self.tabBar.subviews) {
        [view removeFromSuperview];
    }
    
    self.tabBarView = [[LEMFoldingTabBar alloc] initWithController:self];
    [self.tabBar addSubview:self.tabBarView];
    
    self.controllers = @[[[ExampleDisplayController alloc] init],
                         [[ExampleDisplayController alloc] init],
                         [[ExampleDisplayController alloc] init],
                         [[ExampleDisplayController alloc] init]
                         ];
}

- (id<LEMFoldingTabBarDelegate>)currentInteractingViewController {
    if ([self.selectedViewController isKindOfClass:[UINavigationController class]]) {
        return (id<LEMFoldingTabBarDelegate>)[(UINavigationController *)self.selectedViewController topViewController];
    } else {
        return (id<LEMFoldingTabBarDelegate>)self.selectedViewController;
    }
}

#pragma mark - LEMTabBarViewDataSource

- (NSArray *)leftTabBarItemsInTabBarView:(LEMFoldingTabBar *)tabBarView {
    return self.leftBarItems;
}

- (NSArray *)rightTabBarItemsInTabBarView:(LEMFoldingTabBar *)tabBarView {
    return self.rightBarItems;
}

- (UIImage *)centerImageInTabBarView:(LEMFoldingTabBar *)tabBarView {
    return self.centerButtonImage;
}

#pragma mark - LEMTabBarViewDelegate

- (void)tabBarWillFold:(LEMFoldingTabBar *)tabBar {
    id<LEMFoldingTabBarDelegate> viewController = [self currentInteractingViewController];
    if ([viewController respondsToSelector:@selector(tabBarWillFold:)]) {
        [viewController tabBarWillFold:self.tabBarView];
    }
}

-(void)tabBarDidFold:(LEMFoldingTabBar *)tabBar {
    id<LEMFoldingTabBarDelegate>viewController = [self currentInteractingViewController];
    if ([viewController respondsToSelector:@selector(tabBarDidFold:)]) {
        [viewController tabBarDidFold:self.tabBarView];
    }
}

-(void)tabBarWillExpand:(LEMFoldingTabBar *)tabBar {
    id<LEMFoldingTabBarDelegate>viewController = [self currentInteractingViewController];
    if ([viewController respondsToSelector:@selector(tabBarWillExpand:)]) {
        [viewController tabBarWillExpand:self.tabBarView];
    }
}

- (void)tabBarDidExpand:(LEMFoldingTabBar *)tabBar {
    id<LEMFoldingTabBarDelegate>viewController = [self currentInteractingViewController];
    if ([viewController respondsToSelector:@selector(tabBarDidExpand:)]) {
        [viewController tabBarDidExpand:self.tabBarView];
    }
}

- (BOOL)tabBar:(LEMFoldingTabBar *)tabBar shouldSelectItemAtIndex:(NSUInteger)index {
    UIViewController *viewControllerToSelect = self.viewControllers[index];
    
    BOOL shouldAskForPermission = [self.delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)];
    
    BOOL selectionAllowed = YES;
    
    if (shouldAskForPermission) {
        selectionAllowed = [self.delegate tabBarController:self shouldSelectViewController:viewControllerToSelect];
    }
    
    return selectionAllowed;
}

- (void)tabBar:(LEMFoldingTabBar *)tabBar didSelectItemAtIndex:(NSUInteger)index {
    self.selectedViewController = self.controllers[index];
}

@end

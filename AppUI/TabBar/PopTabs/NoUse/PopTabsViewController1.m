//
//  PopTabsViewController1.m
//  AppUI
//
//  Created by Himin on 2019/1/16.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "PopTabsViewController1.h"
#import "PopoverViewController.h"

@interface PopTabsViewController1 () <CircleMenuDataSource, PopoverViewControllerDataSource>

@property (nonatomic, strong) NSMutableArray<UIImageView *> *icons;

@property (nonatomic, strong) PopoverViewController *popoverViewController;

@end

@implementation PopTabsViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupIcons];
    
    [self setupViews];
}

- (void)setupViews {
    [self.view addSubview:self.circleMenuButton];
    [self.circleMenuButton addTarget:self action:@selector(showPopover:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupIcons {
    if (self.tabBarDataSource && [self.tabBarDataSource respondsToSelector:@selector(numberOfItemsInController:)]) {
        [self.icons enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        self.icons = [@[] mutableCopy];
        
        for (int index = 0; index < [self.tabBarDataSource numberOfItemsInController:self]; index++) {
            CGSize size = self.circleMenuButton.bounds.size;
            CGRect frame = CGRectMake(10, kNavAndStatusBarHeight+10+index*size.height, size.width*0.5, size.height*0.5);
            
            UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:frame];
            iconImageView.image = [self.tabBarDataSource tabsViewController:self iconAtIndex:index];
            iconImageView.contentMode = UIViewContentModeCenter;
            iconImageView.hidden = NO;
            
            [self.view addSubview:iconImageView];
            [self.icons addObject:iconImageView];
        }
    }
}

- (void)reloadData {
    [self.popoverViewController.menu reloadData];
}
//extension ColorMatchTabsViewController: UIViewControllerTransitioningDelegate {
//
//    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        circleTransition.mode = .show
//        circleTransition.startPoint = _view.circleMenuButton.center
//
//        return circleTransition
//    }
//
//    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        guard let dismissedViewController = dismissed as? PopoverViewController else {
//            return nil
//        }
//
//        circleTransition.mode = .hide
//        circleTransition.startPoint = dismissedViewController.menu.center
//
//        return circleTransition
//    }
//
//}
#pragma mark - action

- (void)showPopover:(UIButton *)sender {
    DLog(@"showPopover");
    //    self.popoverViewController.transitioningDelegate = self;
    self.popoverViewController.highlightedItemIndex = 0;
    self.popoverViewController.view.backgroundColor = UIColor.whiteColor;
    [self.popoverViewController reloadData];
#warning menu
    [self.popoverViewController.menu reloadData];
    
    [self presentViewController:self.popoverViewController animated:NO completion:nil];
}

#pragma mark -

- (UIButton *)circleMenuButton {
    if (!_circleMenuButton) {
        UIImage *image = [UIImage imageNamed:@"addCircle"];
        _circleMenuButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-image.size.width)*0.5, self.view.bounds.size.height-20-image.size.height, image.size.width, image.size.height)];
        _circleMenuButton.hidden = NO;
        [_circleMenuButton setImage:image forState:UIControlStateNormal];
        _circleMenuButton.adjustsImageWhenHighlighted = NO;
    }
    return _circleMenuButton;
}

- (PopoverViewController *)popoverViewController {
    if (!_popoverViewController) {
        _popoverViewController = [[PopoverViewController alloc] init];
        _popoverViewController.menu.dataSource = self;
        _popoverViewController.popoverDataSource = self;
    }
    return _popoverViewController;
}

#pragma mark - <CircleMenuDataSource>

- (NSInteger)numberOfItemsInMenu:(nonnull CircleMenu *)circleMenu {
    return [self.tabBarDataSource numberOfItemsInController:self];
}

- (nonnull UIColor *)circleMenu:(nonnull CircleMenu *)circleMenu tintColorAtIndex:(NSInteger)index {
    return [self.tabBarDataSource tabsViewController:self tintColorAtIndex:index];
}

#pragma mark - <PopoverViewControllerDataSource>

- (NSInteger)numberOfItemsInPopoverViewController:(nonnull PopoverViewController *)controller {
    return [self.tabBarDataSource numberOfItemsInController:self];
}

- (nonnull UIImage *)popoverViewController:(nonnull PopoverViewController *)controller hightlightedIconAtIndex:(NSInteger)index {
    return [self.tabBarDataSource tabsViewController:self hightlightedIconAtIndex:index];
}

- (nonnull UIImage *)popoverViewController:(nonnull PopoverViewController *)controller iconAtIndex:(NSInteger)index {
    return [self.tabBarDataSource tabsViewController:self iconAtIndex:index];
}

@end

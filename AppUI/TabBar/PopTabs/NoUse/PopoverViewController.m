//
//  PopoverViewController.m
//  AppUI
//
//  Created by Himin on 2019/1/16.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "PopoverViewController.h"

@interface PopoverViewController () <CircleMenuDelegate>

@property (nonatomic, strong) NSMutableArray<UIImageView *> *icons;

@end

@implementation PopoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupViews];
}

- (void)reloadData {
    if (self.popoverDataSource) {
        [self.icons enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        self.icons = [@[] mutableCopy];
        
        for (int index = 0; index < [self.popoverDataSource numberOfItemsInPopoverViewController:self]; index++) {
            CGSize size = CGSizeMake(self.menu.bounds.size.width, self.menu.bounds.size.height);
            CGPoint origin = [self.menu centerOfItemAtIndex:index];
            
            UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(origin.x, origin.y, size.width, size.height)];
            
            iconImageView.image = [self.popoverDataSource popoverViewController:self hightlightedIconAtIndex:index];
            iconImageView.contentMode = UIViewContentModeCenter;
            iconImageView.hidden = YES;
            
            [self.icons addObject:iconImageView];
        }
        
        [self moveIconsToDefaultPositions];
    }
}

#pragma mark - setup

- (void)setupViews {
    [self.view addSubview:self.menu];
}

#pragma mark - menu'action

- (void)hidePopover:(CircleMenu *)sender {
    DLog(@"hide poppver");
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - <CircleMenuDelegate>

- (void)circleMenuWillDisplayItems:(CircleMenu *)circleMenu {
    [self moveIconsToCircle];
}

- (void)circleMenuWillHideItems:(CircleMenu *)circleMenu {
    [self moveIconsToDefaultPositions];
}

- (void)circleMenu:(CircleMenu *)circleMenu didSelectItemAtIndex:(NSInteger)index {
    DLog(@"circleMenu didSelectItemAtIndex = %zd", index);
}

#pragma mark - move icon

- (void)moveIconsToDefaultPositions {
    for (UIImageView *imgV in self.icons) {
        NSInteger index = [self.icons indexOfObject:imgV];
        
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            imgV.center = CGPointMake(imgV.center.x, imgV.center.y-self.view.frame.size.height/2);
            BOOL shouldHighlight = (index == self.highlightedItemIndex);
            if (self.popoverDataSource) {
                if (shouldHighlight) {
                    imgV.image = [self.popoverDataSource popoverViewController:self hightlightedIconAtIndex:index];
                } else {
                    imgV.image = [self.popoverDataSource popoverViewController:self iconAtIndex:index];
                }
            }
            
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)moveIconsToCircle {
    for (UIImageView *imgV in self.icons) {
        NSInteger index = [self.icons indexOfObject:imgV];
        
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.95 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            imgV.center = [self.menu centerOfItemAtIndex:index];
            imgV.image = [self.popoverDataSource popoverViewController:self hightlightedIconAtIndex:index];
            
        } completion:^(BOOL finished) {
        }];
    }
}

#pragma mark - animation create

- (CAAnimation *)opacityAnimationWithDuration:(NSTimeInterval)duration initialValue:(float)initialValue finalValue:(float)finalValue {
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration = duration;
    opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:initialValue];
    opacityAnimation.toValue = [NSNumber numberWithFloat:finalValue];
    return opacityAnimation;
}

#pragma mark -

- (CircleMenu *)menu {
    if (!_menu) {
    
        UIImage *image = [UIImage imageNamed:@"addCircle"];
        _menu = [[CircleMenu alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-image.size.width)*0.5, self.view.bounds.size.height-20-image.size.height, image.size.width, image.size.height)];

        _menu.image = image;
        [_menu addTarget:self action:@selector(hidePopover:) forControlEvents:UIControlEventTouchUpInside];
        
        _menu.delegate = self;
    }
    return _menu;
}

@end

//
//  MenuView.m
//  AppUI
//
//  Created by Himin on 2019/1/14.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "MenuView.h"

@interface MenuView ()
@end

@implementation MenuView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    [self layoutIfNeeded];
}

- (void)commonInit {    
    [self createSubviewsAndSetLayout];
}

- (void)setCircleMenuButtonHidden:(BOOL)hidden {
    self.circleMenuButton.hidden = hidden;
}

#pragma mark -

- (void)createSubviewsAndSetLayout {
    [self addSubview:self.navigationBar];
    [self addSubview:self.tabs];
    [self addSubview:self.scrollMenu];
    [self addSubview:self.circleMenuButton];
    
    [self setCircleMenuButtonHidden:YES];
}

#pragma mark - lazy

- (ExtendedNavigationBar *)navigationBar {
    if (!_navigationBar) {
        CGRect rect = CGRectMake(0, 0, self.bounds.size.width, 50);
        _navigationBar = [[ExtendedNavigationBar alloc] initWithFrame:rect];
//        _navigationBar.backgroundColor = UIColor.brownColor;//test
    }
    return _navigationBar;
}

- (ColorTabs *)tabs {
    if (!_tabs) {
        CGRect rect = CGRectMake(0, 0, self.bounds.size.width, 44);
        _tabs = [[ColorTabs alloc] initWithFrame:rect];
        _tabs.userInteractionEnabled = YES;
    }
    return _tabs;
}

- (ScrollMenu *)scrollMenu {
    if (!_scrollMenu) {
        CGRect rect = CGRectMake(0, self.navigationBar.bounds.size.height, self.bounds.size.width, self.bounds.size.height-self.navigationBar.bounds.size.height);
        _scrollMenu = [[ScrollMenu alloc] initWithFrame:rect];
        _scrollMenu.showsHorizontalScrollIndicator = NO;
    }
    return _scrollMenu;
}

- (UIButton *)circleMenuButton {
    if (!_circleMenuButton) {
        UIImage *image = [UIImage imageNamed:@"addCircle"];
        _circleMenuButton = [[UIButton alloc] initWithFrame:CGRectMake((self.bounds.size.width-image.size.width)*0.5, self.bounds.size.height-20-image.size.height, image.size.width, image.size.height)];
        _circleMenuButton.hidden = YES;
        [_circleMenuButton setImage:image forState:UIControlStateNormal];
        _circleMenuButton.adjustsImageWhenHighlighted = NO;
    }
    return _circleMenuButton;
}

@end

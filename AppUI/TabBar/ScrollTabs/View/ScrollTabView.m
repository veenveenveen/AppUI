//
//  ScrollTabView.m
//  AppUI
//
//  Created by Himin on 2019/1/18.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "ScrollTabView.h"


static CGFloat scrollTabsHeight = 56;

@interface ScrollTabView ()


@end

@implementation ScrollTabView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
        DLog(@"initWithFrame");
    }
    return self;
}

- (void)commonInit {
    [self addSubview:self.scrollTabs];
    [self addSubview:self.contentView];
}

#pragma mark - lazy

- (ScrollTabs *)scrollTabs {
    if (!_scrollTabs) {
        _scrollTabs = [[ScrollTabs alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, scrollTabsHeight)];
        _scrollTabs.backgroundColor = UIColor.whiteColor;
    }
    return _scrollTabs;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, scrollTabsHeight, self.bounds.size.width, self.bounds.size.height-scrollTabsHeight)];
        _contentView.backgroundColor = UIColor.cyanColor;
    }
    return _contentView;
}

@end

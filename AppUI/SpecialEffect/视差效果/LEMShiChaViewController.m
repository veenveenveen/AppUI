//
//  LEMShiChaViewController.m
//  AppUI
//
//  Created by Himin on 2019/1/23.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "LEMShiChaViewController.h"
#import "LEMShiChaAnimationView.h"

#define pScreenWidth [UIScreen mainScreen].bounds.size.width
#define pScreenHeight [UIScreen mainScreen].bounds.size.height
#define BaseTag 10

/**
 动画偏移量 是指rightView相对于leftView的偏移量
 */
#define AnimationOffset 100

static NSInteger imgCount = 5;

@interface LEMShiChaViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation LEMShiChaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
}

#pragma mark -

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat x = scrollView.contentOffset.x;
    
    NSInteger leftIndex = x/pScreenWidth;
    //    NSLog(@"%ld",leftIndex);
    
    //这里的left和right是区分拖动中可见的两个视图
    LEMShiChaAnimationView * leftView = [scrollView viewWithTag:(leftIndex + BaseTag)];
    LEMShiChaAnimationView * rightView = [scrollView viewWithTag:(leftIndex + 1 + BaseTag)];
    
    //    leftView.contentX = -(SCROLLVIEW_WIDTH - x + (leftIndex * SCROLLVIEW_WIDTH));
    //    rightView.contentX = (SCROLLVIEW_WIDTH + x - ((leftIndex + 1) * SCROLLVIEW_WIDTH));
    
    
    rightView.contentX = -(pScreenWidth - AnimationOffset) + (x - (leftIndex * pScreenWidth))/pScreenWidth * (pScreenWidth - AnimationOffset);
    leftView.contentX = ((pScreenWidth - AnimationOffset) + (x - ((leftIndex + 1) * pScreenWidth))/pScreenWidth * (pScreenWidth - AnimationOffset));
}

#pragma mark -

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavAndStatusBarHeight+30, kScreenWidth, kScreenHeight*0.5)];
        _scrollView.contentSize = CGSizeMake(pScreenWidth*imgCount, kScreenHeight*0.5);
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        
        for (int i = 0; i < imgCount; i++) {
            LEMShiChaAnimationView *view = [[LEMShiChaAnimationView alloc] initWithFrame:CGRectMake(i*pScreenWidth, 0, pScreenWidth, kScreenHeight*0.5)];
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"0%d.jpg",i+1]];
            view.imageView.image = image;
            view.imageView.contentMode = UIViewContentModeScaleAspectFit;
//            view.backgroundColor = UIColor.lightGrayColor;
            [_scrollView addSubview:view];
            view.tag = BaseTag + i;
        }
    }
    return _scrollView;
}


@end

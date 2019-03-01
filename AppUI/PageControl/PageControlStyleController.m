//
//  PageControlStyleController.m
//  AppUI
//
//  Created by Himin on 2019/1/24.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "PageControlStyleController.h"
#import "LEMRectPageControl.h"
#import "LEMCircleNodePageControl.h"
#import "LEMPageControl.h"

#define BaseTag 10

static NSInteger imgCount = 5;

@interface PageControlStyleController ()  <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) LEMRectPageControl *rectPageControl;
@property (nonatomic, strong) LEMCircleNodePageControl *circleNodePageControl;

@property (nonatomic, strong) LEMPageControl *pageControl;// Horizontal
@property (nonatomic, strong) LEMPageControl *verticalPageControl;

@end

@implementation PageControlStyleController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.rectPageControl];
    
    [self.view addSubview:self.circleNodePageControl];
    [self.view addSubview:self.pageControl];
    [self.view addSubview:self.verticalPageControl];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = (scrollView.contentOffset.x + scrollView.bounds.size.width*0.5) / scrollView.bounds.size.width;
    self.rectPageControl.currentPage = index;
    self.circleNodePageControl.currentPage = index;
    self.pageControl.currentPage = index;
    self.verticalPageControl.currentPage = index;
}

#pragma mark - lazy

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavAndStatusBarHeight, kScreenWidth, 180)];
        _scrollView.contentSize = CGSizeMake(kScreenWidth*imgCount, 180);
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        
        for (int i = 0; i < imgCount; i++) {
            CGRect rect = _scrollView.bounds;
            rect.origin.x = i*kScreenWidth;
            UIImageView *view = [[UIImageView alloc] initWithFrame:rect];
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"0%d.jpg",i+1]];
            view.image = image;
            view.contentMode = UIViewContentModeScaleToFill;
            [_scrollView addSubview:view];
            view.tag = BaseTag + i;
        }
    }
    return _scrollView;
}

- (LEMRectPageControl *)rectPageControl {
    if (!_rectPageControl) {
        _rectPageControl = [[LEMRectPageControl alloc] initWithFrame:CGRectMake(30, kNavAndStatusBarHeight+185, kScreenWidth-60, 20)];
        _rectPageControl.backgroundColor = UIColor.cyanColor;
        _rectPageControl.numberOfPages = imgCount;
        _rectPageControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"efefef"];
        _rectPageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"643455"];
        _rectPageControl.hidesForSinglePage = NO;
    }
    return _rectPageControl;
}

- (LEMCircleNodePageControl *)circleNodePageControl {
    if (!_circleNodePageControl) {
        _circleNodePageControl = [[LEMCircleNodePageControl alloc] initWithFrame:CGRectMake(30, kNavAndStatusBarHeight+210, kScreenWidth-60, 20)];
        _circleNodePageControl.backgroundColor = UIColor.lightGrayColor;
        _circleNodePageControl.numberOfPages = imgCount;
        _circleNodePageControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"efefef"];
        _circleNodePageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"643455"];
        _circleNodePageControl.hidesForSinglePage = NO;
    }
    return _circleNodePageControl;
}

- (LEMPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[LEMPageControl alloc] initWithFrame:CGRectMake(30, kNavAndStatusBarHeight+235, kScreenWidth-60, 20)];
        _pageControl.backgroundColor = UIColor.lightGrayColor;
        _pageControl.numberOfPages = imgCount;
        _pageControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"efefef"];
        _pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"643455"];
        _pageControl.hidesForSinglePage = NO;
        
        _pageControl.pageControlPosition = LEMPageControlPositionRight;
        _pageControl.pageControlStyle = LEMPageControlStyleRect;
    }
    return _pageControl;
}

- (LEMPageControl *)verticalPageControl {
    if (!_verticalPageControl) {
        _verticalPageControl = [[LEMPageControl alloc] initWithFrame:CGRectMake(kScreenWidth-30, kNavAndStatusBarHeight, 20, self.scrollView.bounds.size.height)];
        _verticalPageControl.backgroundColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.5];
        _verticalPageControl.numberOfPages = imgCount;
        _verticalPageControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"efefef"];
        _verticalPageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"643455"];
        _verticalPageControl.hidesForSinglePage = NO;
        
        _verticalPageControl.pageControlPosition = LEMPageControlPositionLeft;
        _verticalPageControl.pageControlStyle = LEMPageControlStyleCircleNode;
        _verticalPageControl.pageControlDirection = LEMPageControlDirectionVertical;
    }
    return _verticalPageControl;
}

@end

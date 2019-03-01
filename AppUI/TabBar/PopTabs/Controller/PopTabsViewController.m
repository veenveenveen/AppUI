//
//  PopTabsViewController.m
//  AppUI
//
//  Created by Himin on 2019/1/16.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "PopTabsViewController.h"

static CGFloat itemDimension = 50; // 弹出的按钮的尺寸（宽/高）
static CGFloat circleRadius = 130; // 弹出的按钮的中心点距离原始点的距离

@interface PopTabsViewController ()

@property (nonatomic, strong) UIButton *circleMenuButton;           /* UIButton */

@property (nonatomic, strong) NSMutableArray<UIButton *> *buttons;  // 保存要弹出的按钮的数组

// 用于显示其他控制器的view
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIViewController *currentVC;

@property (nonatomic, strong) UIView *markView;// 当按钮弹出时显示


@property (nonatomic, assign) BOOL visible; // 用于标记按钮是否弹出

@property (nonatomic, assign) NSInteger selectedIndex; // 弹出按钮中某个选中的按钮的index

@end

@implementation PopTabsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self commonInit];
}

- (void)commonInit {
    self.buttons = [@[] mutableCopy];
    self.visible = NO;
    
    [self setupViews];
    
    // default 0
    [self updateContentWithIndex:0];
}

- (void)setupViews {
    [self.view addSubview:self.contentView];
    [self loadButtons];
    [self.view addSubview:self.circleMenuButton];
    [self.view bringSubviewToFront:self.circleMenuButton];
    [self.view insertSubview:self.markView aboveSubview:self.contentView];
}

#pragma mark - 加载按钮数据
- (void)loadButtons {
    if (self.tabBarDataSource && [self.tabBarDataSource respondsToSelector:@selector(numberOfItemsInController:)]) {
        
        assert([self.tabBarDataSource numberOfItemsInController:self] > 0);
        
        [self removeOldButtons];
        
        for (int index = 0; index < [self.tabBarDataSource numberOfItemsInController:self]; index++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:[self btnDefaultFrame]];
            [btn addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = index;
            
            assert([self.tabBarDataSource tabsViewController:self hightlightedIconAtIndex:index]);
            
            [btn setImage:[self.tabBarDataSource tabsViewController:self hightlightedIconAtIndex:index] forState:UIControlStateNormal];
            btn.layer.backgroundColor = [self.tabBarDataSource tabsViewController:self tintColorAtIndex:index].CGColor;
            btn.layer.cornerRadius = itemDimension/2;
            btn.exclusiveTouch = YES;
            btn.hidden = YES;
            
            [self.view insertSubview:btn belowSubview:self.circleMenuButton];
            
            [self.buttons addObject:btn];
        }
    }
}

- (void)removeOldButtons {
    [self.buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    self.buttons = [@[] mutableCopy];
}

#pragma mark - action

- (void)triggerMenu:(UIButton *)sender {
    self.visible = !self.visible;
    DLog(@"%d", self.visible);
    if (self.visible) {
        [self showItems];
    } else {
        [self hideItems];
    }
}

- (void)selectItem:(UIButton *)sender { //选中某个按钮时
    [self hideItems];
    
    NSInteger index = sender.tag;
    
    if (self.selectedIndex == index) {
        return;
    } else {
        self.selectedIndex = index;
    }
    
    [self updateContentWithIndex:index];
    
    if ( [self.tabBarDelegate respondsToSelector:@selector(tabsViewController:didSelectItemAtIndex:)]) {
        [self.tabBarDelegate tabsViewController:self didSelectItemAtIndex:index];
    }
}

- (void)showItems {
    self.visible = YES;
    
    self.circleMenuButton.userInteractionEnabled = NO;//防止按钮多次重复点击
    
    for (UIButton *btn in self.buttons) {
        NSInteger index = [self.buttons indexOfObject:btn];
        [UIView animateWithDuration:0.3 delay:(0+index*0.05) usingSpringWithDamping:0.7 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            btn.hidden = NO;
            btn.frame = [self targetFrameForItemAtIndex:index];
            self.circleMenuButton.transform = CGAffineTransformMakeRotation(M_PI * 0.75);
            [self showMaskView];
            
        } completion:^(BOOL finished) {
            if (index == self.buttons.count - 1) {//防止按钮多次重复点击 动画结束后恢复交互
                self.circleMenuButton.userInteractionEnabled = YES;
            }
        }];
    }
}

- (void)hideItems {
    self.visible = NO;
    
    self.circleMenuButton.userInteractionEnabled = NO;//防止按钮多次重复点击
    
    for (UIButton *btn in self.buttons) {
        NSInteger index = [self.buttons indexOfObject:btn];
        [UIView animateWithDuration:0.3 delay:(0+index*0.05) usingSpringWithDamping:1 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            btn.frame = [self btnDefaultFrame];
            self.circleMenuButton.transform = CGAffineTransformIdentity;
            [self hiddenMaskView];
            
        } completion:^(BOOL finished) {
            btn.hidden = YES;
            if (index == self.buttons.count - 1) {//防止按钮多次重复点击
                self.circleMenuButton.userInteractionEnabled = YES;
            }
        }];
    }
}

- (void)updateContentWithIndex:(NSInteger)index {
    if (self.tabBarDataSource && [self.tabBarDataSource respondsToSelector:@selector(tabsViewController:viewControllerAtIndex:)]) {
        
        if (self.currentVC && self.currentVC.view) {
            [self.currentVC.view removeFromSuperview];
            DLog(@"remove old VC");
        }
        
        // 修改控制器
        UIViewController *vc = [self.tabBarDataSource tabsViewController:self viewControllerAtIndex:index];
        self.currentVC = vc;
//        [self.contentView insertSubview:vc.view atIndex:0];
        [self.contentView insertSubview:vc.view belowSubview:self.markView];
        
        // 改变标题颜色
        if ([self.tabBarDataSource respondsToSelector:@selector(tabsViewController:tintColorAtIndex:)]) {
            [self setupTitleColor:[self.tabBarDataSource tabsViewController:self tintColorAtIndex:index]];
        }
        
        // 改变标题文字
        if ( [self.tabBarDataSource respondsToSelector:@selector(tabsViewController:titleAtIndex:)]) {
            self.title = [self.tabBarDataSource tabsViewController:self titleAtIndex:index];
        }
    }
}

#pragma mark - 弹出的按钮的坐标计算

/**
 * 圆弧上的按钮的frame计算
 */
- (CGRect)targetFrameForItemAtIndex:(NSInteger)index {
    CGPoint centerPoint = [self centerOfItemAtIndex:index];
    CGPoint itemOrigin = CGPointMake(centerPoint.x-itemDimension/2, centerPoint.y-itemDimension/2);
    CGSize itemSize = CGSizeMake(itemDimension, itemDimension);
    CGRect targetFrame = CGRectMake(itemOrigin.x, itemOrigin.y, itemSize.width, itemSize.height);
    return targetFrame;
}

/**
 * 圆弧上的按钮的中心点坐标
 */
- (CGPoint)centerOfItemAtIndex:(NSInteger)index {
    if (self.tabBarDataSource && [self.tabBarDataSource respondsToSelector:@selector(numberOfItemsInController:)]) {
        NSInteger count = [self.tabBarDataSource numberOfItemsInController:self];
        if (index >= 0 && index < count) {
            CGFloat deltaAngle = M_PI/(count+1);
            CGFloat angle = deltaAngle * (index+1) - M_PI;
            
            CGFloat x = circleRadius * cos(angle) + self.circleMenuButton.center.x;
            CGFloat y = circleRadius * sin(angle) + self.circleMenuButton.center.y;
            DLog(@"x = %f, y = %f",x,y);
            
            CGPoint point = CGPointMake(x, y);
            return point;
        }
    }
    
    return CGPointZero;
}

// 要弹出的按钮的默认frame
- (CGRect)btnDefaultFrame {
    CGPoint origin = CGPointMake(self.circleMenuButton.center.x-itemDimension/2, self.circleMenuButton.center.y-itemDimension/2);
    CGSize size = CGSizeMake(itemDimension, itemDimension);
    return CGRectMake(origin.x, origin.y, size.width, size.height);
}

#pragma mark - markview

- (void)showMaskView {
    _markView.hidden = NO;
    _markView.alpha = 0.5;
}

- (void)hiddenMaskView {
    _markView.hidden = YES;
    _markView.alpha = 0;
}

- (void)markViewTap:(UIView *)sender {
    [self hideItems];
}

#pragma mark -

- (UIButton *)circleMenuButton {
    if (!_circleMenuButton) {
        UIImage *image = [UIImage imageNamed:@"addCircle"];
        _circleMenuButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-image.size.width)*0.5, self.view.bounds.size.height-20-kBottomSafeHeight-image.size.height, image.size.width, image.size.height)];
        _circleMenuButton.hidden = NO;
        _circleMenuButton.exclusiveTouch = YES;
        [_circleMenuButton setImage:image forState:UIControlStateNormal];
        _circleMenuButton.adjustsImageWhenHighlighted = NO;
        
        [_circleMenuButton addTarget:self action:@selector(triggerMenu:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _circleMenuButton;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavAndStatusBarHeight, self.view.bounds.size.width, self.view.bounds.size.height-kNavAndStatusBarHeight)];
        _contentView.backgroundColor = UIColor.whiteColor;
    }
    return _contentView;
}

- (UIView *)markView {
    if (!_markView) {
        _markView = [[UIView alloc] initWithFrame:self.contentView.frame];
        _markView.backgroundColor = UIColor.lightGrayColor;
        _markView.hidden = YES;
        _markView.alpha = 0;
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(markViewTap:)];
        [_markView addGestureRecognizer:tapGR];
    }
    return _markView;
}

@end

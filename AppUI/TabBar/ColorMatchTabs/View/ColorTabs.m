//
//  ColorTabs.m
//  AppUI
//
//  Created by Himin on 2019/1/14.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "ColorTabs.h"

CGFloat highlighterViewOffScreenOffset = 44;
NSTimeInterval switchAnimationDuration = 0.3;
NSTimeInterval highlighterAnimationDuration = 0.3*0.5;

@interface ColorTabs ()

@property (nonatomic, strong) UIStackView *stackView;

@property (nonatomic, strong) UIView *highlighterView;

@property (nonatomic, strong) NSMutableArray<UIButton *> *btnArr;
@property (nonatomic, strong) NSMutableArray<UILabel *> *labArr;

@end

@implementation ColorTabs

#pragma mark -

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [self defaultSetting];
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
    
    if (self.window) {
        [self layoutIfNeeded];
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfItemsInTabSwitcher:)]) {
            NSInteger countItems = [self.dataSource numberOfItemsInTabSwitcher:self];
            if (countItems > self.selectedSegmentIndex) {
                [self transitionFromIndex:self.selectedSegmentIndex toIndex:self.selectedSegmentIndex];
            }
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self moveHighlighterViewToIndex:self.selectedSegmentIndex];
}

#pragma mark - defaultSetting

- (void)defaultSetting {
    self.clipsToBounds = YES;
    
    self.titleTextColor = UIColor.whiteColor;
    self.titleFont = [UIFont systemFontOfSize:14.0];
    
    self.stackView = [[UIStackView alloc] initWithFrame:self.bounds];
    self.stackView.backgroundColor = UIColor.blueColor;
    self.stackView.distribution = UIStackViewDistributionFillEqually;
    [self addSubview:self.stackView];
    
    self.highlighterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, self.bounds.size.height)];
    self.highlighterView.layer.cornerRadius = self.bounds.size.height * 0.5;
    [self addSubview:self.highlighterView];
    [self sendSubviewToBack:self.highlighterView];
    
    self.btnArr = [@[] mutableCopy];
    self.labArr = [@[] mutableCopy];
    
    self.selectedSegmentIndex = 0;
}

#pragma mark - 使用设置的数据源加载数据

- (void)reloadData {
    if (self.dataSource) {
        [self.btnArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        [self.labArr enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        
        self.btnArr = [@[] mutableCopy];
        self.labArr = [@[] mutableCopy];
        
        NSInteger count = [self.dataSource numberOfItemsInTabSwitcher:self];
        
        for (int index = 0; index < count; index++) {
            UIButton *btn = [self createButtonForIndex:index withDataSource:self.dataSource];
            [self.btnArr addObject:btn];
            [self.stackView addArrangedSubview:btn];
            
            UILabel *lab = [self createLabelForIndex:index withDataSource:self.dataSource];
            [self.labArr addObject:lab];
            [self.stackView addArrangedSubview:lab];
        }
    }
}

- (UIButton *)createButtonForIndex:(NSInteger)index withDataSource:(id<ColorTabsDataSource>)dataSource {
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[dataSource tabSwitcher:self iconAtIndex:index] forState:UIControlStateNormal];
    DLog(@"btn setImage = %@",[dataSource tabSwitcher:self iconAtIndex:index]);
    [btn setImage:[dataSource tabSwitcher:self hightlightedIconAtIndex:index] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (UILabel *)createLabelForIndex:(NSInteger)index withDataSource:(id<ColorTabsDataSource>)dataSource {
    UILabel *lab = [[UILabel alloc] init];
    lab.hidden = YES;
    lab.textAlignment = NSTextAlignmentLeft;
    lab.text = [dataSource tabSwitcher:self titleAtIndex:index];
    DLog(@"lab.text = %@",[dataSource tabSwitcher:self titleAtIndex:index]);
    lab.textColor = self.titleTextColor;
    lab.adjustsFontSizeToFitWidth = YES;
    lab.font = self.titleFont;
    return lab;
}

// btn'action.
- (void)selectButton:(UIButton *)sender {
    // ToDo 判断index的值是否合法
    NSInteger index = [self.btnArr indexOfObject:sender];
    if (self.selectedSegmentIndex != index) {
        [self transitionFromIndex:_selectedSegmentIndex toIndex:index];
        self.selectedSegmentIndex = index;
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

#pragma mark - 修改 HighlighterView'frame 的方法

- (void)moveHighlighterViewToIndex:(NSInteger)index {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfItemsInTabSwitcher:)]) {
        NSInteger countItems = [self.dataSource numberOfItemsInTabSwitcher:self];
        if (!countItems || countItems <= 0 || index >= countItems) {
            return;
        }
        
        UILabel *toLab = [self.labArr objectAtIndex:index];
        UIButton *toBtn = [self.btnArr objectAtIndex:index];
        
        // offset for first item
        CGPoint point = [self convertPoint:toBtn.frame.origin toCoordinateSpace:self];
        CGFloat offsetForFirstItem = (index == 0 ? -highlighterViewOffScreenOffset : 0);
        self.highlighterView.frame = CGRectMake(point.x+offsetForFirstItem, self.highlighterView.frame.origin.y, self.highlighterView.frame.size.width, self.highlighterView.frame.size.height);
        
        // offset for last item
        CGFloat offsetForLastItem = (index == countItems - 1 ? highlighterViewOffScreenOffset : 0);
        CGFloat width = toLab.bounds.size.width + (toLab.frame.origin.x - toBtn.frame.origin.x) + 10 - offsetForFirstItem + offsetForLastItem;
        self.highlighterView.frame = CGRectMake(self.highlighterView.frame.origin.x, self.highlighterView.frame.origin.y, width, self.highlighterView.frame.size.height);
        
        self.highlighterView.backgroundColor = [self.dataSource tabSwitcher:self tintColorAtIndex:index];
    }
}

#pragma mark - tab 切换效果

#warning 检查label是否存在
- (void)transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    UILabel *fromLab = [self.labArr objectAtIndex:fromIndex];
    UIButton *fromBtn = [self.btnArr objectAtIndex:fromIndex];
    UILabel *toLab = [self.labArr objectAtIndex:toIndex];
    UIButton *toBtn = [self.btnArr objectAtIndex:toIndex];
    if (!fromLab || !fromBtn || !toLab || !toBtn) {
        return;
    }
    
    [UIView animateWithDuration:switchAnimationDuration delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionNone animations:^{
        fromLab.hidden = YES;
        fromLab.alpha = 0;
        fromBtn.selected = NO;
        
        toLab.hidden = NO;
        toLab.alpha = 1;
        toBtn.selected = YES;
        
        [self.stackView layoutIfNeeded];
        [self layoutIfNeeded];
        
        [self moveHighlighterViewToIndex:toIndex];
    } completion:^(BOOL finished) {
        // do nothing
    }];
}

#pragma mark - setter

// 当scrollView滚动时当前的index改变调用该方法

- (void)scrollMenuDidScrollToIndex:(NSInteger)index {
    if (_selectedSegmentIndex != index) {
        DLog(@"_selectedSegmentIndex = %zd, selected index = %zd",_selectedSegmentIndex,index);
        [self transitionFromIndex:_selectedSegmentIndex toIndex:index];
        self.selectedSegmentIndex = index;
    }
}

@end

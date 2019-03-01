// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project

#import "YALFoldingTabBar.h"

//model
#import "YALTabBarItem.h"

#import "CAAnimation+YALTabBarViewAnimations.h"
#import "CATransaction+TransactionWithAnimationsAndCompletion.h"

typedef NS_ENUM(NSUInteger, YALAnimatingState) {
    YALAnimatingStateCollapsing,
    YALAnimatingStateExpanding
};

#import "YALAnimatingTabBarConstants.h"

@interface YALFoldingTabBar ()
    
    @property (nonatomic, strong) NSArray *allBarItems;
    
    @property (nonatomic, assign) YALAnimatingState animatingState;
    @property (nonatomic, assign) BOOL isFinishedCenterButtonAnimation;
    
    @property (nonatomic, strong) UIButton *centerButton;
    @property (nonatomic, strong) UIView *mainView;
    
    @property (nonatomic, assign, getter = isAnimating) BOOL animating;
    
    @property (nonatomic, assign) CGRect collapsedFrame;
    @property (nonatomic, assign) CGRect expandedFrame;
    
    @property (nonatomic, assign) CGRect collapsedBounds;
    @property (nonatomic, assign) CGRect expandedBounds;
    
    @property (nonatomic, assign) NSUInteger counter;
    
    //buttons used instead of native tabBarItems to switch between controllers
    @property (nonatomic, strong) NSArray *leftButtonsArray;
    @property (nonatomic, strong) NSArray *rightButtonsArray;
    
    //model representation of tabBarItems. also contains info for extraBarItems: image, color, etc
    @property (nonatomic, strong) NSDictionary *leftTabBarItems;
    @property (nonatomic, strong) NSDictionary *rightTabBarItems;
    
    //array of all buttons just for simple switching between controllers by index
    @property (nonatomic, strong) NSArray *allAdditionalButtons;
    @property (nonatomic, strong) NSMutableArray *allAdditionalButtonsBottomView;
    
    @end

@implementation YALFoldingTabBar
    
#pragma mark - Instantiation
    
    
- (instancetype)initWithController:(YALFoldingTabBarController *)controller {
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        _delegate = (id<YALTabBarDelegate>)controller;
        _dataSource = (id<YALTabBarDataSource>)controller;
        _selectedTabBarItemIndex = 0;
        _counter = 0;
        _dotColor = [UIColor blackColor];
    }
    
    return self;
}
    
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setupUI];
}
    
- (void)setState:(YALTabBarState)state {
    if (_state == state) {
        return;
    }
    
    switch (state) {
        case YALTabBarStateCollapsed: {
            [self collapse];
            break;
        }
        case YALTabBarStateExpanded: {
            [self expand];
            break;
        }
    }
    
    _state = state;
}
    
#pragma mark - Private
    
- (void)setupUI {
    [self removeViewsBeforeUpdateUI];
    
    [self setupMainView];
    [self setupCenterButton];
    
    //collapsed frame equals to frame of the centerButton
    self.collapsedFrame = self.centerButton.frame;
    
    [self setupAdditionalTabBarItems];
    
    [self updateMaskLayer];
    
    [self setupTabBarItemsViewRepresentation];
    [self setupBarItemsModelRepresentation];
    [self prepareTabBarViewForInitialState];
}
    
- (void)removeViewsBeforeUpdateUI {
    
    if (self.mainView) {
        [self.mainView removeFromSuperview];
        self.mainView = nil;
    }
    
    if (self.centerButton) {
        [self.centerButton removeFromSuperview];
        self.centerButton = nil;
    }
}
    
- (void)setupCenterButton {
    self.centerButton = [[UIButton alloc] initWithFrame:
                         CGRectMake(CGRectGetMidX(self.mainView.frame) - CGRectGetHeight(self.mainView.frame) / 2.0f,
                                    CGRectGetMidY(self.mainView.frame) - CGRectGetHeight(self.mainView.frame) / 2.f,
                                    CGRectGetHeight(self.mainView.frame),
                                    CGRectGetHeight(self.mainView.frame))];
    
    self.centerButton.layer.cornerRadius = CGRectGetHeight(self.mainView.bounds) / 2.f;
    
    if ([self.dataSource respondsToSelector:@selector(centerImageInTabBarView:)]) {
        [self.centerButton setImage:[self.dataSource centerImageInTabBarView:self] forState:UIControlStateNormal];
    }
    
    [self.centerButton addTarget:self action:@selector(centerButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    self.centerButton.adjustsImageWhenHighlighted = NO;
    
    [self addSubview:self.centerButton];
}
    
- (void)setupMainView {
    CGRect frame = CGRectMake(self.bounds.origin.x,
                              self.bounds.origin.y,
                              self.bounds.size.width,
                              self.bounds.size.height - kBottomSafeHeight);
    frame = UIEdgeInsetsInsetRect(frame, self.tabBarViewEdgeInsets);
    
    self.mainView = [[UIView alloc] initWithFrame:frame];
    
    self.expandedFrame = self.mainView.frame;
    self.mainView.layer.cornerRadius = CGRectGetHeight(self.mainView.bounds) / 2.f;
    self.mainView.layer.masksToBounds = YES;
    self.mainView.backgroundColor = self.tabBarColor;
    
    [self addSubview:self.mainView];
}
    
- (void)setupAdditionalTabBarItems {
    NSArray *leftTabBarItems = [self.dataSource leftTabBarItemsInTabBarView:self];
    NSArray *rightTabBarItems = [self.dataSource rightTabBarItemsInTabBarView:self];
    
    NSUInteger numberOfLeftTabBarButtonItems = [leftTabBarItems count];
    NSUInteger numberOfRightTabBarButtonItems = [rightTabBarItems count];
    
    //calculate available space for left and right side
    CGFloat availableSpaceForAdditionalBarButtonItemLeft = CGRectGetWidth(self.mainView.frame) / 2.f - CGRectGetWidth(self.centerButton.frame) / 2.f - self.tabBarItemsEdgeInsets.left;
    
    CGFloat availableSpaceForAdditionalBarButtonItemRight = CGRectGetWidth(self.mainView.frame) / 2.f - CGRectGetWidth(self.centerButton.frame) / 2.f - self.tabBarItemsEdgeInsets.right;
    
    CGFloat maxWidthForLeftBarButonItem = availableSpaceForAdditionalBarButtonItemLeft / numberOfLeftTabBarButtonItems;
    CGFloat maxWidthForRightBarButonItem = availableSpaceForAdditionalBarButtonItemRight / numberOfRightTabBarButtonItems;
    
    NSMutableArray * reverseArrayLeft = [NSMutableArray arrayWithCapacity:[self.leftButtonsArray count]];
    
    for (id element in [leftTabBarItems reverseObjectEnumerator]) {
        [reverseArrayLeft addObject:element];
    }
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    NSMutableArray *mutableDotsArray = [NSMutableArray array];
    
    CGFloat deltaLeft = 0.f;
    if (maxWidthForLeftBarButonItem > CGRectGetWidth(self.centerButton.frame)) {
        deltaLeft = maxWidthForLeftBarButonItem - CGRectGetWidth(self.centerButton.frame);
    }
    
    CGFloat startPositionLeft = CGRectGetWidth(self.mainView.bounds) / 2.f - CGRectGetWidth(self.centerButton.frame) / 2.f - self.tabBarItemsEdgeInsets.left - deltaLeft / 2.f;
    
    for (int i = 0; i < numberOfLeftTabBarButtonItems; i++) {
        CGFloat buttonOriginX = startPositionLeft - maxWidthForLeftBarButonItem * (i+1);
        CGFloat buttonOriginY = 0.f;
        
        CGFloat buttonWidth = maxWidthForLeftBarButonItem;
        CGFloat buttonHeight = CGRectGetHeight(self.mainView.frame);
        
        startPositionLeft -= self.tabBarItemsEdgeInsets.right;
        
        YALTabBarItem *item = reverseArrayLeft[i];
        UIImage *image = item.itemImage;
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonOriginX, buttonOriginY, buttonWidth, buttonHeight)];
        
        if (numberOfLeftTabBarButtonItems == 1) {
            CGRect rect = button.frame;
            rect.size.width = CGRectGetHeight(self.mainView.frame);
            button.bounds = rect;
        }
        
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(didTapBarItem:) forControlEvents:UIControlEventTouchUpInside];
        
        if (self.state == YALTabBarStateCollapsed) {
            button.hidden = YES;
        }
        
        
        [mutableArray addObject:button];
        button.adjustsImageWhenHighlighted = NO;
        
        [self.mainView addSubview:button];
    }
    
    NSMutableArray * reverseArrayLeftDotViews = [NSMutableArray arrayWithCapacity:[mutableDotsArray count]];
    
    for (id element in [mutableDotsArray reverseObjectEnumerator]) {
        [reverseArrayLeft addObject:element];
    }
    mutableDotsArray = reverseArrayLeftDotViews;
    
    self.leftButtonsArray = [mutableArray copy];
    
    [mutableArray removeAllObjects];
    
    CGFloat rightDelta = 0.f;
    if (maxWidthForRightBarButonItem > CGRectGetWidth(self.centerButton.frame)) {
        rightDelta = maxWidthForRightBarButonItem - CGRectGetWidth(self.centerButton.frame);
    }
    
    CGFloat rightOffset = self.tabBarItemsEdgeInsets.right;
    CGFloat startPositionRight = CGRectGetWidth(self.mainView.bounds) / 2.f + CGRectGetWidth(self.centerButton.frame) / 2.f + self.tabBarItemsEdgeInsets.right + rightDelta / 2.f;
    
    for (int i = 0; i < numberOfRightTabBarButtonItems; i++) {
        CGFloat buttonOriginX = startPositionRight;
        CGFloat buttonOriginY = 0.f;
        CGFloat buttonWidth = maxWidthForRightBarButonItem;
        CGFloat buttonHeight = CGRectGetHeight(self.mainView.frame);
        
        startPositionRight = buttonOriginX + maxWidthForRightBarButonItem + rightOffset;
        
        YALTabBarItem *item = rightTabBarItems [i];
        UIImage *image = item.itemImage;
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonOriginX, buttonOriginY, buttonWidth, buttonHeight)];
        
        if (numberOfLeftTabBarButtonItems == 1) {
            CGRect rect = button.frame;
            rect.size.width = CGRectGetHeight(self.mainView.frame);
            button.bounds = rect;
        }
        
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(didTapBarItem:) forControlEvents:UIControlEventTouchUpInside];
        
        if (self.state == YALTabBarStateCollapsed) {
            button.hidden = YES;
        }
        [mutableArray addObject:button];
        button.adjustsImageWhenHighlighted = NO;
        [self.mainView addSubview:button];
    }
    
    self.rightButtonsArray = [mutableArray copy];
}
    
//collect all tabBarItems (models) to one array
- (void)setupBarItemsModelRepresentation {
    NSMutableArray *tempMutableArrayOfBarItems = [NSMutableArray array];
    
    NSArray *leftTabBarItems = [self.dataSource leftTabBarItemsInTabBarView:self];
    NSArray *rightTabBarItems = [self.dataSource rightTabBarItemsInTabBarView:self];
    
    for (YALTabBarItem *item in leftTabBarItems) {
        [tempMutableArrayOfBarItems addObject:item];
    }
    
    for (YALTabBarItem *item in rightTabBarItems) {
        [tempMutableArrayOfBarItems addObject:item];
    }
    
    self.allBarItems = [tempMutableArrayOfBarItems copy];
}
    
- (void)setupTabBarItemsViewRepresentation {
    NSMutableArray *tempArray = [NSMutableArray array];
    NSMutableArray *reverseArray = [NSMutableArray arrayWithCapacity:[self.leftButtonsArray count]];
    
    for (id element in [self.leftButtonsArray reverseObjectEnumerator]) {
        [reverseArray addObject:element];
    }
    
    for (UIButton *button in [reverseArray arrayByAddingObjectsFromArray:self.rightButtonsArray]) {
        [tempArray addObject:button];
    }
    
    self.allAdditionalButtons = [tempArray copy];
    
    self.allAdditionalButtonsBottomView = [[NSMutableArray alloc] init];;
    for (UIButton *button in self.allAdditionalButtons) {
        UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, YALBottomSelectedDotDefaultSize,YALBottomSelectedDotDefaultSize)];
        dotView.center = CGPointMake(button.center.x, button.center.y + YALBottomSelectedDotOffset);
        dotView.layer.cornerRadius = CGRectGetHeight(dotView.frame) / 2.f;
        dotView.backgroundColor = self.dotColor;
        
        dotView.hidden = YES;
        [self.mainView addSubview:dotView];
        [self.allAdditionalButtonsBottomView addObject:dotView];
    }
}
    
- (void)prepareTabBarViewForInitialState {
    
    if (![self hasTabBarItems]) {
        return ;
    }
    
    //collapse mainView. tabBarItams are hidden.
    if (self.state == YALTabBarStateExpanded) {
        self.centerButton.transform = CGAffineTransformMakeRotation(M_PI_4);
    }
    self.mainView.frame = self.expandedFrame;
    
    //prepare current selected tabBarItem
    NSUInteger index = self.selectedTabBarItemIndex;
    
    if (self.selectedTabBarItemIndex != index) {
        UIView *previousSelectedDotView = self.allAdditionalButtonsBottomView[self.selectedTabBarItemIndex];
        previousSelectedDotView.hidden = YES;
        [self.allAdditionalButtonsBottomView replaceObjectAtIndex:self.selectedTabBarItemIndex withObject:previousSelectedDotView];
    }
    
    if (self.state == YALTabBarStateExpanded) {
        
        UIView *previousSelectedDotView = self.allAdditionalButtonsBottomView [self.selectedTabBarItemIndex];
        previousSelectedDotView.hidden = NO;
        [self.allAdditionalButtonsBottomView replaceObjectAtIndex:self.selectedTabBarItemIndex withObject:previousSelectedDotView];
    }
    
    self.selectedTabBarItemIndex = index;
}
    
- (BOOL)hasTabBarItems {
    return (self.allBarItems.count);
}
    
#pragma mark - Actions
    
- (void)centerButtonPressed {
    //we should wait until animation cycle is finished
    
    if (![self hasTabBarItems]) {
        return ;
    }
    
    self.counter ++;
    
    if (![self isAnimating]) {
        if (self.state == YALTabBarStateCollapsed) {
            self.state = YALTabBarStateExpanded;
        } else {
            self.state = YALTabBarStateCollapsed;
        }
    } else {
        if (self.animatingState == YALAnimatingStateCollapsing) {
            self.state = YALTabBarStateExpanded;
        } else  if (self.animatingState == YALAnimatingStateExpanding) {
            self.state = YALTabBarStateCollapsed;
        }
    }
}
    
- (void)didTapBarItem:(id)sender {
    NSUInteger index = [self.allAdditionalButtons indexOfObject:sender];
    
    if (![self.delegate respondsToSelector:@selector(tabBar:shouldSelectItemAtIndex:)] || ![self.delegate tabBar:self shouldSelectItemAtIndex:index] || [self isAnimating]) {
        return;
    }
    
    if (self.selectedTabBarItemIndex != index) {
        
        UIView *previousSelectedDotView = self.allAdditionalButtonsBottomView[self.selectedTabBarItemIndex];
        previousSelectedDotView.hidden = YES;
        [self.allAdditionalButtonsBottomView replaceObjectAtIndex:self.selectedTabBarItemIndex withObject:previousSelectedDotView];
    }
    
    self.selectedTabBarItemIndex = index;
    
    if ([self.delegate respondsToSelector:@selector(tabBarWillCollapse:)]) {
        [self.delegate tabBarWillCollapse:self];
    }
    
    self.state = YALTabBarStateCollapsed;
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectItemAtIndex:)]) {
        [self.delegate tabBar:self didSelectItemAtIndex:index];
    }
}
    
#pragma mark - expand/collapse
    
- (void)expand {
    self.isFinishedCenterButtonAnimation = NO;
    self.animatingState = YALAnimatingStateExpanding;
    
    if ([self.delegate respondsToSelector:@selector(tabBarWillExpand:)]) {
        [self.delegate tabBarWillExpand:self];
    }
    
    __block NSUInteger counterCurrentValue = self.counter;
    
    [CATransaction transactionWithAnimations:^{
        [self setAnimating:YES];
        [self animateTabBarViewExpand];
        [self animateCenterButtonExpand];
        [self animateAdditionalButtons];
        [self showSelectedDotView];
    } andCompletion:^{
        if (counterCurrentValue == self.counter) {
            if ([self.delegate respondsToSelector:@selector(tabBarDidExpand:)]) {
                [self.delegate tabBarDidExpand:self];
            }
            [self setAnimating:NO];
        }
    }];
}
    
- (void)collapse {
    self.isFinishedCenterButtonAnimation = NO;
    self.animatingState = YALAnimatingStateCollapsing;
    
    if ([self.delegate respondsToSelector:@selector(tabBarWillCollapse:)]) {
        [self.delegate tabBarWillCollapse:self];
    }
    
    __block NSUInteger counterCurrentValue = self.counter;
    
    [CATransaction transactionWithAnimations:^{
        [self setAnimating:YES];
        [self animateTabBarViewCollapse];
        [self animateCenterButtonCollapse];
        [self hideSelectedDotView];
        [self animateAdditionalButtons];
    } andCompletion:^{
        if (counterCurrentValue == self.counter) {
            if ([self.delegate respondsToSelector:@selector(tabBarDidCollapse:)]) {
                [self.delegate tabBarDidCollapse:self];
            }
        }
        [self setAnimating:NO];
    }];
}
    
- (void)hideSelectedDotView {
    UIView *previousSelectedDotView = self.allAdditionalButtonsBottomView[self.selectedTabBarItemIndex];
    previousSelectedDotView.hidden = YES;
    [self.allAdditionalButtonsBottomView replaceObjectAtIndex:self.selectedTabBarItemIndex withObject:previousSelectedDotView];
}
    
- (void)showSelectedDotView {
    UIView *previousSelectedDotView = self.allAdditionalButtonsBottomView[self.selectedTabBarItemIndex];
    previousSelectedDotView.hidden = NO;
    [previousSelectedDotView.layer addAnimation:[CAAnimation showSelectedDotAnimation] forKey:nil];
    [self.allAdditionalButtonsBottomView replaceObjectAtIndex:self.selectedTabBarItemIndex withObject:previousSelectedDotView];
}
    
#pragma mark - Animations
    
- (void)animateAdditionalButtons {
    for (UIView *button in self.allAdditionalButtons) {
        if (button.hidden) {
            [button.layer removeAnimationForKey:YALAdditionalButtonsAnimation];
            [button.layer addAnimation:[CAAnimation animationForAdditionalButton] forKey:YALAdditionalButtonsAnimation];
        }
        
        button.hidden = !button.hidden;
    }
}
    
- (void)animateTabBarViewExpand {
    [self.mainView.layer removeAnimationForKey:YALTabBarExpandCollapseAnimation];
    
    CAAnimation *animation = [CAAnimation animationForTabBarExpandFromRect:self.collapsedBounds toRect:self.expandedBounds];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.mainView.layer.mask addAnimation:animation forKey:YALTabBarExpandAnimation];
}
    
- (void)animateTabBarViewCollapse {
    [self.mainView.layer removeAnimationForKey:YALTabBarExpandAnimation];
    
    CAAnimation *animation = [CAAnimation animationForTabBarCollapseFromRect:self.expandedBounds toRect:self.collapsedBounds];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.mainView.layer.mask addAnimation:animation forKey:YALTabBarExpandCollapseAnimation];
}
    
- (void)animateCenterButtonExpand {
    [self.centerButton.layer removeAnimationForKey:YALCenterButtonCollapseAnimation];
    
    CAAnimation *animation = [CAAnimation animationForCenterButtonExpand];
    [self.centerButton.layer addAnimation:animation forKey:YALCenterButtonExpandAnimation];
}
    
- (void)animateCenterButtonCollapse {
    [self.centerButton.layer removeAnimationForKey:YALCenterButtonExpandAnimation];
    
    CAAnimation *animation = [CAAnimation animationForCenterButtonCollapse];
    [self.centerButton.layer addAnimation:animation forKey: YALCenterButtonCollapseAnimation];
}
    
#pragma mark - Mutators
    
- (void)setTabBarColor:(UIColor *)tabBarColor {
    _tabBarColor = tabBarColor;
    self.mainView.backgroundColor = self.tabBarColor;
}
    
- (void)setCollapsedFrame:(CGRect)collapsedFrame {
    _collapsedFrame = collapsedFrame;
    
    self.collapsedBounds = ({
        CGRect collapsedBounds = collapsedFrame;
        collapsedBounds.origin = CGPointZero;
        collapsedBounds.origin.x = CGRectGetWidth(self.expandedFrame) / 2 - CGRectGetWidth(collapsedBounds) / 2;
        collapsedBounds;
    });
    [self updateMaskLayer];
}
    
- (void)setExpandedFrame:(CGRect)expandedFrame {
    _expandedFrame = expandedFrame;
    
    self.expandedBounds = ({
        CGRect expandedBounds = expandedFrame;
        expandedBounds.origin = CGPointZero;
        expandedBounds;
    });
    [self updateMaskLayer];
}
    
#pragma mark - Private
    
- (void)updateMaskLayer {
    self.mainView.layer.mask = ({
        CAShapeLayer *layer = [CAShapeLayer new];
        CGRect rect = (self.state == YALTabBarStateExpanded) ? self.expandedBounds : self.collapsedBounds;
        
        layer.path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:rect.size.height / 2].CGPath;
        
        layer;
    });
}
    
// will "activate" touches behind tabBar or better between tabBarItems
-(id)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    id hitView = [super hitTest:point withEvent:event];
    if (hitView == self.mainView) return nil;
    else return hitView;
}
    
@end

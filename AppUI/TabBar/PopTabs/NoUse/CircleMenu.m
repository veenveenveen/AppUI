//
//  CircleMenu.m
//  AppUI
//
//  Created by Himin on 2019/1/16.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "CircleMenu.h"

static CGFloat itemsSpacing = 130;
static CGFloat itemDimension = 50;

@interface CircleMenu ()

@property (nonatomic, assign) BOOL visible;
@property (nonatomic, strong) NSMutableArray<UIButton *> *buttons;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, assign) CGRect sourceFrame;

@end

@implementation CircleMenu

- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [self defaultSetting];
    [self addSubview:self.imageView];
    [self addTarget:self action:@selector(triggerMenu) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    for (UIButton *btn in self.buttons) {
        [self.superview addSubview:btn];
    }
}

#pragma mark -

- (void)defaultSetting {
    self.visible = NO;
    self.buttons = [@[] mutableCopy];
    self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
}

#pragma mark -

- (void)reloadData {
    if (self.dataSource) {
        [self removeOldButtons];
        
        for (int index = 0; index < [self.dataSource numberOfItemsInMenu:self]; index++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectZero];
            [btn addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = index;
            [btn layoutIfNeeded];
            btn.layer.backgroundColor = [self.dataSource circleMenu:self tintColorAtIndex:index].CGColor;
            btn.layer.cornerRadius = itemDimension/2;
            
//            [self.superview addSubview:btn];
            
            [self.buttons addObject:btn];
        }
    }
}

#pragma mark - action

- (void)triggerMenu {
    self.visible = !self.visible;
    DLog(@"%d", self.visible);
    if (self.visible) {
        [self showItems];
    } else {
        [self hideItems];
    }
    
    [self setCloseButtonHidden:!self.visible];
}

- (void)selectItem:(UIButton *)sender {
    [self hideItems];
    [self.delegate circleMenu:self didSelectItemAtIndex:sender.tag];
}

- (void)showItems {
    // "You must add the menu to superview before perfoming any actions with it"
    if (!self.superview) {
        return;
    }
    self.visible = YES;
    [self.delegate circleMenuWillDisplayItems:self];
    
    for (UIButton *btn in self.buttons) {
        NSInteger index = [self.buttons indexOfObject:btn];
        
        btn.frame = self.sourceFrame;
        
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            btn.hidden = NO;
            btn.frame = [self targetFrameForItemAtIndex:index];
        } completion:^(BOOL finished) {
        }];
    }
    [self.superview bringSubviewToFront:self];
}

- (void)hideItems {
    // "You must add the menu to superview before perfoming any actions with it"
    if (!self.superview) {
        return;
    }
    [self setCloseButtonHidden:YES];
    [self.delegate circleMenuWillHideItems:self];
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        for (UIButton *btn in self.buttons) {
            btn.frame = self.sourceFrame;
            btn.hidden = YES;
        }
    } completion:^(BOOL finished) {
    }];
    self.visible = NO;
}

- (void)setCloseButtonHidden:(BOOL)hidden {
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = hidden ? CGAffineTransformIdentity : CGAffineTransformMakeRotation(M_PI*0.75);
    } completion:^(BOOL finished) {
    }];
}

- (CGRect)targetFrameForItemAtIndex:(NSInteger)index {
    CGPoint centerPoint = [self centerOfItemAtIndex:index];
    CGPoint itemOrigin = CGPointMake(centerPoint.x-itemDimension/2, centerPoint.y-itemDimension/2);
    CGSize itemSize = CGSizeMake(itemDimension, itemDimension);
    CGRect targetFrame = CGRectMake(itemOrigin.x, itemOrigin.y, itemSize.width, itemSize.height);
    return targetFrame;
}

#pragma mark - removeOldButtons

- (void)removeOldButtons {
    [self.buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    self.buttons = [@[] mutableCopy];
}

#pragma mark - setter

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = _image;
}

#pragma mark -

#pragma mark -


/**
 - parameter index: Index of item
 
 - returns: CGPoint with center of item at index
 */
- (CGPoint)centerOfItemAtIndex:(NSInteger)index {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfItemsInMenu:)]) {
        NSInteger count = [self.dataSource numberOfItemsInMenu:self];
        if (index >= 0 && index < count) {
            CGFloat deltaAngle = M_PI/count;
            CGFloat angle = deltaAngle * (index+0.5) - M_PI;
            
            CGFloat x = itemsSpacing * cos(angle) + self.bounds.size.width * 0.5;
            CGFloat y = itemsSpacing * sin(angle) + self.bounds.size.height * 0.5;
            
            CGPoint point = CGPointMake(x, y);
            CGPoint convertedPoint = [self convertPoint:point toView:self.superview];
            
            return convertedPoint;
        }
    }
    
    return CGPointZero;
}

#pragma mark -

- (CGRect)sourceFrame {
    CGPoint origin = CGPointMake(self.center.x-itemDimension/2, self.center.y-itemDimension/2);
    CGSize size = CGSizeMake(itemDimension, itemDimension);
    return CGRectMake(origin.x, origin.y, size.width, size.height);
}

@end

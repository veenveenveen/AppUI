//
//  ScrollMenu.m
//  AppUI
//
//  Created by Himin on 2019/1/14.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "ScrollMenu.h"

@interface ScrollMenu ()

@property (nonatomic, strong) NSMutableArray<UIViewController *> *viewControllers;

@end

@implementation ScrollMenu

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    
    [self updateContentOffsetWithIndex:self.destinationIndex animated:NO];
}

- (void)commonInit {
    self.pagingEnabled = YES;
    self.bounces = NO;
    
    if (@available(iOS 11.0, *)) {
//        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    self.destinationIndex = 0;
    self.viewControllers = [@[] mutableCopy];
}

#pragma mark - 加载数据

- (void)reloadData {
    if (self.scrollMenuDataSource) {
        NSMutableArray *oldVCs = self.viewControllers;
        NSMutableArray *newVCs = [@[] mutableCopy];
        
        NSInteger vcCount = [self.scrollMenuDataSource numberOfItemsInScrollMenu:self];
        
        for (int index = 0; index < vcCount; index++) {
            UIViewController *vc = [self.scrollMenuDataSource scrollMenu:self viewControllerAtIndex:index];
            [newVCs addObject:vc];
        }
        
        for (UIViewController *controller in newVCs) {
            NSInteger oldVCIndex = [oldVCs indexOfObject:oldVCs.firstObject];
            DLog(@"oldVCIndex = %zd",oldVCIndex);
            if (oldVCIndex && oldVCIndex >= 0 && oldVCIndex < oldVCs.count) {
                [oldVCs removeObjectAtIndex:oldVCIndex];
            } else {
                [self addSubview:controller.view];
            }
        }
        
        for (UIViewController *controller in oldVCs) {
            [controller.view removeFromSuperview];
        }
        
        self.viewControllers = newVCs;
        
        [self layoutContent];
    }
}

- (void)layoutContent {
    self.contentSize = CGSizeMake(self.bounds.size.width*self.viewControllers.count, self.bounds.size.height);
    for (UIViewController *vc in self.viewControllers) {
        NSInteger index = [self.viewControllers indexOfObject:vc];
        vc.view.frame = CGRectMake(self.bounds.size.width*index, 0, self.bounds.size.width, self.bounds.size.height);
    }
}

- (void)updateContentOffsetWithIndex:(NSInteger)index animated:(BOOL)animated {
    if (self.viewControllers.count > index) {
        CGFloat width = self.viewControllers[index].view.bounds.size.width;
        CGFloat contentOffsetX = width * index;
        [self setContentOffset:CGPointMake(contentOffsetX, self.contentOffset.y) animated:animated];
    }
}

#pragma mark -

// destinationIndex setter
- (void)setDestinationIndex:(NSInteger)destinationIndex {
    _destinationIndex = destinationIndex;
    [self updateContentOffsetWithIndex:_destinationIndex animated:NO];
}


#warning todo
// override contentOffset
- (void)setContentOffset:(CGPoint)contentOffset {
    [super setContentOffset:contentOffset];
    NSInteger index = (self.contentOffset.x+self.bounds.size.width*0.5)/self.bounds.size.width;
    DLog(@"scrollMenu contentOffset index = %zd",index);
    
    
    if (self.isDragging) {
        if (self.scrollMenuDelegate && [self.scrollMenuDelegate respondsToSelector:@selector(scrollMenu:didScrolledToItemAtIndex:)]) {
            [self.scrollMenuDelegate scrollMenu:self didScrolledToItemAtIndex:index];
        }
    }
}

@end

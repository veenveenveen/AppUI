//
//  CarouselViewController3.m
//  AppUI
//
//  Created by Himin on 2019/1/12.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "LEMScaleScrollController.h"
#import "LEMScaleScollView.h"
#import "LEMScaleModel.h"

@interface LEMScaleScrollController () <LEMScaleScollViewDelegate>

@property (nonatomic, strong) LEMScaleScollView *scaleScollView;

@end

@implementation LEMScaleScrollController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupViews];
    
    self.scaleScollView.models = [LEMScaleModel createModels];
}

#pragma mark - private

- (void)setupViews {
    [self.view addSubview:self.scaleScollView];
}

#pragma mark - LEMScaleScollView's Delegate

- (void)scaleScollViewDidSelectIndex:(NSInteger)index {
    DLog(@"did selected index = %zd", index);
}

- (void)scaleScollViewDidScrollToIndex:(NSInteger)index {
    DLog(@"did selected scroll to index = %zd", index);
}

#pragma mark - lazy

- (LEMScaleScollView *)scaleScollView {
    if (!_scaleScollView) {
        _scaleScollView = [[LEMScaleScollView alloc] initWithFrame:self.view.bounds];
        _scaleScollView.delegate = self;
    }
    return _scaleScollView;
}

@end

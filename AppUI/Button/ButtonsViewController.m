//
//  ButtonsViewController.m
//  AppUI
//
//  Created by Himin on 2019/1/23.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "ButtonsViewController.h"
#import "LEMBaseButton.h"

@interface ButtonsViewController ()

@property (nonatomic, strong) LEMBaseButton *popButton;

@end

@implementation ButtonsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.popButton];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 显示各个按钮的动画效果
    [self popButtonAnimation:self.popButton];
}

#pragma mark - button's target

- (void)btnclick {
    [self popButtonAnimation:self.popButton];
}

- (void)btnclick1 {
    DLog(@"click UIControlEventTouchUpInside");
}

#pragma mark - button's animations

//按钮出现时的动画效果

- (void)popButtonAnimation:(UIButton *)sender {
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    CATransform3D scale1 = CATransform3DMakeScale(0.5, 0.5, 1);
    CATransform3D scale2 = CATransform3DMakeScale(1.2, 1.2, 1);
    CATransform3D scale3 = CATransform3DMakeScale(0.9, 0.9, 1);
    CATransform3D scale4 = CATransform3DMakeScale(1.0, 1.0, 1);
    
    NSArray *frameValues = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            [NSValue valueWithCATransform3D:scale3],
                            [NSValue valueWithCATransform3D:scale4],
                            nil];
    
    [animation setValues:frameValues];
    
    NSArray *frameTimes = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:0.0],
                           [NSNumber numberWithFloat:0.5],
                           [NSNumber numberWithFloat:0.9],
                           [NSNumber numberWithFloat:1.0],
                           nil];
    
    [animation setKeyTimes:frameTimes];
    
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 0.3f;

    [sender.layer addAnimation:animation forKey:@"DSPopUpAnimation"];
}

#pragma mark - buttons

- (UIButton *)popButton {
    if (!_popButton) {
        _popButton = [[LEMBaseButton alloc] initWithFrame:CGRectMake(30, 80, 80, 35)];
        [_popButton setTitle:@"pop" forState:UIControlStateNormal];
        [_popButton addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchDown];
        [_popButton addTarget:self action:@selector(btnclick1) forControlEvents:UIControlEventTouchUpInside];
    }
    return _popButton;
}

@end

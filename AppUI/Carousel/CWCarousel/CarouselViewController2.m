//
//  CarouselViewController2.m
//  AppUI
//
//  Created by Himin on 2019/1/12.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "CarouselViewController2.h"

#import "CWCarousel.h"

@interface CarouselViewController2 () <CWCarouselDelegate>

@property (nonatomic, strong) CWCarousel *carousel;
@property (nonatomic, strong) UIView *animationView;
@property (nonatomic, assign) BOOL openCustomPageControl;

@end

@implementation CarouselViewController2

- (void)dealloc {
    DLog(@"%s", __func__);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.lightGrayColor;
    [self createButtons];
}
- (void)configureUI:(NSInteger)tag {
    CATransition *tr = [CATransition animation];
    tr.type = @"cube";
    tr.subtype = kCATransitionFromRight;
    tr.duration = 0.25;
    [self.animationView.layer addAnimation:tr forKey:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    if(self.carousel) {
        [self.carousel removeFromSuperview];
        self.carousel = nil;
    }
    
    self.animationView.backgroundColor = [UIColor whiteColor];
    CWFlowLayout *flowLayout = [[CWFlowLayout alloc] initWithStyle:[self styleFromTag:tag]];
    
    CWCarousel *carousel = [[CWCarousel alloc] initWithFrame:self.animationView.bounds delegate:self flowLayout:flowLayout];
    [self.animationView addSubview:carousel];
    
    carousel.backgroundColor = [UIColor whiteColor];
    
    [carousel freshCarousel];
    self.carousel = carousel;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - < 事件响应 >

- (void)buttonClick:(UIButton *)sender {
    static NSInteger tag = -1;
    if(tag == sender.tag) {
        return;
    }
    tag = sender.tag;
    [self configureUI:tag];
}
- (void)switchChanged:(UISwitch *)switchSender {
    self.openCustomPageControl = switchSender.on;
}
- (void)createButtons {
    NSArray *titles = @[@"正常样式", @"横向滑动两边留白", @"横向滑动两边留白渐变效果", @"两边被遮挡效果"];
    CGFloat height = 40;
    dispatch_apply(4, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view addSubview:button];
            [button setTitle:titles[index] forState:UIControlStateNormal];
            button.tag = index;
            button.frame = CGRectMake(0, height * index + 60, CGRectGetWidth(self.view.frame), height);
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        });
    });
    [self.view addSubview:self.animationView];
}

- (CWCarouselStyle)styleFromTag:(NSInteger)tag {
    switch (tag) {
        case 0:
            return CWCarouselStyle_Normal;
            break;
        case 1:
            return CWCarouselStyle_H_1;
            break;
        case 2:
            return CWCarouselStyle_H_2;
            break;
        case 3:
            return CWCarouselStyle_H_3;
            break;
        default:
            return CWCarouselStyle_Unknow;
            break;
    }
}

#pragma mark - Delegate

- (void)CWCarousel:(CWCarousel *)carousel didSelectedAtIndex:(NSInteger)index {
    DLog(@"...%ld...", (long)index);
}

- (UIView *)animationView{
    if(!_animationView) {
        self.animationView = [[UIView alloc] initWithFrame:CGRectMake(0, 240, CGRectGetWidth(self.view.frame), 230)];
    }
    return _animationView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

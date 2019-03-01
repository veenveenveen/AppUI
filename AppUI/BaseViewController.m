//
//  BaseViewController.m
//  AppUI
//
//  Created by Himin on 2019/1/16.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation BaseViewController

- (void)dealloc {
    DLog(@"dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    // 自定义导航栏返回按钮
    [self setupNavBackBtn];
    
    [self setupNavTitle];
}

- (void)setupTitleColor:(UIColor *)color {
    self.titleLabel.textColor = color;
}

#pragma mark - override

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    self.titleLabel.text = title ;
}

#pragma mark -

- (void)setupNavBackBtn {
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 50, 30)];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [backBtn setImage:[UIImage imageNamed:@"icon-back"] forState:UIControlStateNormal];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:UIColor.lightGrayColor forState:UIControlStateNormal];
    
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 设置按钮图片和文字间距
    CGFloat space = 5;
    backBtn.titleEdgeInsets = UIEdgeInsetsMake(0, space*0.5, 0, -space*0.5);
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -space*0.5, 0, space*0.5);
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

- (void)backBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -

- (void)setupNavTitle {
    self.titleLabel.frame = CGRectMake(0, 0, 120, 40);
    self.titleLabel.text = self.title;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont YRDZSTWithFontSize:21];// 自定义的字体
    self.navigationItem.titleView = self.titleLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

@end

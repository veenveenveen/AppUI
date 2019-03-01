//
//  ExampleToastShowController.m
//  AppUI
//
//  Created by Himin on 2019/1/24.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "ExampleToastShowController.h"
#import "LEMToast.h"

#define btnColor [UIColor colorWithHexString:@"cddeef"]

/*
 * LEMToastCustomButton
 */

@interface LEMToastCustomButton : UIButton

@end

@implementation LEMToastCustomButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self defaultSetting];
    }
    return self;
}

- (void)defaultSetting {
    self.layer.backgroundColor = btnColor.CGColor;
    self.layer.cornerRadius = 5;
    self.titleLabel.font = [UIFont FZKaiWithFontSize:15];
    [self setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
}

@end

/*
 * ExampleToastShowController
 */

@interface ExampleToastShowController ()

@end

@implementation ExampleToastShowController

- (void)viewDidLoad {
    [super viewDidLoad];
    {
        LEMToastCustomButton *btn = [[LEMToastCustomButton alloc] initWithFrame:CGRectMake(40, 140, 100, 40)];
        [btn setTitle:@"sandClock" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(showSandClockLoading) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    {
        LEMToastCustomButton *btn = [[LEMToastCustomButton alloc] initWithFrame:CGRectMake(160, 140, 70, 40)];
        [btn setTitle:@"orbit" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(showOrbitLoading) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
    }
    
    {
        LEMToastCustomButton *btn = [[LEMToastCustomButton alloc] initWithFrame:CGRectMake(260, 140, 70, 40)];
        [btn setTitle:@"system" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(showSystemLoading) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
    }
    
    {
        LEMToastCustomButton *btn = [[LEMToastCustomButton alloc] initWithFrame:CGRectMake(40, 200, 70, 40)];
        [btn setTitle:@"文字" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(showTextToast) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
    }
    
    {
        LEMToastCustomButton *btn = [[LEMToastCustomButton alloc] initWithFrame:CGRectMake(130, 200, 70, 40)];
        [btn setTitle:@"图片" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(showImageToast) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
    }
    
    {
        LEMToastCustomButton *btn = [[LEMToastCustomButton alloc] initWithFrame:CGRectMake(220, 200, 100, 40)];
        [btn setTitle:@"文字和图片" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(showTextAndImageToast) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
    }
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"dfdfdf"];
}

#pragma mark - action

- (void)showSandClockLoading {
    [LEMToast showLoading:LEMLoadingStyleSandClock];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LEMToast hideLoading];
    });
}

- (void)showOrbitLoading {
    [LEMToast showLoading:LEMLoadingStyleOrbitView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LEMToast hideLoading];
    });
}

- (void)showSystemLoading {
    [LEMToast showLoading:LEMLoadingStyleSystem];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LEMToast hideLoading];
    });
}

- (void)showTextToast {
    //    LEMToastConfig *config = [[LEMToastConfig alloc] init];
    //    config.backgroundColor = UIColor.orangeColor;
    //    config.textFont = [UIFont systemFontOfSize:15];
    //    config.textColor = UIColor.brownColor;
    
    //    [LEMToast showToastWithConfig:config text:@"提示" time:2];
    [LEMToast showToastWithText:@"提示提示提"];
}

- (void)showImageToast {
    //    LEMToastConfig *config = [[LEMToastConfig alloc] init];
    //    config.backgroundColor = UIColor.orangeColor;
    //    config.textFont = [UIFont systemFontOfSize:12];
    //    config.textColor = UIColor.brownColor;
    //    config.toastWidth = 60;
    //
    //    config.contentMode = UIViewContentModeScaleAspectFit;
    //    config.imageHeight = 30;
    
    //    [LEMToast showToastWithConfig:config text:nil image:kImageName(@"icon_delete") time:2];
    [LEMToast showToastWithImage:[UIImage imageNamed:@"icon_detail"]];
    
}

- (void)showTextAndImageToast {
    LEMToastConfig *config = [[LEMToastConfig alloc] init];
    
    //    config.contentMode = UIViewContentModeScaleAspectFit;
    //    config.toastWidth = 200;
    //    config.imageHeight = 30;
    
    [LEMToast showToastWithConfig:config text:@"提示提示提" image:kImageName(@"icon_detail") time:1.5];
}

@end

//
//  LEMBezierViewController.m
//  AppUI
//
//  Created by Himin on 2019/1/28.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "LEMBezierViewController.h"
#import "LEMBezierPathView.h"

@interface LEMBezierViewController ()

@end

@implementation LEMBezierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LEMBezierPathView *bezierView = [[LEMBezierPathView alloc] initWithFrame:CGRectMake(0, 0, 320, 440)];
    bezierView.center = self.view.center;
    [self.view addSubview:bezierView];
    
    {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        lab.top = bezierView.bottom+10;
        lab.centerX = bezierView.centerX;
        lab.textAlignment = NSTextAlignmentRight;
        lab.font = [UIFont FZKaiWithFontSize:18];
        lab.textColor = [UIColor colorWithHexString:@"505A50"];
        lab.text = @"by Himin";
        lab.alpha = 0;
        [self.view addSubview:lab];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(14.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.5 animations:^{
                lab.alpha = 1;
            }];
        });
        
        
    }
}


@end

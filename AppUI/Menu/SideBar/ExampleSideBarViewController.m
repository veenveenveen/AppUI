//
//  ExampleSideBarViewController.m
//  AppUI
//
//  Created by Himin on 2019/1/21.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "ExampleSideBarViewController.h"
#import "LEMMenuViewController.h"

@interface ExampleSideBarViewController ()

@property (nonatomic, strong) LEMMenuViewController *menuVC;

@end

@implementation ExampleSideBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.menuVC = [[LEMMenuViewController alloc] init];
//    [self addChildViewController:self.menuVC];
    
    {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(40, 140, 120, 40)];
        btn.layer.backgroundColor = UIColor.orangeColor.CGColor;
        [btn setTitle:@"menu" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
    }
    
}


- (void)btnClick:(UIButton *)sender {
//    if (self.navigationController) {
//        [self presentViewController:[[ExampleSideBarViewController alloc] init] animated:YES completion:nil];
//    } else {
//        
//        [self showViewController:self.menuVC sender:sender];
//    }
//    [self.navigationController pushViewController:self.menuVC animated:YES];
//    [self showDetailViewController:self.menuVC sender:nil];
//    [self showViewController:self.menuVC sender:sender];
//    [self.view addSubview:self.menuVC.view];
    
    
}

@end

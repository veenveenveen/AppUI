//
//  PerseiMenuController.m
//  AppUI
//
//  Created by Himin on 2019/1/11.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "PerseiMenuController.h"
#import "SideMenuController.h"
#import "PerseiHomeViewController.h"


//
CATransform3D CATransform3DMakePerspective(CGPoint center, float disZ)
{
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disZ;
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}
CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ)
{
    return CATransform3DConcat(t, CATransform3DMakePerspective(center, disZ));
}
//

@interface PerseiMenuController ()

@property (nonatomic, strong) SideMenuController *menuVC;
@property (nonatomic, strong) PerseiHomeViewController *homeVC;

@property (nonatomic, strong) UIView *coverView;

@end

@implementation PerseiMenuController

- (void)viewDidLoad {
    [super viewDidLoad];

    {
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"menu" style:UIBarButtonItemStylePlain target:self action:@selector(menuClick)];
    }
    
//    [self setupChildVCs];
}

- (void)setupChildVCs {
    self.menuVC = [[SideMenuController alloc] init];
    self.homeVC = [[PerseiHomeViewController alloc] init];
    self.homeVC.view.backgroundColor = UIColor.lightGrayColor;
    
    [self addChildViewController:self.menuVC];
    [self.view addSubview:self.menuVC.view];
    self.menuVC.view.layer.anchorPoint = CGPointMake(1, 0.5);

    // 3D透视效果
    CATransform3D rotate = CATransform3DMakeRotation(M_PI/2, 0, 1, 0);
    self.menuVC.view.layer.transform = CATransform3DPerspect(rotate, CGPointMake(0, 0),-100);
    
    [self addChildViewController:self.homeVC];
    [self.view addSubview:self.homeVC.view];
    
    self.menuVC.view.frame = CGRectMake(-60, 64, 60, UIScreen.mainScreen.bounds.size.height-64);
    self.homeVC.view.frame = CGRectMake(0, 64, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height-64);
    
    [self addCoverView];
}


- (void)addCoverView {
    self.coverView.hidden = YES;
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenLeftMenu)];
    [self.coverView addGestureRecognizer:tapGR];
    
    [self.homeVC.view addSubview:self.coverView];
    [self.homeVC.view bringSubviewToFront:self.coverView];
}

- (void)hiddenLeftMenu {
    [UIView animateWithDuration:0.5 animations:^{
        self.menuVC.view.frame = CGRectMake(-60, 64, 60, UIScreen.mainScreen.bounds.size.height-64);
        self.homeVC.view.frame = CGRectMake(0, 64, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height-64);
        
        CATransform3D rotate = CATransform3DMakeRotation(M_PI/2, 0, 1, 0);
        self.menuVC.view.layer.transform = CATransform3DPerspect(rotate, CGPointMake(0.5, 0.5),-60);
        
    } completion:^(BOOL finished) {
        self.coverView.hidden = YES;
    }];
}

#pragma mark - actions

- (void)menuClick {
    
    self.coverView.hidden = NO;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.menuVC.view.frame = CGRectMake(0, 64, 60, UIScreen.mainScreen.bounds.size.height-64);
        self.homeVC.view.frame = CGRectMake(60, 64, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height-64);
        
        self.menuVC.view.layer.transform = CATransform3DIdentity;
        
    } completion:^(BOOL finished) {
    }];
}

#pragma mark -

- (UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:self.homeVC.view.frame];
        _coverView.backgroundColor = UIColor.clearColor;
    }
    return _coverView;
}

@end

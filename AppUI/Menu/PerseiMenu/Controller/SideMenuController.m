//
//  SideMenuController.m
//  AppUI
//
//  Created by Himin on 2019/1/11.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "SideMenuController.h"
#import "PerseiMenuView.h"

@interface SideMenuController ()

@property (nonatomic, strong) PerseiMenuView *menuView;

@end

@implementation SideMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.orangeColor;
    
    [self.view addSubview:self.menuView];
    
    
}


#pragma mark -

- (PerseiMenuView *)menuView {
    if (!_menuView) {
        CGRect rect = CGRectMake(0, 0, 60, UIScreen.mainScreen.bounds.size.height);
        _menuView = [[PerseiMenuView alloc] initWithFrame:rect];
        _menuView.backgroundColor = UIColor.lightGrayColor;
    }
    return _menuView;
}



@end

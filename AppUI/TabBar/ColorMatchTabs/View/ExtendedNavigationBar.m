//
//  ExtendedNavigationBar.m
//  AppUI
//
//  Created by Himin on 2019/1/14.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "ExtendedNavigationBar.h"

@implementation ExtendedNavigationBar

- (void)willMoveToWindow:(UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
    
    self.layer.shadowOffset =CGSizeMake(0, 1/UIScreen.mainScreen.scale);
    self.layer.shadowRadius = 0;
    self.layer.shadowColor = UIColor.blackColor.CGColor;
    self.layer.shadowOpacity = 0.25;
}

@end

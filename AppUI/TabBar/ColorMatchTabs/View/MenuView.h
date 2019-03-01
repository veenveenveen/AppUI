//
//  MenuView.h
//  AppUI
//
//  Created by Himin on 2019/1/14.
//  Copyright © 2019 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ExtendedNavigationBar.h"
#import "ScrollMenu.h"
#import "ColorTabs.h"

NS_ASSUME_NONNULL_BEGIN

@interface MenuView : UIView

@property (nonatomic, strong) ExtendedNavigationBar *navigationBar; /* UIView */
@property (nonatomic, strong) ColorTabs *tabs;                      /* UIControl */
@property (nonatomic, strong) ScrollMenu *scrollMenu;               /* UIScrollView */
@property (nonatomic, strong) UIButton *circleMenuButton;           /* UIButton */

@end

NS_ASSUME_NONNULL_END

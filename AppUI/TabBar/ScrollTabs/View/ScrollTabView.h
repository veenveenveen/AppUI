//
//  ScrollTabView.h
//  AppUI
//
//  Created by Himin on 2019/1/18.
//  Copyright © 2019 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollTabs.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScrollTabView : UIView

@property (nonatomic, strong) ScrollTabs *scrollTabs; 

@property (nonatomic, strong) UIView *contentView; // 用于显示数据的视图

@end

NS_ASSUME_NONNULL_END

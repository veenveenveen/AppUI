//
//  LEMCustomNavView.h
//  AppUI
//
//  Created by Himin on 2019/1/22.
//  Copyright © 2019 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LEMCustomNavView;

@protocol LEMCustomNavViewDelegate <NSObject>

- (void)backButtonDidClick:(LEMCustomNavView *)customNavView;

@end

@interface LEMCustomNavView : UIView

@property (nonatomic, weak) id<LEMCustomNavViewDelegate> delegate;

@property (nonatomic, copy) NSString *title;

- (void)changeBackgroundViewColor:(UIColor *)color;
- (void)changeNavViewColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END

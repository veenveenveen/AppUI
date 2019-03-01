//
//  LEMScaleScollView.h
//  AppUI
//
//  Created by Himin on 2019/1/22.
//  Copyright © 2019 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LEMScaleModel;
@class LEMScaleScollView;

@protocol LEMScaleScollViewDelegate <NSObject>

- (void)scaleScollViewDidSelectIndex:(NSInteger)index;
- (void)scaleScollViewDidScrollToIndex:(NSInteger)index;

@end

@interface LEMScaleScollView : UIView

@property (nonatomic, weak) id<LEMScaleScollViewDelegate> delegate;

@property (nonatomic, copy) NSArray<LEMScaleModel *> *models;

@end

NS_ASSUME_NONNULL_END

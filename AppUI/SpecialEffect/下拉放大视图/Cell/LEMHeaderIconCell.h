//
//  LEMHeaderIconCell.h
//  AppUI
//
//  Created by Himin on 2019/1/25.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "CustomCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LEMHeaderIconCell : CustomCell

@property (class, nonatomic, readonly, assign) CGFloat cellHeight;

- (void)offsetY:(CGFloat)offsetY;

@end

NS_ASSUME_NONNULL_END

//
//  LEMScaleCell.h
//  AppUI
//
//  Created by Himin on 2019/1/22.
//  Copyright © 2019 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEMScaleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LEMScaleCell : UICollectionViewCell

/**
 *  数据模型.
 */
@property (nonatomic, strong) LEMScaleModel *dataModel;

- (void)loadContentWithModel:(LEMScaleModel *)dataModel;

@end

NS_ASSUME_NONNULL_END

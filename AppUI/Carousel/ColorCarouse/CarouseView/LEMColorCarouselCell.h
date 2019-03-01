//
//  LEMColorCarouselCell.h
//  AppUI
//
//  Created by Himin on 2019/1/22.
//  Copyright © 2019 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEMColorCarouselModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LEMColorCarouselCell : UICollectionViewCell

/**
 *  数据模型.
 */
@property (nonatomic, strong) LEMColorCarouselModel *dataModel;


- (void)loadContentWithModel:(LEMColorCarouselModel *)dataModel;

@end

NS_ASSUME_NONNULL_END

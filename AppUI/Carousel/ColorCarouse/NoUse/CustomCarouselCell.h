//
//  CustomCarouselCell.h
//  AppUI
//
//  Created by Himin on 2019/1/11.
//  Copyright © 2019 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarouselColorModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomCarouselCell : UICollectionViewCell

/**
 *  数据模型.
 */
@property (nonatomic, strong) CarouselColorModel *dataModel;

/**
 *  Index path.
 */
//@property (nonatomic, weak) NSIndexPath *indexPath;

- (void)loadContentWithModel:(CarouselColorModel *)dataModel;

@end

NS_ASSUME_NONNULL_END

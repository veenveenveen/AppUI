//
//  LEMTransitionCell.h
//  AppUI
//
//  Created by Himin on 2019/1/25.
//  Copyright © 2019 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LEMTransitionCell : UICollectionViewCell

@property (nonatomic, strong) id data;

- (void)loadContent;

@end

NS_ASSUME_NONNULL_END

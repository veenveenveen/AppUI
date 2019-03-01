//
//  PerseiMenuCell.h
//  AppUI
//
//  Created by Himin on 2019/1/11.
//  Copyright © 2019 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PerseiMenuItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface PerseiMenuCell : UICollectionViewCell

- (void)applyMenuItem:(PerseiMenuItem *)menuItem;

@end

NS_ASSUME_NONNULL_END

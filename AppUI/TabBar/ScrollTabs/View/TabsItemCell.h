//
//  TabsItemCell.h
//  AppUI
//
//  Created by Himin on 2019/1/18.
//  Copyright © 2019 Himin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// cell的宽度在这里修改
#define numberPerPage 5
#define cellWidth ((kScreenWidth-10-(numberPerPage-1)*5)/numberPerPage)

@interface TabsItemCell : UICollectionViewCell

- (void)setupDataWith:(UIImage *)image text:(NSString *)text;

@property (nonatomic, readonly, assign) BOOL markVisible;
- (void)hiddenBottomMark;
- (void)showBottomMark;

@end

NS_ASSUME_NONNULL_END

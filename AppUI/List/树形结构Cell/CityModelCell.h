//
//  CityModelCell.h
//  TreeTableView
//
//  Created by YouXianMing on 2017/7/23.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "CustomCell.h"

@interface CityModelCell : UITableViewCell

// CustomCell's data.
@property (nonatomic, weak) id data;
// CustomCell's indexPath.
@property (nonatomic, weak) NSIndexPath *indexPath;

- (void)loadContent;
- (void)selectedEvent;

@end

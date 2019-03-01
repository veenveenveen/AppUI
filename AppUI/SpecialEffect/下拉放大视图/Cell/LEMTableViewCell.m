//
//  LEMTableViewCell.m
//  AppUI
//
//  Created by Himin on 2019/1/25.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "LEMTableViewCell.h"

static CGFloat tableViewCell = 50.f;

@implementation LEMTableViewCell

- (void)setupCell {
    [super setupCell];
    self.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
}

- (void)buildSubview {
    
}

- (void)loadContent {
    self.textLabel.text = self.data;
}

+ (CGFloat)cellHeight {
    return tableViewCell;
}

@end

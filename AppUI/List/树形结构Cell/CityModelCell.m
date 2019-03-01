//
//  CityModelCell.m
//  TreeTableView
//
//  Created by YouXianMing on 2017/7/23.
//  Copyright © 2017年 TechCode. All rights reserved.
//

#import "CityModelCell.h"
#import "CityModel.h"

@interface CityModelCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation CityModelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupCell];
        [self buildSubview];
    }
    return self;
}

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
    self.label.font = [UIFont FZYingBiKaiShuWithFontSize:18.f];
    [self.contentView addSubview:self.label];
}

- (void)loadContent {
    CityModel *model = self.data;
    self.label.text = model.text;
    
    self.label.centerY = 25.f;
    self.label.left    = 15.f + model.level * 35.f;
    
    if (model.submodelsCount) {
        
        self.label.textColor              = [UIColor darkTextColor];
        self.contentView.backgroundColor  = model.extend ? [[UIColor lightGrayColor] colorWithAlphaComponent:0.15] : [UIColor whiteColor];
        
    } else {
        
        self.label.textColor              = [UIColor lightGrayColor];
        self.contentView.backgroundColor  = [UIColor whiteColor];
    }
}

- (void)selectedEvent {
    
    CityModel *model = self.data;
    
    if (model.submodelsCount) {
        
        self.label.textColor = [UIColor darkTextColor];
        
        [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            
            self.contentView.backgroundColor  = model.extend ? [UIColor whiteColor] : [[UIColor lightGrayColor] colorWithAlphaComponent:0.15];
            
        } completion:nil];
        
    } else {
        
        self.label.textColor              = [UIColor lightGrayColor];
        self.contentView.backgroundColor  = [UIColor whiteColor];
    }
}

@end


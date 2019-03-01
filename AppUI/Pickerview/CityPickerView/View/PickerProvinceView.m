//
//  PickerProvinceView.m
//  Animations
//
//  Created by YouXianMing on 2017/9/12.
//  Copyright © 2017年 YouXianMing. All rights reserved.
//

#import "PickerProvinceView.h"
#import "PickerProvinceModel.h"

@interface PickerProvinceView ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation PickerProvinceView

- (void)buildSubView {
    
    self.label               = [[UILabel alloc] initWithFrame:self.bounds];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.numberOfLines = 2;
    self.label.font          = [UIFont FZKaiWithFontSize:15.f];
    self.label.textColor     = [UIColor orangeColor];
    [self addSubview:self.label];
}

- (void)loadContent {
    
    PickerProvinceModel *model = self.data;
    self.label.text            = model.province;
}

@end

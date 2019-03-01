//
//  LEMTransitionCell.m
//  AppUI
//
//  Created by Himin on 2019/1/25.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "LEMTransitionCell.h"
#import "LEMTransitionModel.h"

@interface LEMTransitionCell ()

@property (nonatomic, strong) UILabel *textlabel;

@end

@implementation LEMTransitionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    [self addSubview:self.textlabel];
}

- (void)loadContent {
    LEMTransitionModel * model = self.data;
    self.textlabel.text = model.name;
}

#pragma mark -

- (UILabel *)textlabel {
    if (!_textlabel) {
        _textlabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        _textlabel.font = [UIFont YRDZSTWithFontSize:16];// 杨任东竹石体
        _textlabel.adjustsFontSizeToFitWidth = YES;
        _textlabel.textAlignment = NSTextAlignmentCenter;
        _textlabel.textColor = [UIColor colorWithHexString:@"666666"];
    }
    return _textlabel;
}

@end

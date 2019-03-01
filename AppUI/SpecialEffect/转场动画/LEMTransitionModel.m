//
//  LEMTransitionModel.m
//  AppUI
//
//  Created by Himin on 2019/1/25.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "LEMTransitionModel.h"

@implementation LEMTransitionModel

+ (instancetype)modelWithName:(NSString *)name transitionType:(LEMTransitionType)transitionType {
    LEMTransitionModel *model = [[LEMTransitionModel alloc] init];
    model.name = name;
    model.transitionType = transitionType;
    return model;
}

+ (NSArray<LEMTransitionModel *> *)createDataModels {
    LEMTransitionModel *m1 = [LEMTransitionModel modelWithName:@"淡化效果" transitionType:LEMTransitionTypeFade];
    LEMTransitionModel *m2 = [LEMTransitionModel modelWithName:@"push效果" transitionType:LEMTransitionTypePush];
    LEMTransitionModel *m3 = [LEMTransitionModel modelWithName:@"揭开效果" transitionType:LEMTransitionTypeReveal];
    LEMTransitionModel *m4 = [LEMTransitionModel modelWithName:@"覆盖效果" transitionType:LEMTransitionTypeMoveIn];
    LEMTransitionModel *m5 = [LEMTransitionModel modelWithName:@"立方体效果" transitionType:LEMTransitionTypeCube];
    LEMTransitionModel *m6 = [LEMTransitionModel modelWithName:@"吮吸效果" transitionType:LEMTransitionTypeSuckEffect];
    LEMTransitionModel *m7 = [LEMTransitionModel modelWithName:@"翻转效果" transitionType:LEMTransitionTypeOglFlip];
    LEMTransitionModel *m8 = [LEMTransitionModel modelWithName:@"波纹效果" transitionType:LEMTransitionTypeRippleEffect];
    LEMTransitionModel *m9 = [LEMTransitionModel modelWithName:@"翻页效果" transitionType:LEMTransitionTypePageCurl];
    LEMTransitionModel *m10 = [LEMTransitionModel modelWithName:@"反翻页效果" transitionType:LEMTransitionTypePageUnCurl];
    LEMTransitionModel *m11 = [LEMTransitionModel modelWithName:@"开镜头效果" transitionType:LEMTransitionTypeCameraIrisHollowOpen];
    LEMTransitionModel *m12 = [LEMTransitionModel modelWithName:@"关镜头效果" transitionType:LEMTransitionTypeCameraIrisHollowClose];
    LEMTransitionModel *m13 = [LEMTransitionModel modelWithName:@"下翻页效果" transitionType:LEMTransitionTypeCurlDown];
    LEMTransitionModel *m14 = [LEMTransitionModel modelWithName:@"上翻页效果" transitionType:LEMTransitionTypeCurlUp];
    LEMTransitionModel *m15 = [LEMTransitionModel modelWithName:@"左翻转效果" transitionType:LEMTransitionTypeFlipFromLeft];
    LEMTransitionModel *m16 = [LEMTransitionModel modelWithName:@"右翻转效果" transitionType:LEMTransitionTypeFlipFromRight];
    return @[m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11,m12,m13,m14,m15,m16];
}

@end

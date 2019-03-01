//
//  LEMTransitionModel.h
//  AppUI
//
//  Created by Himin on 2019/1/25.
//  Copyright © 2019 Himin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LEMTransitionAnimation.h"

NS_ASSUME_NONNULL_BEGIN

@interface LEMTransitionModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) LEMTransitionType transitionType;

+ (instancetype)modelWithName:(NSString *)name transitionType:(LEMTransitionType)transitionType;

+ (NSArray<LEMTransitionModel *> *)createDataModels;

@end

NS_ASSUME_NONNULL_END

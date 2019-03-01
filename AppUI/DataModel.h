//
//  DataModel.h
//  AppUI
//
//  Created by Himin on 2019/1/10.
//  Copyright © 2019 Himin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray<Item *> *items;

+ (instancetype)dataModelWithTitle:(NSString *)title items:(NSArray *)items;

+ (NSArray<DataModel *> *)createDataModels;

@end

NS_ASSUME_NONNULL_END

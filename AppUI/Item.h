//
//  Item.h
//  AppUI
//
//  Created by Himin on 2019/1/10.
//  Copyright © 2019 Himin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Item : NSObject

@property (nonatomic, strong) id object;
@property (nonatomic, copy) NSString *name;

+ (instancetype)itemWithObject:(id)object withName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END

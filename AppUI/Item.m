//
//  Item.m
//  AppUI
//
//  Created by Himin on 2019/1/10.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "Item.h"

@implementation Item

+ (instancetype)itemWithObject:(id)object withName:(NSString *)name {
    Item * item = [[Item alloc] init];
    item.object = object;
    item.name = name;
    return item;
}

@end

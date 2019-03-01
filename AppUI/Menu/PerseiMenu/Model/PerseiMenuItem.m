//
//  PerseiMenuItem.m
//  AppUI
//
//  Created by Himin on 2019/1/11.
//  Copyright © 2019 Himin. All rights reserved.
//

#import "PerseiMenuItem.h"

@implementation PerseiMenuItem

- (instancetype)initWithImage:(UIImage *)image name:(NSString *)name {
    if (self = [super init]) {
        self.image = image;
        self.name = name;
    }
    return self;
}

+ (NSArray *)createMenuItems {
    PerseiMenuItem *item1 = [[PerseiMenuItem alloc] initWithImage:[UIImage imageNamed:@"icon_delete"] name:@"删除"];
    PerseiMenuItem *item2 = [[PerseiMenuItem alloc] initWithImage:[UIImage imageNamed:@"icon_delete"] name:@"删除"];
    PerseiMenuItem *item3 = [[PerseiMenuItem alloc] initWithImage:[UIImage imageNamed:@"icon_delete"] name:@"删除"];
    PerseiMenuItem *item4 = [[PerseiMenuItem alloc] initWithImage:[UIImage imageNamed:@"icon_delete"] name:@"删除"];
    PerseiMenuItem *item5 = [[PerseiMenuItem alloc] initWithImage:[UIImage imageNamed:@"icon_delete"] name:@"删除"];
    PerseiMenuItem *item6 = [[PerseiMenuItem alloc] initWithImage:[UIImage imageNamed:@"icon_delete"] name:@"删除"];
    PerseiMenuItem *item7 = [[PerseiMenuItem alloc] initWithImage:[UIImage imageNamed:@"icon_delete"] name:@"删除"];
    PerseiMenuItem *item8 = [[PerseiMenuItem alloc] initWithImage:[UIImage imageNamed:@"icon_delete"] name:@"删除"];
    PerseiMenuItem *item9 = [[PerseiMenuItem alloc] initWithImage:[UIImage imageNamed:@"icon_delete"] name:@"删除"];
    return @[item1,item2,item3,item4,item5,item6,item7,item8,item9];
}

@end

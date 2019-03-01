// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project

#import "YALTabBarItem.h"

@interface YALTabBarItem ()

@end

@implementation YALTabBarItem

#pragma mark - Initialization

- (instancetype)initWithItemImage:(UIImage *)itemImage {
    if (self = [super init]) {
        _itemImage = itemImage;
    }
    return self;
}

@end

// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YALTabBarItem : NSObject

@property (nonatomic, strong, nullable) UIImage *itemImage;
@property (nonatomic, copy, nullable) NSString *name;

- (instancetype)initWithItemImage:(UIImage * _Nullable)itemImage;

@end

NS_ASSUME_NONNULL_END

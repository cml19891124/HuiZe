//
//  UIViewController+HUZExtension.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/17.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (HUZExtension)
+ (UIViewController *)currentViewController;
+ (UINavigationController *)currentNavigationViewController;

@end

NS_ASSUME_NONNULL_END

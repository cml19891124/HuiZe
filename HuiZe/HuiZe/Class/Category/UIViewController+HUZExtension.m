//
//  UIViewController+HUZExtension.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/17.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "UIViewController+HUZExtension.h"

@implementation UIViewController (HUZExtension)
+ (UIViewController *)currentViewController {
    UIViewController *rootViewController = self.applicationDelegate.window.rootViewController;
    return [self currentViewControllerFrom:rootViewController];
}

+(UINavigationController *)currentNavigationViewController {
    UIViewController *currentViewController = [self currentViewController];
    return currentViewController.navigationController;
}
+ (id<UIApplicationDelegate>)applicationDelegate {
    return [UIApplication sharedApplication].delegate;
}

/** 递归拿到当控制器 */
+ (UIViewController *)currentViewControllerFrom:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)viewController;
        return [self currentViewControllerFrom:navigationController.viewControllers.lastObject];
    } else if ([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tableBarController = (UITabBarController *)viewController;
        return [self currentViewControllerFrom:tableBarController.selectedViewController];
    } else if (viewController.presentedViewController != nil) {
        return [self currentViewControllerFrom:viewController.presentedViewController];
    } else {
        return viewController;
    }
}
@end

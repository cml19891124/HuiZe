//
//  UITableViewController+HUZExtension.h
//  HuiZe
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewController (HUZExtension)

- (void)presentSheet:(NSString *)title;
- (void)presentSuccessSheet:(NSString *)title;
- (void)presentErrorSheet:(NSString *)title;
- (void)displayOverFlowActivityView;
- (void)removeOverFlowActivityView;
//延迟调用的方法
- (void)performBlock:(void(^)(void))block afterDelay:(NSTimeInterval)delay;
@end

NS_ASSUME_NONNULL_END

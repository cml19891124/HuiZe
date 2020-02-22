//
//  AppDelegate+Platform.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/17.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "AppDelegate.h"
#import "JPUSHService.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (Platform)<JPUSHRegisterDelegate>

//初始化 UMeng
-(void)initUMeng;

//微信支付 初始化
- (void)initWX;

// 初始化 JPush
- (void)initJPush;

@end

NS_ASSUME_NONNULL_END

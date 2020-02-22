//
//  HUZShareHelper.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/7.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HUZViewController.h"
//友盟分享
#import <UShareUI/UShareUI.h>
//压缩图片
#import "UIImage+Thumb.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZShareHelper : NSObject


+ (void)shareWithTitle:(NSString *)title weiboTitle:(NSString *)weiboTitle content:(NSString *)content image:(UIImage *)image imgUrl:(NSString *)imgUrl siteUrl:(NSString *)siteUrl viewController:(UIViewController *)viewController platform:(NSString *)platform;

@end

NS_ASSUME_NONNULL_END

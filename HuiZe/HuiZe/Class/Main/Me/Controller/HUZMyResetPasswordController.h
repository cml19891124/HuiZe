//
//  HUZMyResetPasswordController.h
//  HuiZe
//
//  Created by mac on 2019/5/14.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZTableViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^CallBackBlock)(void);

@interface HUZMyResetPasswordController : HUZTableViewController
@property (nonatomic,copy) CallBackBlock callBackBlock;

@end

NS_ASSUME_NONNULL_END

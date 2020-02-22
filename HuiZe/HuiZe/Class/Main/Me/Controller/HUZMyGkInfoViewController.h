//
//  HUZMyGkInfoViewController.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/5.
//  Copyright © 2019年 yiqi. All rights reserved.
//

/**
 我的高考信息
 */

#import "HUZViewController.h"

NS_ASSUME_NONNULL_BEGIN
//typedef void (^updateBlock) (void);
@interface HUZMyGkInfoViewController : HUZViewController
@property (nonatomic, copy) void (^updateBlock) (void);
@end

NS_ASSUME_NONNULL_END

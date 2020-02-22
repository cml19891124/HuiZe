//
//  HUZDynamicListViewController.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/26.
//  Copyright © 2019年 yiqi. All rights reserved.
//

/**
 高考动态列表
 */

#import "HUZTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZDynamicListViewController : HUZTableViewController

@property (nonatomic,strong) NSString *navTitle;
@property (nonatomic,assign) int type;  /// 类型:0教育部，1本省政策，2最新动态

@end

NS_ASSUME_NONNULL_END

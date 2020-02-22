//
//  HUZSearchHistoryViewController.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/20.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZViewController.h"
#import "HUZSearchViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZSearchHistoryViewController : HUZViewController
@property (nonatomic,strong) HUZSearchViewController *searchVC;

/// 刷新搜索记录
- (void)reloadSearchHistory;
@end

NS_ASSUME_NONNULL_END

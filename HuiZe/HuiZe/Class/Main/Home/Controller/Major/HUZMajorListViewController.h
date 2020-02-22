//
//  HUZMajorListViewController.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/29.
//  Copyright © 2019年 yiqi. All rights reserved.
//

/**
 所有专业--专业列表
 */

#import "HUZTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZMajorListViewController : HUZTableViewController

@property (nonatomic,strong) NSString *type;//1-专科 2-本科   type为nil--搜索专业

/// 搜索专科，本科 1-专科 2-本科
- (void)clickSearchMajorWithKeyword:(NSString *)keyword type:(int)type;

@property (nonatomic, assign) BOOL isSearch;

@end

NS_ASSUME_NONNULL_END

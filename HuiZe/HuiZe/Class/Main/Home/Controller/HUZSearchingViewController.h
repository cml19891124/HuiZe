//
//  HUZSearchingViewController.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/19.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZTableViewController.h"
#import "HUZSearchViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZSearchingViewController : HUZTableViewController
@property (nonatomic,strong) HUZSearchViewController *searchVC;


/// 设置搜索引擎查询结果
- (void)setUniKeyword:(NSArray *)uniArray majorKeywork:(NSArray *)majorArray keyword:(NSString *)keyword;

@end

NS_ASSUME_NONNULL_END

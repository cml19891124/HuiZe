//
//  HUZSearchResultViewController.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/19.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZViewController.h"
#import "HUZSearchViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZSearchResultViewController : HUZViewController

@property (nonatomic,strong) HUZSearchViewController *searchVC;

/// 传递搜索keyword
- (void)clickSearchWithKeyword:(NSString *)keyword;
@property (nonatomic,strong) NSString *keyword;

@property (nonatomic, assign) BOOL isGotoMajor;

@end

NS_ASSUME_NONNULL_END

//
//  HUZSearchViewController.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/19.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZSearchViewController : HUZViewController
@property (nonatomic, assign) BOOL isGotoMajor;
/// 点击模糊查询进行搜索
- (void)clickKeywordSearch:(NSString *)keyword;

@end

NS_ASSUME_NONNULL_END

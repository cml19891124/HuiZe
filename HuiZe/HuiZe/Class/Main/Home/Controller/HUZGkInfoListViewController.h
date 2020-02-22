//
//  HUZGkInfoListViewController.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/19.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZGkInfoListViewController : HUZTableViewController

@property (nonatomic,assign) int listId;  /// 列表id

@property (nonatomic, assign) BOOL vcCanScroll;
@property (nonatomic, assign) BOOL isRefresh;
@property (nonatomic, strong) NSString *str;
@end

NS_ASSUME_NONNULL_END

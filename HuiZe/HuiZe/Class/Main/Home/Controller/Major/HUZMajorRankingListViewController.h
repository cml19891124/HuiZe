//
//  HUZMajorRankingListViewController.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/29.
//  Copyright © 2019年 yiqi. All rights reserved.
//

/**
 理科专业排行榜/文科专业排行榜
 */

#import "HUZTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZMajorRankingListViewController : HUZTableViewController
@property (nonatomic,strong) NSString *navTitle;
@property (nonatomic, copy) NSString * assessMajorId;
@end

NS_ASSUME_NONNULL_END


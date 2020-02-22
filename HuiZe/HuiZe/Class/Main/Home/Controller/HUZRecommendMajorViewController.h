//
//  HUZRecommendMajorViewController.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/14.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZTableViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class HUZTargetBatchDataModel;
@interface HUZRecommendMajorViewController : HUZTableViewController

/// 默认排序
- (void)reset;
@property (nonatomic, strong) HUZTargetBatchDataModel * batchDataModel;
@end

NS_ASSUME_NONNULL_END

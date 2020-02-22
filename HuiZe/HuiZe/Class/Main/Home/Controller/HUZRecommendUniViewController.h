//
//  HUZRecommendUniViewController.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/14.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZTableViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class HUZTargetBatchDataModel;
@interface HUZRecommendUniViewController : HUZTableViewController
@property (nonatomic, strong) HUZTargetBatchDataModel * batchDataModel;
/// 默认排序
- (void)reset;

@end

NS_ASSUME_NONNULL_END

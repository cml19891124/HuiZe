//
//  HUZMajorMatchUniController.h
//  HuiZe
//
//  Created by mac on 2019/5/5.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZTableViewController.h"

#import "HUZMajorPriorityDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZMajorMatchUniController : HUZTableViewController

@property (nonatomic, strong) HUZMajorPriorityDataModel * _Nonnull dataModel;
@property (nonatomic, copy) NSString * batch;
@property (nonatomic, copy) NSArray * majorAllIdsArr;
@end

NS_ASSUME_NONNULL_END

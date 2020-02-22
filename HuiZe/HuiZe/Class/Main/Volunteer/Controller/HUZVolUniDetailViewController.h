//
//  HUZVolUniDetailViewController.h
//  HuiZe
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZTableViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class HUZSchoolModel;
@interface HUZVolUniDetailViewController : HUZTableViewController
@property (nonatomic, strong) HUZSchoolModel * schoolModel;
@property (nonatomic, copy) void(^delMarjorClickBlock)(void);

@property (nonatomic, copy) void(^delSchoolClickBlock)(NSIndexPath *indexPath);

@property (nonatomic, strong) NSIndexPath * indexPath;
@end

NS_ASSUME_NONNULL_END

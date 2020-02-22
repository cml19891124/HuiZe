//
//  HUZMajorCategoryViewController.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/29.
//  Copyright © 2019年 yiqi. All rights reserved.
//

/**
 专科专业类目
 */

#import "HUZTableViewController.h"
#import "HUZMajorListModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^SelectBlock)(HUZMajorListModel *model);
@interface HUZMajorCategoryViewController : HUZTableViewController
@property(nonatomic,copy)SelectBlock selectBlock;
@property (nonatomic, copy) NSString * category;

@end

NS_ASSUME_NONNULL_END


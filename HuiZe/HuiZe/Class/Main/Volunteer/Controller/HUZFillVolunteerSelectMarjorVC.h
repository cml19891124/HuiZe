//
//  HUZFillVolunteerSelectMarjorVC.h
//  HuiZe
//
//  Created by tbb on 2019/10/30.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HUZTableViewController.h"
NS_ASSUME_NONNULL_BEGIN
@class HUZUniInfoGeneralizeDataModel;
@interface HUZFillVolunteerSelectMarjorVC : HUZTableViewController

@property (nonatomic, strong) HUZUniInfoGeneralizeDataModel * infoModel;

@property (nonatomic, strong) NSArray * marjorArr;//已经选择的专业

@property (nonatomic, copy) void(^selectMarjorBlock)(NSArray *marjorArr);
@end

NS_ASSUME_NONNULL_END

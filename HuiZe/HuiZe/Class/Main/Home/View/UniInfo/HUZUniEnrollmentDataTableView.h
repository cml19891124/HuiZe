//
//  HUZUniEnrollmentDataTableView.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/25.
//  Copyright © 2019年 yiqi. All rights reserved.
//

/**
 大学详细-招录数据
 */

#import "HUZSegmentTableView.h"

NS_ASSUME_NONNULL_BEGIN
@class HUZAllMajorModel;
@interface HUZUniEnrollmentDataTableView : HUZSegmentTableView
/// 学校id
@property (nonatomic,copy) NSString *schoolId;

@property (nonatomic, strong) HUZAllMajorModel * majorModel;
@property (nonatomic, assign) NSInteger vipState;
@end

NS_ASSUME_NONNULL_END


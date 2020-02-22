//
//  HUZUniEnrollmentInfoTableView.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/25.
//  Copyright © 2019年 yiqi. All rights reserved.
//

/**
 大学详细-招生信息
 */

#import "HUZSegmentTableView.h"

NS_ASSUME_NONNULL_BEGIN
@class HUZAllMajorModel;
@interface HUZUniEnrollmentInfoTableView : HUZSegmentTableView

/// 学校id
@property (nonatomic,copy) NSString *schoolId;
@property (nonatomic, strong) HUZAllMajorModel * majorModel;
@property (nonatomic, assign) NSInteger vipState;

@end

NS_ASSUME_NONNULL_END

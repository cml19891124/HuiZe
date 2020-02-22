//
//  HUZUniInfoTableView.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/24.
//  Copyright © 2019年 yiqi. All rights reserved.
//
/**
 大学详细-学校概况
 */

#import "HUZSegmentTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZUniInfoTableView : HUZSegmentTableView

/// 学校id
@property (nonatomic,strong) NSString *schoolId;

/// tableview 头部数据
@property (nonatomic,strong) NSArray *dataHeader;

@end

NS_ASSUME_NONNULL_END

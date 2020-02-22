//
//  HUZSingleBarChartView.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/15.
//  Copyright © 2019年 yiqi. All rights reserved.
//

/**
 柱状图
 */

#import "HUZView.h"

NS_ASSUME_NONNULL_BEGIN
@class HUZUniEnrollmentDataChartModel;
@interface HUZSingleBarChartView : HUZView

@property (nonatomic,strong) NSArray *datas;  /// 柱状图数据
@property (nonatomic,strong) NSArray *dataYear; /// 年份
@property (nonatomic,strong) UILabel *labToppic;

@property (nonatomic, strong) HUZUniEnrollmentDataChartModel * chartModel;
@end

NS_ASSUME_NONNULL_END

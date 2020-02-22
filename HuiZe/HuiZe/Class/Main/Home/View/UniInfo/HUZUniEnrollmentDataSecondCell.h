//
//  HUZUniEnrollmentDataSecondCell.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/25.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZTableViewCell.h"
#import "HUZSingleBarChartView.h"
#import "HUZLineChartView.h"

NS_ASSUME_NONNULL_BEGIN
@class HUZUniEnrollmentDataChartModel;
@interface HUZUniEnrollmentDataSecondCell : HUZTableViewCell

@property (nonatomic,strong) HUZSingleBarChartView *singleBarChartView;//柱状图
@property (nonatomic,strong) HUZLineChartView *lineChartView;
@property (nonatomic, strong) HUZUniEnrollmentDataChartModel * chartModel;
@property (nonatomic, assign) NSInteger type;//@[0@"录取最低分",1@"最低分数差",2@"录取最低排名",3@"录取人数"]
@end

NS_ASSUME_NONNULL_END

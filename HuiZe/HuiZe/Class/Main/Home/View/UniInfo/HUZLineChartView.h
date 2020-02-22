//
//  HUZLineChartView.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/15.
//  Copyright © 2019年 yiqi. All rights reserved.
//

/**
 折线图
 */

#import "HUZView.h"

NS_ASSUME_NONNULL_BEGIN
@class HUZUniEnrollmentDataChartModel;
@interface HUZLineChartView : HUZView
@property (nonatomic,strong) UILabel *labToppic;

@property (nonatomic, strong) HUZUniEnrollmentDataChartModel * chartModel;
@property (nonatomic, assign) NSInteger type;//@[0@"录取最低分",1@"最低分数差",2@"录取最低排名",3@"录取人数"]
@end

NS_ASSUME_NONNULL_END

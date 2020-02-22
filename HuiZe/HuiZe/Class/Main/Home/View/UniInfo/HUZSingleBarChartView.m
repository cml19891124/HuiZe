//
//  HUZSingleBarChartView.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/15.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZSingleBarChartView.h"
#import "ZFChart.h"
#import "HUZUniEnrollmentDataChartModel.h"
@interface HUZSingleBarChartView ()<ZFGenericChartDataSource,ZFBarChartDelegate>

//@property (nonatomic,strong) UILabel *labToppic;
@property (nonatomic,strong) UILabel *labUnit;
@property (nonatomic, strong) ZFBarChart * barChart;


@end

@implementation HUZSingleBarChartView
-(void)setChartModel:(HUZUniEnrollmentDataChartModel *)chartModel {
    _chartModel = chartModel;
}
- (void)initView{
    self.labToppic.hidden = self.hidden;
    self.barChart = [[ZFBarChart alloc] initWithFrame:CGRectMake(-AutoDistance(20), AutoDistance(40), SCREEN_WIDTH+AutoDistance(20), AutoDistance(250))];
    self.barChart.dataSource = self;
    self.barChart.delegate = self;
    self.barChart.valueLabelPattern = kPopoverLabelPatternBlank;
    self.barChart.isShowXLineSeparate = NO;
    self.barChart.isShowYLineSeparate = NO;
    self.barChart.xAxisColor = ColorS(COLOR_BG_D8D8D8);  /// x轴颜色
    self.barChart.yAxisColor = ColorS(COLOR_BG_D8D8D8);  /// y轴颜色
    self.barChart.axisLineValueColor = ZFWhite;   /// y轴字体颜色
    self.barChart.axisLineNameColor = ColorS(COLOR_989898);  /// X轴字体颜色
    self.barChart.valueOnChartFont = FontS(FONT_10); /// 图表上的字体
    self.barChart.axisLineValueFont = FontS(FONT_14); ///
    self.barChart.isShowAxisArrows = NO;
    self.barChart.separateLineStyle = kLineStyleDashLine;
    self.barChart.isAnimated = NO;
    [self addSubview:self.barChart];
    
    self.labToppic = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_14)];
    self.labToppic.text = @"录取最低分";
    self.labToppic.frame = CGRectMake(HUZSCREEN_WIDTH-AutoDistance(115), AutoDistance(20), AutoDistance(90), AutoDistance(20));
    [self addSubview:self.labToppic];
    
    self.labUnit = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labUnit.text = @"名次";
    self.labUnit.frame = CGRectMake(AutoDistance(38), AutoDistance(62), AutoDistance(50), AutoDistance(17));
    [self addSubview:self.labUnit];
}

- (void)setDatas:(NSArray *)datas{
    _datas = datas;
    [self.barChart strokePath];
}

- (void)setDataYear:(NSArray *)dataYear{
    _dataYear = dataYear;
    [self.barChart strokePath];
}

#pragma mark - ZFGenericChartDataSource
/// 柱状图数据
- (NSArray *)valueArrayInGenericChart:(ZFGenericChart *)chart{
    return _datas;
}

/// x轴数据
- (NSArray *)nameArrayInGenericChart:(ZFGenericChart *)chart{
    return _dataYear;
}

/// 柱状图颜色
- (NSArray *)colorArrayInGenericChart:(ZFGenericChart *)chart{
    return @[ColorS(COLOR_BG_2E86FF)];
}

/// y轴分块数量
- (NSUInteger)axisLineSectionCountInGenericChart:(ZFGenericChart *)chart{
    return 5;
}

#pragma mark - ZFBarChartDelegate
/// bar 宽度
- (CGFloat)barWidthInBarChart:(ZFBarChart *)barChart{
    return AutoDistance(24);
}

/// bar之间距离
- (CGFloat)paddingForGroupsInBarChart:(ZFBarChart *)barChart{
    return AutoDistance(30);
}

/// bar上的字体颜色
- (id)valueTextColorArrayInBarChart:(ZFBarChart *)barChart{
    return ColorS(COLOR_2E86FF);
}

- (void)barChart:(ZFBarChart *)barChart didSelectBarAtGroupIndex:(NSInteger)groupIndex barIndex:(NSInteger)barIndex bar:(ZFBar *)bar popoverLabel:(ZFPopoverLabel *)popoverLabel{
    bar.isAnimated = YES;
    [bar strokePath];

}

- (void)barChart:(ZFBarChart *)barChart didSelectPopoverLabelAtGroupIndex:(NSInteger)groupIndex labelIndex:(NSInteger)labelIndex popoverLabel:(ZFPopoverLabel *)popoverLabel{
}

@end

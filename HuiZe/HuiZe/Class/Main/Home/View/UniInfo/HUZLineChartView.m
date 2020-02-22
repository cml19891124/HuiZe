//
//  HUZLineChartView.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/15.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZLineChartView.h"
#import "ZFChart.h"
#import "HUZUniEnrollmentDataChartModel.h"
@interface HUZLineChartView ()<ZFGenericChartDataSource, ZFLineChartDelegate>

@property (nonatomic,strong) UIImageView *ivType1;
@property (nonatomic,strong) UILabel *labType1;
@property (nonatomic,strong) UIImageView *ivType2;
@property (nonatomic,strong) UILabel *labType2;
@property (nonatomic,strong) UILabel *labUnit;

@property (nonatomic,strong) ZFLineChart *lineChart;
@property (nonatomic, strong) NSMutableArray * yearArr;
@property (nonatomic, strong) NSMutableArray * scoreArr;
@end

@implementation HUZLineChartView
-(void)setChartModel:(HUZUniEnrollmentDataChartModel *)chartModel {
    _chartModel = chartModel;

    NSMutableArray *provinceScoreYeaerArr = [NSMutableArray array];
    NSMutableArray *admissionScoreScoreYeaerArr = [NSMutableArray array];
    
    NSMutableArray *provinceScoreArr = [NSMutableArray array];
    NSMutableArray *admissionScoreScoreArr = [NSMutableArray array];
    
    
    for (HUZUniEnrollmentDataChartScoreModel *scoreModel in chartModel.provinceScore) {
        [provinceScoreArr addObject:scoreModel.score];
        [provinceScoreYeaerArr addObject:scoreModel.year];
    }
    
    for (HUZUniEnrollmentDataChartScoreModel *scoreModel in chartModel.admissionScore) {
        [admissionScoreScoreArr addObject:scoreModel.score];
        [admissionScoreScoreYeaerArr addObject:scoreModel.year];
    }
    
    [self.scoreArr removeAllObjects];
    [self.yearArr removeAllObjects];
    
    if (provinceScoreYeaerArr.count > admissionScoreScoreYeaerArr.count) {
        [self.yearArr addObjectsFromArray:provinceScoreYeaerArr.copy];
    }else{
        [self.yearArr addObjectsFromArray:admissionScoreScoreYeaerArr.copy];
    }


    if (self.type == 0) {
        if (self.yearArr.count > provinceScoreArr.count) {
            for (NSInteger i = 0; i < self.yearArr.count; i++) {
                if (i >= provinceScoreArr.count-1) {
                    [provinceScoreArr addObject:@""];//补全
                }
            }
        }
        [self.scoreArr addObject:provinceScoreArr];
    }
    
    if (self.yearArr.count > admissionScoreScoreArr.count) {
        for (NSInteger i = 0; i < self.yearArr.count; i++) {
            if (i > admissionScoreScoreArr.count-1) {
                [admissionScoreScoreArr addObject:@""];//补全
            }
        }
    }
    
    [self.scoreArr addObject:admissionScoreScoreArr];
    
    [self.lineChart strokePath];
}
-(void)setType:(NSInteger)type {
    _type = type;
    if (type == 0) {
        self.ivType1.hidden = NO;
        self.ivType2.hidden = NO;
        self.labType1.hidden = NO;
        self.labType2.hidden = NO;
    }else{
        self.ivType1.hidden = YES;
        self.ivType2.hidden = YES;
        self.labType1.hidden = YES;
        self.labType2.hidden = YES;
    }
}
- (void)initView{
    self.labToppic.hidden = self.hidden;
    self.lineChart = [[ZFLineChart alloc] initWithFrame:CGRectMake(-AutoDistance(20), AutoDistance(50), SCREEN_WIDTH+AutoDistance(20), AutoDistance(250))];
    self.lineChart.dataSource = self;
    self.lineChart.delegate = self;
    self.lineChart.valueLabelPattern = kPopoverLabelPatternBlank;
    self.lineChart.isShowXLineSeparate = NO;
    self.lineChart.isShowYLineSeparate = NO;
    self.lineChart.xAxisColor = ColorS(COLOR_BG_D8D8D8);  /// x轴颜色
    self.lineChart.yAxisColor = ColorS(COLOR_BG_D8D8D8);  /// y轴颜色
    self.lineChart.axisLineValueColor = ZFWhite;   /// y轴字体颜色
    self.lineChart.axisLineNameColor = ColorS(COLOR_989898);  /// X轴字体颜色
    self.lineChart.valueOnChartFont = FontS(FONT_10); /// 图表上的字体
    self.lineChart.axisLineValueFont = FontS(FONT_14); ///
    self.lineChart.isShowAxisArrows = NO;
    self.lineChart.separateLineStyle = kLineStyleDashLine;
    self.lineChart.isAnimated = NO;
    self.lineChart.shadowColor = [UIColor clearColor];
    [self addSubview:self.lineChart];
    [self.lineChart strokePath];
    
    self.labToppic = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_14) textAlignment:NSTextAlignmentRight];
    self.labToppic.text = @"录取最低分";
    self.labToppic.frame = CGRectMake(HUZSCREEN_WIDTH-AutoDistance(102), AutoDistance(20), AutoDistance(72), AutoDistance(20));
    [self addSubview:self.labToppic];

    self.ivType1 = [UIImageView new];
    self.ivType1.backgroundColor = ColorS(COLOR_BG_F19147);
    self.ivType1.frame = CGRectMake(HUZSCREEN_WIDTH-AutoDistance(72), AutoDistance(52), AutoDistance(6), AutoDistance(6));
    ViewRadius(self.ivType1, AutoDistance(3));
    [self addSubview:self.ivType1];

    self.labType1 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_10) textAlignment:NSTextAlignmentRight];
    self.labType1.text = @"省控线";
    self.labType1.frame = CGRectMake(HUZSCREEN_WIDTH-AutoDistance(60), AutoDistance(48), AutoDistance(35), AutoDistance(14));
    [self addSubview:self.labType1];

    self.ivType2 = [UIImageView new];
    self.ivType2.backgroundColor = ColorS(COLOR_2E86FF);
    self.ivType2.frame = CGRectMake(HUZSCREEN_WIDTH-AutoDistance(92), AutoDistance(72), AutoDistance(6), AutoDistance(6));
    ViewRadius(self.ivType2, AutoDistance(3));
    [self addSubview:self.ivType2];

    self.labType2 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_10) textAlignment:NSTextAlignmentRight];
    self.labType2.text = @"录取最低分";
    self.labType2.frame = CGRectMake(HUZSCREEN_WIDTH-AutoDistance(81), AutoDistance(68), AutoDistance(55), AutoDistance(14));
    [self addSubview:self.labType2];
    
    self.labUnit = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labUnit.text = @"分数";
    self.labUnit.frame = CGRectMake(AutoDistance(38), AutoDistance(72), AutoDistance(50), AutoDistance(17));
    [self addSubview:self.labUnit];
}

#pragma mark - ZFGenericChartDataSource
/// 折线图数据
- (NSArray *)valueArrayInGenericChart:(ZFGenericChart *)chart{
//    return @[@[ @"300", @"490", @"380", @"167", @"451"],
//             @[@"380", @"200", @"326", @"240", @"137",@"120"],
//             ];
    return self.scoreArr;
}

/// x轴数据
- (NSArray *)nameArrayInGenericChart:(ZFGenericChart *)chart{
//    return @[@"2014", @"2015", @"2016", @"2017", @"2018"];
    return self.yearArr;
}

/// 折线图颜色
- (NSArray *)colorArrayInGenericChart:(ZFGenericChart *)chart{
    return @[ColorS(COLOR_2E86FF),ColorS(COLOR_F19147)];
}

/// y轴分块数量
- (NSUInteger)axisLineSectionCountInGenericChart:(ZFGenericChart *)chart{
    return 5;
}

#pragma mark - ZFLineChartDelegate
- (void)lineChart:(ZFLineChart *)lineChart didSelectCircleAtLineIndex:(NSInteger)lineIndex circleIndex:(NSInteger)circleIndex circle:(ZFCircle *)circle popoverLabel:(ZFPopoverLabel *)popoverLabel{
    circle.isAnimated = YES;
    [circle strokePath];
}

- (void)lineChart:(ZFLineChart *)lineChart didSelectPopoverLabelAtLineIndex:(NSInteger)lineIndex circleIndex:(NSInteger)circleIndex popoverLabel:(ZFPopoverLabel *)popoverLabel{
    
}

/**
 *  组宽(若不设置，默认为25.f)
 */
- (CGFloat)groupWidthInLineChart:(ZFLineChart *)lineChart{
    return AutoDistance(40);
}

/**
 *  组与组之间的间距(若不设置，默认为20.f)
 */
- (CGFloat)paddingForGroupsInLineChart:(ZFLineChart *)lineChart{
    return AutoDistance(20);
}

/**
 *  圆的半径(若不设置，默认为5.f)
 */
- (CGFloat)circleRadiusInLineChart:(ZFLineChart *)lineChart{
    return AutoDistance(4);
}

/**
 *  线宽(若不设置，默认为2.f)
 */
- (CGFloat)lineWidthInLineChart:(ZFLineChart *)lineChart{
    return AutoDistance(1);
}


-(NSMutableArray *)yearArr {
    if (!_yearArr) {
        _yearArr = [NSMutableArray array];
    }
    return _yearArr;
}

-(NSMutableArray *)scoreArr {
    if (!_scoreArr) {
        _scoreArr = [NSMutableArray array];
    }
    return _scoreArr;
}
@end

//
//  HUZUniEnrollmentDataSecondCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/25.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniEnrollmentDataSecondCell.h"
#import "HUZUniEnrollmentDataChartModel.h"
@implementation HUZUniEnrollmentDataSecondCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZUniEnrollmentDataSecondCell";
    HUZUniEnrollmentDataSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

-(void)setChartModel:(HUZUniEnrollmentDataChartModel *)chartModel {
    _chartModel = chartModel;
    self.lineChartView.type = self.type;
    if (self.type == 2 || self.type == 3) {
        self.singleBarChartView.chartModel = chartModel;
        NSMutableArray *yearArr = [NSMutableArray array];
        NSMutableArray *scoreArr = [NSMutableArray array];
        if (self.type == 3 || self.type == 2) {
            for (HUZUniEnrollmentDataChartScoreModel *scoreModel in chartModel.admissionScore) {
                [yearArr addObject:scoreModel.year];
                if(self.type == 3) {
                    [scoreArr addObject:[NSString stringWithFormat:@"%@人",scoreModel.score]];
                }else{
                    [scoreArr addObject:[NSString stringWithFormat:@"%@名",scoreModel.score]];
                }
            }
            self.singleBarChartView.datas = scoreArr.copy;
            self.singleBarChartView.dataYear = yearArr.copy;
        }
    }else{
        self.lineChartView.chartModel = chartModel;
    }
}

- (void)initView{
    
    self.singleBarChartView = [[HUZSingleBarChartView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(290))];
//    self.singleBarChartView.datas = @[@"123名", @"256名", @"300名", @"283名", @"490名"];
//    self.singleBarChartView.dataYear =  @[@"2014", @"2015", @"2016", @"2017", @"2018"];
    [self.contentView addSubview:self.singleBarChartView];
//    self.singleBarChartView.hidden = YES;
    
    self.lineChartView = [[HUZLineChartView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(290))];
    [self.contentView addSubview:self.lineChartView];
    self.type = 3;
//    self.lineChartView.hidden = NO;
}
//@[0@"录取最低分",1@"最低分数差",2@"录取最低排名",3@"录取人数"]
-(void)setType:(NSInteger)type {
    _type = type;
    if (type == 3 || type == 2) {
        self.singleBarChartView.hidden = NO;
        self.lineChartView.hidden = YES;
    }else{
        self.singleBarChartView.hidden = YES;
        self.lineChartView.hidden = NO;
    }
}
@end

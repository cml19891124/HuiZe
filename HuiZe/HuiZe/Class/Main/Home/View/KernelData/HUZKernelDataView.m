//
//  HUZKernelDataView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/22.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZKernelDataView.h"

@implementation HUZKernelDataView


- (void)initView{
    
    self.gkInfoView = [HUZKernelDataItemView new];
    self.gkInfoView.type = HUZKernelDataItemTypeOne;
    
    self.scorelineView = [HUZKernelDataItemView new];
    self.scorelineView.type = HUZKernelDataItemTypeTwo;
    
    [self addSubview:self.gkInfoView];
    [self addSubview:self.scorelineView];
    
    [self.gkInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(14));
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(HUZSCREEN_WIDTH - AutoDistance(30), AutoDistance(121)));
    }];
    
    [self.scorelineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.gkInfoView.mas_bottom).offset(AutoDistance(18));
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(HUZSCREEN_WIDTH - AutoDistance(30), AutoDistance(121)));
    }];
}

- (void)setScoreSectionModel:(HUZKernalScoreSectionModel *)scoreSectionModel{
    self.gkInfoView.labScoreDes.text = scoreSectionModel.data.score;
    self.gkInfoView.labNumDes.text = scoreSectionModel.data.scoreNum;
    self.gkInfoView.labTotalNumDes.text = scoreSectionModel.data.cumulativeNum;
}

- (void)setScoreLineModel:(HUZKernalScoreLineModel *)scoreLineModel{
    if (scoreLineModel.data.count == 3) {
        self.scorelineView.labScore.text = [self getUniBatch:scoreLineModel.data[0]];
        self.scorelineView.labScoreDes.text = scoreLineModel.data[0].score;
        
        self.scorelineView.labNum.text = [self getUniBatch:scoreLineModel.data[1]];
        self.scorelineView.labNumDes.text = scoreLineModel.data[1].score;
        
        self.scorelineView.labTotalNum.text = [self getUniBatch:scoreLineModel.data[2]];
        self.scorelineView.labTotalNumDes.text = scoreLineModel.data[2].score;
    }else{
        self.scorelineView.labScore.text = @"";
        self.scorelineView.labScoreDes.text = @"";
        self.scorelineView.labNum.text = @"";
        self.scorelineView.labNumDes.text = @"";
        
        self.scorelineView.labTotalNum.text = @"";
        self.scorelineView.labTotalNumDes.text = @"";
    }

}

/// 获取批次
/// 0本科批， 1本科一批，2本科二批，3本科三批，4专科批，5平行录取一段，6平行录取二段，7平行录取三段，8本科提前批 ，9国家专项计划本科批
- (NSString *)getUniBatch:(HUZKernalScoreLineDataModel *)model{
    int batch = [model.batch intValue];
    NSString *batchStr = @"";
    switch (batch) {
        case 0:
            batchStr = @"本科批";
            break;
        case 1:
            batchStr = @"本科一批";
            break;
        case 2:
            batchStr = @"本科二批";
            break;
        case 3:
            batchStr = @"本科三批";
            break;
        case 4:
            batchStr = @"专科批";
            break;
        case 5:
            batchStr = @"平行录取一段";
            break;
        case 6:
            batchStr = @"平行录取二段";
            break;
        case 7:
            batchStr = @"平行录取三段";
            break;
        case 8:
            batchStr = @"本科提前批";
            break;
        case 9:
            batchStr = @"国家专项计划本科批";
            break;
        default:
            break;
    }
    return batchStr;
}

@end


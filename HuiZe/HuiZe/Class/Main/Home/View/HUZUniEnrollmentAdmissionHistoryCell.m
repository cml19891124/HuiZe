//
//  HUZUniEnrollmentAdmissionHistoryCell.m
//  HuiZe
//
//  Created by tbb on 2019/11/19.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZUniEnrollmentAdmissionHistoryCell.h"
#import "HUZUniEnrollmentAdmissionHistoryModel.h"
@implementation HUZUniEnrollmentAdmissionHistoryCell
-(void)setHistoryModel:(HUZUniEnrollmentAdmissionHistoryModel *)historyModel {
    _historyModel = historyModel;
    NSString *batch = [NSString stringWithFormat:@"%@\n%@",historyModel.year,historyModel.batch];
    NSString *max = [NSString stringWithFormat:@"%@\n%@",historyModel.maxScore,historyModel.average];
    NSString *min = [NSString stringWithFormat:@"%@\n%@",historyModel.minScore,historyModel.minRanking];
    self.batchLb.text = batch;
    self.maxLb.text = max;
    self.minLb.text = min;
    self.plaNumLb.text = historyModel.admissionNum;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

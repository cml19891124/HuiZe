//
//  HUZFillVolunteerSelectMarjorCell.m
//  HuiZe
//
//  Created by tbb on 2019/11/5.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZFillVolunteerSelectMarjorCell.h"
#import "HUZUniInfoGeneralizeModel.h"
@implementation HUZFillVolunteerSelectMarjorCell

-(void)setMajorModel:(HUZUniInfoGeneralizeMajorModel *)majorModel {
    _majorModel = majorModel;
    self.titleLb.text = majorModel.majIntroduce;
    self.minScoreLb.text = [NSString stringWithFormat:@"18年录取最低分 %@",majorModel.minScore];
    self.minRankingLb.text = [NSString stringWithFormat:@"18年录取最低排名  %@",majorModel.minRanking];
    self.admissionNumLb.text = [NSString stringWithFormat:@"19年招生 %@人",majorModel.planNum];
    
    if (majorModel.alternative) {
        self.selectBtn.backgroundColor = ColorS(COLOR_BG_F19147);
    }else{
        self.selectBtn.backgroundColor = ColorS(COLOR_2E86FF);;
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.selectBtn.layer.cornerRadius = 5.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

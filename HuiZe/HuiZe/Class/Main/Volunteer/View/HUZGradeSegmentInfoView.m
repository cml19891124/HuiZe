//
//  HUZGradeSegmentInfoView.m
//  HuiZe
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZGradeSegmentInfoView.h"

@implementation HUZGradeSegmentInfoView


- (void)initView{
    
    self.backgroundColor = COLOR_BG_WHITE;
    ViewRadius(self, AutoDistance(12));
    
    self.labScoreLine = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_14)];
    self.labScoreLine.text = @"广东省";
    
    self.labCenter = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:BoldFontS(FONT_14) textAlignment:NSTextAlignmentCenter];
    self.labCenter.text = @"一分一段";
    
    self.btnYear = [[UIButton alloc] initWithTitle:HUZDataBaseManager.dataYear[0] textColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_14)];
    [self.btnYear setImage:ImageNamed(@"ic_pull_down2") forState:UIControlStateNormal];
    
    self.labScore = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12) textAlignment:NSTextAlignmentCenter];
    self.labScore.adjustsFontSizeToFitWidth = YES;
    
    self.labScoreDes = [[UILabel alloc] initWithTextColor:ColorS(COLOR_2E86FF) autoTextFont:FontS(FONT_12) textAlignment:NSTextAlignmentCenter];
    
    self.labNum = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12) textAlignment:NSTextAlignmentCenter];
    self.labNum.adjustsFontSizeToFitWidth = YES;
    
    self.labNumDes = [[UILabel alloc] initWithTextColor:ColorS(COLOR_2E86FF) autoTextFont:FontS(FONT_12) textAlignment:NSTextAlignmentCenter];
    
    self.labTotalNum = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12) textAlignment:NSTextAlignmentCenter];
    self.labTotalNum.adjustsFontSizeToFitWidth = YES;
    
    self.labTotalNumDes = [[UILabel alloc] initWithTextColor:ColorS(COLOR_2E86FF) autoTextFont:FontS(FONT_12) textAlignment:NSTextAlignmentCenter];
    
    self.labScore.text = @"分值";
    self.labNum.text = @"本段人数";
    self.labTotalNum.text = @"累计人数";
    
    [self addSubview:self.labScoreLine];
    [self addSubview:self.labCenter];
    [self addSubview:self.btnYear];
    [self addSubview:self.labScore];
    [self addSubview:self.labScoreDes];
    [self addSubview:self.labNum];
    [self addSubview:self.labNumDes];
    [self addSubview:self.labTotalNum];
    [self addSubview:self.labTotalNumDes];
    
    
    [self.labScoreLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(27));
        make.left.mas_offset(AutoDistance(24));
    }];
    
    [self.labCenter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labScoreLine);
        make.centerX.equalTo(self);
    }];
    
    [self.btnYear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labScoreLine);
        make.right.mas_offset(-AutoDistance(15));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(65), AutoDistance(20)));
    }];
    
    [self.labScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labScoreLine.mas_bottom).offset(AutoDistance(18));
        make.left.mas_offset(AutoDistance(25));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(50), AutoDistance(17)));
    }];
    
    [self.labNumDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labScore.mas_bottom).offset(AutoDistance(8));
        make.centerX.equalTo(self.labNum);
    }];
    
    [self.labNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.labScore);
    }];
    
    
    [self.labScoreDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labNumDes);
        make.centerX.equalTo(self.labScore);
    }];
    
    [self.labTotalNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.btnYear);
        make.centerY.equalTo(self.labScore);
    }];
    
    [self.labTotalNumDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labNum.mas_bottom).offset(AutoDistance(8));
        make.centerX.equalTo(self.labTotalNum);
    }];
    
    [self.btnYear jk_setImagePosition:LXMImagePositionRight spacing:0];
    
}

- (void)setScoreSectionModel:(HUZKernalScoreSectionModel *)scoreSectionModel{
    self.labScoreDes.text = scoreSectionModel.data.score;
    self.labNumDes.text = scoreSectionModel.data.scoreNum;
    self.labTotalNumDes.text = scoreSectionModel.data.cumulativeNum;
}

@end

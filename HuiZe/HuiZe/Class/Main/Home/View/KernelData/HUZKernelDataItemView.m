//
//  HUZKernelDataItemView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/22.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZKernelDataItemView.h"

@implementation HUZKernelDataItemView

- (void)initView{
    
    self.backgroundColor = COLOR_BG_WHITE;
    ViewRadius(self, AutoDistance(12));
    
    self.ivGk = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_gk_info")];
    
    self.labGkInfo = [[UILabel alloc] initWithTextColor:ColorS(COLOR_2E86FF) autoTextFont:FontS(FONT_12)];
    self.labGkInfo.text = @"高考信息";
    
    self.labScoreLine = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:BoldFontS(FONT_14)];
    self.labScoreLine.text = @"分数线";
    
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
    
    [self addSubview:self.ivGk];
    [self addSubview:self.labGkInfo];
    [self addSubview:self.labScoreLine];
    [self addSubview:self.labCenter];
    [self addSubview:self.btnYear];
    [self addSubview:self.labScore];
    [self addSubview:self.labScoreDes];
    [self addSubview:self.labNum];
    [self addSubview:self.labNumDes];
    [self addSubview:self.labTotalNum];
    [self addSubview:self.labTotalNumDes];
    
    [self.ivGk mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(27));
        make.left.mas_offset(AutoDistance(24));
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    [self.labGkInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.ivGk);
        make.left.equalTo(self.ivGk.mas_right).offset(AutoDistance(3));
    }];
    
    [self.labScoreLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.ivGk);
        make.left.mas_offset(AutoDistance(24));
    }];
     
     [self.labCenter mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerY.equalTo(self.ivGk);
         make.centerX.equalTo(self);
     }];
    
    [self.btnYear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.ivGk);
        make.right.mas_offset(-AutoDistance(15));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(65), AutoDistance(20)));
    }];
    
     [self.labScore mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.ivGk.mas_bottom).offset(AutoDistance(18));
         make.left.mas_offset(AutoDistance(25));
         make.size.mas_equalTo(CGSizeMake(AutoDistance(50), AutoDistance(17)));
     }];
    
    [self.labScoreDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labScore.mas_bottom).offset(AutoDistance(8));
        make.centerX.equalTo(self.labScore);
    }];
    
    [self.labNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.labScore);
    }];
    
    [self.labNumDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labNum.mas_bottom).offset(AutoDistance(8));
        make.centerX.equalTo(self.labNum);
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

- (void)setType:(HUZKernelDataItemType)type{
    if (type == HUZKernelDataItemTypeOne) {
        self.ivGk.hidden = NO;
        self.labGkInfo.hidden = NO;
        self.labScoreLine.hidden = YES;
        self.labScore.text = @"分值";
        self.labNum.text = @"本段人数";
        self.labTotalNum.text = @"累计人数";
    }else{
        self.ivGk.hidden = YES;
        self.labGkInfo.hidden = YES;
        self.labScoreLine.hidden = NO;
        self.labCenter.text = @"";
    }
}


@end

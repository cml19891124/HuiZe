//
//  HUZVolunteerDetailView.m
//  HuiZe
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZVolunteerDetailView.h"
#import "HUZIntelligenceDetailModel.h"
@implementation HUZVolunteerDetailView
-(void)setDataModel:(HUZIntelligenceDetailDataModel *)dataModel {
    _dataModel = dataModel;
    NSString *rationality = @"";
    if (dataModel.reasonable == 0) {
        self.bgView.backgroundColor = ColorS(COLOR_BG_FF2E4A);
        rationality = [NSString stringWithFormat:@"合理性 不合理 、点击优化"];
    }else if (dataModel.reasonable == 1) {
        rationality = [NSString stringWithFormat:@"合理性 良好 、有可优化选项"];
        self.bgView.backgroundColor = ColorS(COLOR_BG_F8C301);
    }else if (dataModel.reasonable == 2) {
        rationality = [NSString stringWithFormat:@"合理性 非常好 、点击查看完整分析报告"];
        self.bgView.backgroundColor = ColorS(COLOR_BG_1ACD38);
    }
    self.labTitle.text = HUZUserCenterManager.gkInfo;
    self.labName.text = dataModel.volunteerName;
    self.labDate.text = dataModel.createTime;//[HUZTools timestampSwitchTime:[NSString stringWithFormat:@"%ld",dataModel.createTime] andFormatter:@"YY/MM/dd"];
}
- (void)initView {
    
    self.backgroundColor = COLOR_BG_WHITE;
    
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(45))];
    self.bgView.hidden = YES;
    self.bgView.backgroundColor = ColorS(COLOR_BG_1ACD38);
    self.bgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [self.bgView addGestureRecognizer:tap];
    [self addSubview:self.bgView];
    
    self.labTip = [[UILabel alloc] initWithTextColor:COLOR_BG_WHITE autoTextFont:FontS(FONT_12)];
    self.labTip.frame = CGRectMake(AutoDistance(15), AutoDistance(14), AutoDistance(235), AutoDistance(17));
    self.labTip.text = @"合理性 非常好 、点击查看完整的分析报告";
    [self.bgView addSubview:self.labTip];
    
//    UIButton *btn = [[UIButton alloc]initWithImageNormal:@"ic_arrow_detail" imageHighlight:@"ic_arrow_detail"];
    UIButton *btn = [[UIButton alloc]initWithTitle:@">" textColor:COLOR_BG_WHITE autoTextFont:FontS(FONT_15)];
    btn.frame = CGRectMake( HUZSCREEN_WIDTH - AutoDistance(6) - AutoDistance(15), AutoDistance(16), AutoDistance(10), AutoDistance(15));
    btn.userInteractionEnabled = NO;
    [self.bgView addSubview:btn];
    
    self.labTitle = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_15)];
    self.labTitle.text = @"广东省、理科、600分";
    
    self.labName = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_15)];
    self.labName.text = @"志愿表01";
    
    self.labDate = [[UILabel alloc] initWithTextColor:ColorS(COLOR_C8C8C8) autoTextFont:FontS(FONT_12)];
    self.labDate.text = @"2019-01-01 ";
    
    UIButton *editBtn = [UIButton buttonWithType:0];
    editBtn.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    [editBtn setTitleColor:ColorS(COLOR_BG_2E86FF) forState:(UIControlStateNormal)];
    [editBtn addTarget:self action:@selector(goToEditAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    [self addSubview:self.labTitle];
    [self addSubview:self.labName];
    [self addSubview:self.labDate];
 
    
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(AutoDistance(18));
        make.left.mas_offset(AutoDistance(15));
        make.height.mas_offset(AutoDistance(21));
    }];
    
    [self.labName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTitle.mas_bottom).offset(AutoDistance(8));
        make.leading.equalTo(self.labTitle);
    }];
    
    [self.labDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labTitle);
        make.right.mas_offset(-AutoDistance(15));
        make.height.mas_offset(AutoDistance(17));
    }];
    
    UIView *sectionView = [UIView new];
    sectionView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    [self addSubview:sectionView];
    [sectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];
    
}
#warning mark -- 编辑
-(void)goToEditAction:(UIButton *)sender {
    
}
- (void)tapClick:(UITapGestureRecognizer *)tap {
    if (_detailBlock) {
        _detailBlock();
    }
}
@end

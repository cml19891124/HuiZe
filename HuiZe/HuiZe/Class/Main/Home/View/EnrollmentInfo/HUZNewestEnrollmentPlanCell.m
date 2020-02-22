//
//  HUZNewestEnrollmentPlanCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/26.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZNewestEnrollmentPlanCell.h"

@implementation HUZNewestEnrollmentPlanCell

- (void)initView{
    
    self.labMojor = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    self.labMojor.text = @"电子信息类";
    
    self.labDes = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_10)];
    self.labDes.text = @"18计划招生 4人";
    
    self.ivArrow = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_more_arrow")];
    
    self.ivDiviceline = [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    [self.contentView addSubview:self.labMojor];
    [self.contentView addSubview:self.labDes];
    [self.contentView addSubview:self.ivArrow];
    [self.contentView addSubview:self.ivDiviceline];
    
    [self.labMojor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(18));
        make.left.mas_offset(AutoDistance(15));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(240), AutoDistance(21)));
    }];
    
    [self.labDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labMojor.mas_bottom).offset(AutoDistance(8));
        make.left.mas_offset(AutoDistance(15));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(200), AutoDistance(14)));
    }];
    
    [self.ivArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.mas_offset(-AutoDistance(15));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(12), AutoDistance(12)));
    }];
    
    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(AutoDistance(2));
    }];
}

@end

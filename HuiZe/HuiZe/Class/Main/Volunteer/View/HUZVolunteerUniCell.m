//
//  HUZVolunteerUniCell.m
//  HuiZe
//
//  Created by mac on 2019/4/27.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZVolunteerUniCell.h"

@implementation HUZVolunteerUniCell


+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZVolunteerUniCell";
    HUZVolunteerUniCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (void)initView{
    
    self.isZero = YES;
    
    self.ivLogo = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_uni_logo")];
    ViewRadius(self.ivLogo, AutoDistance(22/2));
    
    self.labSchool = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    self.labSchool.text = @"北京大学";
    
    self.labCity = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labCity.text = @"北京市";
    
    self.labDes1 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    
    self.labDes2 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    
    self.labDes3 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    
    self.labDes4 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    
    self.ivDiviceline= [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    self.btnAdd = [[UIButton alloc]initWithTitle:@"备选专业" textColor:COLOR_BG_WHITE autoTextFont:FontS(FONT_12)];
    [self.btnAdd setImage:ImageNamed(@"ic_btn_uni_add") forState:UIControlStateNormal];
    [self.btnAdd setImage:ImageNamed(@"ic_btn_gg_small") forState:UIControlStateSelected];
    [self.btnAdd setTitle:@"已加备选" forState:UIControlStateSelected];
    [self.btnAdd addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    ViewRadius(self.btnAdd, 4);
    
    [self.contentView addSubview:self.ivLogo];
    [self.contentView addSubview:self.labSchool];
    [self.contentView addSubview:self.labCity];
    [self.contentView addSubview:self.labDes1];
    [self.contentView addSubview:self.labDes2];
    [self.contentView addSubview:self.labDes3];
    [self.contentView addSubview:self.labDes4];
    [self.contentView addSubview:self.ivDiviceline];
    [self.contentView addSubview:self.btnAdd];

    [self.ivLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(20));
        make.left.mas_offset(AutoDistance(15));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(22), AutoDistance(22)));
    }];
    
    [self.labSchool mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.ivLogo);
        make.left.equalTo(self.ivLogo.mas_right).offset(AutoDistance(4));
    }];
    
    [self.labCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(24));
        make.left.equalTo(self.labSchool.mas_right).offset(AutoDistance(12));
    }];
    
    [self.labDes1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labSchool.mas_bottom).offset(AutoDistance(6));
        make.left.mas_offset(AutoDistance(41));
    }];
    
    [self.labDes2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labDes1);
        make.left.equalTo(self.labDes1.mas_right).offset(AutoDistance(32));
    }];
    
    [self.labDes3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labDes2.mas_bottom).offset(AutoDistance(4));
        make.left.mas_offset(AutoDistance(41));
    }];
    
    [self.labDes4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labDes3);
        make.left.equalTo(self.labDes3.mas_right).offset(AutoDistance(32));
    }];
    
    [self.btnAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.labSchool);
        make.top.equalTo(self.labDes3.mas_bottom).offset(AutoDistance(24));
        make.size.sizeOffset(CGSizeMake(AutoDistance(90), AutoDistance(40)));
    }];
    
    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(AutoDistance(8));
    }];
    
}

- (void)addClick {
    if (_addMajor) {
        _addMajor();
    }
}

- (void)setModel:(HUZVoluntPriority *)model {
    [self.ivLogo sd_setImageWithURL:[NSURL URLWithString:model.logoUrl] placeholderImage:ImageNamed(DEFAULT_IMAGE)];
    if (model.schoolName.length > 0) {
        self.labSchool.text = model.schoolName;
    }else{
        self.labSchool.text = model.yuanxiaomingcheng;
    }
    
    if (model.provinceName.length > 0) {
        self.labCity.text = model.provinceName;
    }else{
        self.labCity.text = model.uniCity;
    }
    
    self.labDes1.text = [NSString stringWithFormat:@"%@年录取最低分 %@",model.year, model.minScore];
    NSInteger vipState = [HUZUserCenterManager.userModel.vip integerValue];
    self.labDes2.text = @"录取概率(VIP可见)";
    [self.labDes2 addAttributestring:self.labDes2.text font:FontS(FONT_12) color:ColorS(COLOR_F19147) range:NSMakeRange(4, 7)];
    if (vipState > 0) {
        NSString *admissionOddsStr = [NSString stringWithFormat:@"%.1lf%%",[model.admissionOdds doubleValue]];
        self.labDes2.text = [NSString stringWithFormat:@"录取概率 %@",admissionOddsStr];
        [self.labDes2 addAttributestring:self.labDes2.text font:FontS(FONT_12) color:ColorS(COLOR_F19147) range:NSMakeRange(5, admissionOddsStr.length)];
    }

    self.labDes3.text = [NSString stringWithFormat:@"%@年录取最低排名 %@",model.year, model.minRanking];
    self.labDes4.text = [NSString stringWithFormat:@"%@年招生 %@人",model.year, model.planNum];
    
    self.btnAdd.selected = model.haveSchool;
    [self.btnAdd setBackgroundColor:self.btnAdd.selected ? ColorS(COLOR_F19147) : ColorS(COLOR_2E86FF)];

    [self.labDes1 addAttributestring:self.labDes1.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];

    [self.labDes3 addAttributestring:self.labDes3.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    [self.labDes4 addAttributestring:self.labDes4.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];

}
@end

//
//  HUZCurrentStudentsPlanCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/23.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZCurrentStudentsPlanCell.h"
#import "HUZStudentPlanModel.h"

@implementation HUZCurrentStudentsPlanCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZCurrentStudentsPlanCell";
    HUZCurrentStudentsPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (void)initView{
    
    self.isZero = YES;
    
    self.ivLogo = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_uni_logo")];
    
    self.labSchool = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    
    self.labCity = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    
    self.labDes = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    
    self.ivDiviceline= [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);

    [self.contentView addSubview:self.ivLogo];
    [self.contentView addSubview:self.labSchool];
    [self.contentView addSubview:self.labCity];
    [self.contentView addSubview:self.labDes];
    [self.contentView addSubview:self.ivDiviceline];
    
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
    
    [self.labDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labSchool.mas_bottom).offset(AutoDistance(6));
        make.left.mas_offset(AutoDistance(41));
    }];
    
    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(AutoDistance(8));
    }];
}

- (void)reloadData:(HUZStudentPlanDataListModel *)entity{
    [self.ivLogo sd_setImageWithURL:[NSURL URLWithString:entity.logoUrl] placeholderImage:ImageNamed(DEFAULT_IMAGE)];
    self.labSchool.text = entity.schoolName;
    self.labCity.text = entity.provinceName;
    self.labDes.text = [NSString stringWithFormat:@"%@年计划招生 %@人",entity.year,entity.admissionNum];
    [self.labDes addAttributestring:self.labDes.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
}

@end

//
//  HUZSearchSchoolCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/19.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZSearchSchoolCell.h"
#import "HUZKernalDroplineModel.h"
#import "HUZSearchUniModel.h"

@implementation HUZSearchSchoolCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZSearchSchoolCell";
    HUZSearchSchoolCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (void)initView{
    
    self.ivLogo = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_uni_logo")];
    
    self.labSchool = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    
    self.labCity = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    
    self.labDes1 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    
    self.labDes2 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];

    
    self.ivArrow = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_arrow_detail")];
    
    self.ivDiviceline = [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    [self.contentView addSubview:self.ivLogo];
    [self.contentView addSubview:self.labSchool];
    [self.contentView addSubview:self.labCity];
    [self.contentView addSubview:self.labDes1];
    [self.contentView addSubview:self.labDes2];
    [self.contentView addSubview:self.ivArrow];
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
    
    [self.labDes1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labSchool.mas_bottom).offset(AutoDistance(6));
        make.left.mas_offset(AutoDistance(41));
    }];
    
    [self.labDes2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labSchool.mas_bottom).offset(AutoDistance(6));
        make.left.equalTo(self.labDes1.mas_right).offset(AutoDistance(32));
    }];
    
    [self.ivArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(24));
        make.right.mas_offset(-AutoDistance(15));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(12), AutoDistance(12)));
    }];
    
    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(AutoDistance(2));
    }];
}

- (void)reloadData:(id)entity{
    /// 投档线
    if ([entity isKindOfClass:[HUZKernalDroplineDataListModel class]]) {
        HUZKernalDroplineDataListModel *model = (HUZKernalDroplineDataListModel *)entity;
        [self.ivLogo sd_setImageWithURL:[NSURL URLWithString:model.universityEntity.logoUrl] placeholderImage:ImageNamed(DEFAULT_IMAGE)];
        self.labSchool.text = model.yuanxiaomingcheng;
        self.labCity.text = model.universityEntity.provinceName;
        self.labDes1.text = [NSString stringWithFormat:@"2019年投档最低分 %@",model.deliveryScore];
        self.labDes2.text = [NSString stringWithFormat:@"投档最低位次 %@",model.minRanking];
        [self.labDes1 addAttributestring:self.labDes1.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
        [self.labDes2 addAttributestring:self.labDes2.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    }
    /// 录取线
    else if ([entity isKindOfClass:[HUZKernalEnterlineDataListModel class]]){
        HUZKernalEnterlineDataListModel *model = (HUZKernalEnterlineDataListModel *)entity;
        [self.ivLogo sd_setImageWithURL:[NSURL URLWithString:model.universityEntity.logoUrl] placeholderImage:ImageNamed(DEFAULT_IMAGE)];
        self.labSchool.text = model.universityEntity.schoolName;
        self.labCity.text = model.universityEntity.provinceName;
        self.labDes1.text = [NSString stringWithFormat:@"2019年录取最低分 %@",model.minScore];
        self.labDes2.text = [NSString stringWithFormat:@"录取最低位次 %@",model.minRanking];
        [self.labDes1 addAttributestring:self.labDes1.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
        [self.labDes2 addAttributestring:self.labDes2.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    }
   
    /// 搜索大学
    else if ([entity isKindOfClass:[HUZSearchUniDataListModel class]]){
        HUZSearchUniDataListModel *model = (HUZSearchUniDataListModel *)entity;
        [self.ivLogo sd_setImageWithURL:[NSURL URLWithString:model.logoUrl] placeholderImage:ImageNamed(DEFAULT_IMAGE)];
        self.labSchool.text = model.schoolName;
        self.labCity.text = model.provinceName;
        self.labDes1.text = [NSString stringWithFormat:@"2019年录取最低分 %@",model.deliveryDetailsEntity.deliveryScore];
        self.labDes2.text = [NSString stringWithFormat:@"录取最低位次 %@",model.deliveryDetailsEntity.minRanking];
        [self.labDes1 addAttributestring:self.labDes1.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
        [self.labDes2 addAttributestring:self.labDes2.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    }
    
}

@end

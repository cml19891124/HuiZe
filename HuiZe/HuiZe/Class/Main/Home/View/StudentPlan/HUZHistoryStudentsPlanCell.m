//
//  HUZHistoryStudentsPlanCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/23.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZHistoryStudentsPlanCell.h"
#import "HUZStudentPlanModel.h"
#import "HUZSearchUlikeUniModel.h"
#import "HUZRecommendUniListModel.h"

@implementation HUZHistoryStudentsPlanCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZHistoryStudentsPlanCell";
    HUZHistoryStudentsPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (void)initView{
    
    self.isZero = YES;

    self.ivLogo = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_uni_logo")];

    self.labSchool = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    self.labSchool.text = @"北京大学";

    self.labCity = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labCity.text = @"北京市";

    self.labDes1 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    self.labDes1.text = @"18年录取最低分 544";
    [self.labDes1 addAttributestring:self.labDes1.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    
    self.labDes2 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labDes2.hidden = YES;
    self.labDes2.text = @"录取概率(VIP可见)";
    [self.labDes2 addAttributestring:self.labDes2.text font:FontS(FONT_12) color:ColorS(COLOR_F19147) range:NSMakeRange(4, 7)];

    self.labDes3 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    self.labDes3.text = @"18年录取最低排名 121";
    [self.labDes3 addAttributestring:self.labDes3.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];

    self.labDes4 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    self.labDes4.text = @"18年招生 9人";
    [self.labDes4 addAttributestring:self.labDes4.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];

    self.ivDiviceline= [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);

    [self.contentView addSubview:self.ivLogo];
    [self.contentView addSubview:self.labSchool];
    [self.contentView addSubview:self.labCity];
    [self.contentView addSubview:self.labDes1];
    [self.contentView addSubview:self.labDes2];
    [self.contentView addSubview:self.labDes3];
    [self.contentView addSubview:self.labDes4];
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

    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(AutoDistance(8));
    }];
}

- (void)reloadData:(id)entity{
    /// 招生计划
    if ([entity isKindOfClass:[HUZStudentPlanDataListModel class]]) {
        HUZStudentPlanDataListModel *model = (HUZStudentPlanDataListModel *)entity;
        [self.ivLogo sd_setImageWithURL:[NSURL URLWithString:model.logoUrl] placeholderImage:ImageNamed(DEFAULT_IMAGE)];
        self.labSchool.text = model.schoolName;
        self.labCity.text = model.provinceName;
        self.labDes1.text = [NSString stringWithFormat:@"%@年录取最低分 %@",model.year,model.minScore];
        [self.labDes1 addAttributestring:self.labDes1.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
        
        BOOL isVip = [HUZUserCenterManager.userModel.vip isEqualToString:@"0"] ? NO : YES;
        if (isVip) {
            NSString *str = [NSString stringWithFormat:@"录取概率 %@",model.probability];
            self.labDes2.text = str;
            [self.labDes2 addAttributestring:self.labDes2.text font:FontS(FONT_12) color:ColorS(COLOR_F19147) space:@" "];
        }else{
            self.labDes2.text = @"录取概率(VIP可见)";
            [self.labDes2 addAttributestring:self.labDes2.text font:FontS(FONT_12) color:ColorS(COLOR_F19147) range:NSMakeRange(4, 7)];
        }
        
        self.labDes3.text = [NSString stringWithFormat:@"%@年录取最低排名 %@",model.year,model.minRanking];
        [self.labDes3 addAttributestring:self.labDes3.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
        
        self.labDes4.text = [NSString stringWithFormat:@"%@年招生 %@人",model.year,model.admissionNum];
        [self.labDes4 addAttributestring:self.labDes4.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    }

    /// 查大学---猜你喜欢 名企热招 全部高校 本省高校
    else if ([entity isKindOfClass:[HUZSearchUlikeUniDataListModel class]]){
        HUZSearchUlikeUniDataListModel *model = (HUZSearchUlikeUniDataListModel *)entity;
        [self.ivLogo sd_setImageWithURL:[NSURL URLWithString:model.universityEntity.logoUrl] placeholderImage:ImageNamed(DEFAULT_IMAGE)];
        self.labSchool.text = model.universityEntity.schoolName;
        self.labCity.text = model.universityEntity.uniCity;
        self.labDes1.text = [NSString stringWithFormat:@"%@年录取最低分 %@",model.year,model.minScore];
        [self.labDes1 addAttributestring:self.labDes1.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
        
        BOOL isVip = [HUZUserCenterManager.userModel.vip isEqualToString:@"0"] ? NO : YES;
        if (isVip) {
            NSString *str = [NSString stringWithFormat:@"录取概率 %@",model.probability];
            self.labDes2.text = str;
            [self.labDes2 addAttributestring:self.labDes2.text font:FontS(FONT_12) color:ColorS(COLOR_F19147) space:@" "];
        }else{
            self.labDes2.text = @"录取概率(VIP可见)";
            [self.labDes2 addAttributestring:self.labDes2.text font:FontS(FONT_12) color:ColorS(COLOR_F19147) range:NSMakeRange(4, 7)];
        }
        
        self.labDes3.text = [NSString stringWithFormat:@"%@年录取最低排名 %@",model.year,model.minRanking];
        [self.labDes3 addAttributestring:self.labDes3.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
        
        self.labDes4.text = [NSString stringWithFormat:@"%@年招生 %@人",model.year,model.admissionNum];
        [self.labDes4 addAttributestring:self.labDes4.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    }
    
    /// 推荐院校集合
    else if ([entity isKindOfClass:[HUZRecommendUniDataModel class]]){
        HUZRecommendUniDataModel *model = (HUZRecommendUniDataModel *)entity;
        [self.ivLogo sd_setImageWithURL:[NSURL URLWithString:model.logoUrl] placeholderImage:ImageNamed(DEFAULT_IMAGE)];
        self.labSchool.text = model.schoolName;
        self.labCity.text = model.provinceName;
        self.labDes1.text = [NSString stringWithFormat:@"%@年录取最低分 %@",model.year,model.minScore];
        [self.labDes1 addAttributestring:self.labDes1.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
        
        BOOL isVip = [HUZUserCenterManager.userModel.vip isEqualToString:@"0"] ? NO : YES;
        if (isVip) {
            NSString *str = [NSString stringWithFormat:@"录取概率 %@",model.admissionOdds];
            self.labDes2.text = str;
            [self.labDes2 addAttributestring:self.labDes2.text font:FontS(FONT_12) color:ColorS(COLOR_F19147) space:@" "];
        }else{
            self.labDes2.text = @"录取概率(VIP可见)";
            [self.labDes2 addAttributestring:self.labDes2.text font:FontS(FONT_12) color:ColorS(COLOR_F19147) range:NSMakeRange(4, 7)];
        }
        
        self.labDes3.text = [NSString stringWithFormat:@"%@年录取最低排名 %@",model.year,model.minRanking];
        [self.labDes3 addAttributestring:self.labDes3.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
        
        self.labDes4.text = [NSString stringWithFormat:@"%@年招生 %@人",model.year,model.admissionNum];
        [self.labDes4 addAttributestring:self.labDes4.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    }
}
@end

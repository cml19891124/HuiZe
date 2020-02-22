//
//  HUZUniEmploymentStatusCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/25.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniEmploymentStatusCell.h"
#import "HUZGeneralizeModel.h"

@implementation HUZUniEmploymentStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZUniEmploymentStatusCell";
    HUZUniEmploymentStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (void)initView{
    
    self.ivBg = [UIView new];
    self.ivBg.backgroundColor = ColorS(COLOR_BG_000000);
    self.ivBg.alpha = 0.06;
    ViewRadius(self.ivBg, AutoDistance(8));
    
    
    self.ivContent1 = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_trade")];
    self.labContent1 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_14)];
//    self.labContent1.text = @"媒体";
    self.labDes1 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labDes1.text = @"最多去向行业";
    
    self.ivContent2 = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_city")];
    self.labContent2 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_14)];
//    self.labContent2.text = @"深圳市";
    self.labDes2 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labDes2.text = @"最多去向城市";

    [self.contentView addSubview:self.ivBg];
    [self.contentView addSubview:self.ivContent1];
    [self.contentView addSubview:self.labContent1];
    [self.contentView addSubview:self.labDes1];
    [self.contentView addSubview:self.ivContent2];
    [self.contentView addSubview:self.labContent2];
    [self.contentView addSubview:self.labDes2];
    
    [self.ivBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(AutoDistance(345), AutoDistance(100)));
    }];
    
    [self.ivContent1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ivBg).offset(AutoDistance(24));
        make.left.equalTo(self.ivBg).offset(AutoDistance(28));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(44), AutoDistance(44)));
    }];
    
    [self.labContent1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ivBg).offset(AutoDistance(25));
        make.left.equalTo(self.ivContent1.mas_right).offset(AutoDistance(8));
    }];
    
    [self.labDes1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labContent1.mas_bottom).offset(AutoDistance(2));
        make.left.equalTo(self.ivContent1.mas_right).offset(AutoDistance(8));
    }];
    
    [self.ivContent2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ivBg).offset(AutoDistance(24));
        make.right.equalTo(self.ivBg).offset(-AutoDistance(106));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(44), AutoDistance(44)));
    }];
    
    [self.labContent2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ivBg).offset(AutoDistance(25));
        make.left.equalTo(self.ivContent2.mas_right).offset(AutoDistance(8));
    }];
    
    [self.labDes2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labContent2.mas_bottom).offset(AutoDistance(2));
        make.left.equalTo(self.ivContent2.mas_right).offset(AutoDistance(8));
    }];
}

- (void)reloadData:(HUZGeneralizeModel *)entity{
    self.labContent1.text = entity.data.industryEntity.industryName;
    self.labContent2.text = entity.data.regionEntity.areaName;
}

@end

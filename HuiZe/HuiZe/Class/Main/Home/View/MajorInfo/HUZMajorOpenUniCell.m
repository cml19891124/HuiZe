//
//  HUZMajorOpenUniCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/28.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZMajorOpenUniCell.h"
#import "HUZUniInfoModel.h"
@interface HUZMajorOpenUniCell ()

@property (nonatomic,strong) UIImageView *ivLogo;
@property (nonatomic,strong) UILabel *labSchool;
@property (nonatomic,strong) UILabel *labCity;
@property (nonatomic,strong) UIImageView *ivArrow;
@property (nonatomic,strong) UIImageView *ivDiviceline;

@end

@implementation HUZMajorOpenUniCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZMajorOpenUniCell";
    HUZMajorOpenUniCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}
-(void)setDataModel:(HUZUniInfoDataModel *)dataModel {
    _dataModel = dataModel;
    self.labSchool.text = dataModel.schoolName;
    self.labCity.text = dataModel.address;
    [self.ivLogo sd_setImageWithURL:[NSURL URLWithString:dataModel.logoUrl]];
}
- (void)initView{
    self.ivLogo = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_uni_logo")];
    
    self.labSchool = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    self.labSchool.text = @"北京大学";
    
    self.labCity = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labCity.text = @"北京市";
    
    self.ivArrow = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_arrow_detail")];
    
    self.ivDiviceline = [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);

    [self.contentView addSubview:self.ivLogo];
    [self.contentView addSubview:self.labSchool];
    [self.contentView addSubview:self.labCity];
    [self.contentView addSubview:self.ivArrow];
    [self.contentView addSubview:self.ivDiviceline];
    
    [self.ivLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(18));
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
    
    [self.ivArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-AutoDistance(15));
        make.centerY.equalTo(self.ivLogo);
    }];
    
    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(AutoDistance(2));
    }];
}

@end

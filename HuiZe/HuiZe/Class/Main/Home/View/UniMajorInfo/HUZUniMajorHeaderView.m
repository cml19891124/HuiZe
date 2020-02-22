//
//  HUZUniMajorHeaderView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/26.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniMajorHeaderView.h"

@implementation HUZUniMajorHeaderView

- (void)initView{
    
    self.backgroundColor = COLOR_BG_WHITE;
    
    self.ivLogo = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_uni_logo")];
    
    self.labSchool = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_20)];
    self.labSchool.text = @"北京大学";
    
    self.labCity = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labCity.text = @"北京市";
    
    self.labDes = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labDes.text = @"本科/综合/985/211/公立";
    
    self.ivDiviceline = [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    [self addSubview:self.ivLogo];
    [self addSubview:self.labSchool];
    [self addSubview:self.labCity];
    [self addSubview:self.labDes];
    [self addSubview:self.ivDiviceline];
    
    [self.ivLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(13));
        make.left.mas_offset(AutoDistance(15));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(48), AutoDistance(48)));
    }];
    
    [self.labSchool mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(13));
        make.left.equalTo(self.ivLogo.mas_right).offset(AutoDistance(12));
        
    }];

    [self.labCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(17));
    make.left.equalTo(self.labSchool.mas_right).offset(AutoDistance(18));
        make.right.mas_lessThanOrEqualTo(-12);
        make.width.mas_greaterThanOrEqualTo(45);
    }];

    [self.labDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labSchool.mas_bottom).offset(AutoDistance(5));
        make.left.equalTo(self.ivLogo.mas_right).offset(AutoDistance(12));
    }];
    
    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(AutoDistance(8));
    }];
}
-(void)setInfoModel:(HUZUniInfoGeneralizeDataModel *)infoModel {
    _infoModel = infoModel;
    [self.ivLogo sd_setImageWithURL:[NSURL URLWithString:infoModel.logoUrl]];
    self.labSchool.text = infoModel.schoolName;
    self.labCity.text = infoModel.uniCity;
    NSString *categoryStr = (infoModel.category ==  4) ? @"专科":@"本科";
    NSString *schoolPrivateName =  (infoModel.schoolPrivate ==  0) ? @"公办":@"民办";
    NSMutableString *des = [NSMutableString string];
    [des appendString:categoryStr];
    [des appendString:@"/"];
    [des appendString:infoModel.schoolTypeName];
    [des appendString:@"/"];
    if (infoModel.keyOne && ![infoModel.keyOne isEqualToString:@"null"]) {
        [des appendString:infoModel.keyOne];
        [des appendString:@"/"];
    }
    
    if (infoModel.keyTwo && ![infoModel.keyTwo isEqualToString:@"null"]) {
        [des appendString:infoModel.keyTwo];
        [des appendString:@"/"];
    }
    
    [des appendString:schoolPrivateName];
    self.labDes.text = des.copy;
}
@end

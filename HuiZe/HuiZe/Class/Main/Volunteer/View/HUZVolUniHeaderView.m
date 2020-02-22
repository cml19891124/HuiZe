//
//  HUZVolUniHeaderView.m
//  HuiZe
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZVolUniHeaderView.h"
#import "HUZSchoolListDataModel.h"
@interface HUZVolUniHeaderView ()

@property (nonatomic,strong) UIImageView *ivLogo;
@property (nonatomic,strong) UILabel *labSchool;
@property (nonatomic,strong) UILabel *labCity;
@property (nonatomic,strong) UILabel *labDes;
@property (nonatomic,strong) UIImageView *ivDiviceline;

@end

@implementation HUZVolUniHeaderView

-(void)setSchoolModel:(HUZSchoolModel *)schoolModel {
    _schoolModel = schoolModel;
    self.labSchool.text = schoolModel.schoolName;
    self.labCity.text = schoolModel.uniCity;
    [self.ivLogo sd_setImageWithURL:[NSURL URLWithString:schoolModel.logoUrl]];
}

- (void)initView{
    
    self.backgroundColor = COLOR_BG_WHITE;
    
    self.ivLogo = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_uni_logo")];
    
    self.labSchool = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_20)];
    //self.labSchool.text = @"北京大学";
    
    self.labCity = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    //self.labCity.text = @"北京市";
    
    self.labDes = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
//    self.labDes.text = @"本科/综合/985/211/公立";
    self.labDes.hidden = YES;
    
    self.ivDiviceline = [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    self.dBtn = [[UIButton alloc]initWithImageNormal:@"ic_btn_del" imageSeleted:@"ic_btn_del"];
    
    
    [self addSubview:self.ivLogo];
    [self addSubview:self.labSchool];
    [self addSubview:self.labCity];
    [self addSubview:self.labDes];
    [self addSubview:self.ivDiviceline];
    [self addSubview:self.dBtn];

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
    }];
    
    [self.labDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labSchool.mas_bottom).offset(AutoDistance(5));
        make.left.equalTo(self.ivLogo.mas_right).offset(AutoDistance(12));
    }];
    
    [self.dBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.labSchool);
        make.right.mas_offset(-AutoDistance(26));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(18), AutoDistance(18)));
    }];
    
    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(AutoDistance(8));
    }];
}

@end

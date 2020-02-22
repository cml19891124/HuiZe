//
//  HUZMajorInfoHeaderView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/28.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZMajorInfoHeaderView.h"
#import "HUZMajorInfoModel.h"
@interface HUZMajorInfoHeaderView ()
@property (nonatomic,strong) UIImageView *ivLogo;
@property (nonatomic,strong) UILabel *labSchool;
@property (nonatomic,strong) UILabel *labDes;
@property (nonatomic,strong) UIImageView *ivDiviceline;
@end

@implementation HUZMajorInfoHeaderView
-(void)setInfoModel:(HUZMajorInfoModel *)infoModel {
    _infoModel = infoModel;
    self.labSchool.text = infoModel.thisCategory;
    self.labDes.text = [NSString stringWithFormat:@"%@/%@",infoModel.onCategory,infoModel.twoCategory];//@"农学/自然保护与环境生态类";
}
- (void)initView{
    self.backgroundColor = COLOR_BG_WHITE;
    
    self.ivLogo = [[UIImageView alloc] initWithImage:ImageNamed(@"HUZMajor_def_icon")];
    
    self.labSchool = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_20)];
    self.labSchool.text = @"农业资源与环境";
    
    self.labDes = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labDes.text = @"农学/自然保护与环境生态类";
    
    self.ivDiviceline = [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    [self addSubview:self.ivLogo];
    [self addSubview:self.labSchool];
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
    
    [self.labDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labSchool.mas_bottom).offset(AutoDistance(5));
        make.left.equalTo(self.ivLogo.mas_right).offset(AutoDistance(12));
    }];
    
    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(AutoDistance(8));
    }];
}

@end

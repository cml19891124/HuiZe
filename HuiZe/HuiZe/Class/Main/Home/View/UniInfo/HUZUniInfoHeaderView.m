//
//  HUZUniInfoHeaderView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/24.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniInfoHeaderView.h"

@interface HUZUniInfoHeaderView ()

@property (nonatomic,strong) UIImageView *ivLogo;
@property (nonatomic,strong) UILabel *labSchool;
@property (nonatomic,strong) UILabel *labCity;
@property (nonatomic,strong) UILabel *labDes;
@property (nonatomic,strong) UIView *ivBg;
@property (nonatomic,strong) UILabel *labAdvise;
@property (nonatomic,strong) UIImageView *ivDiviceline;

@end

@implementation HUZUniInfoHeaderView

- (void)initView{
    
    self.backgroundColor = COLOR_BG_WHITE;
    
    self.ivLogo = [UIImageView new];
    
    self.labSchool = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_20)];
//    self.labSchool.text = @"北京大学";
    
    self.labCity = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
//    self.labCity.text = @"北京市";
    
    self.labDes = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
//    self.labDes.text = @"本科/综合/985/211/公立";
    
    self.ivBg = [UIView new];
    self.ivBg.backgroundColor = COLOR_BG_WHITE;
    self.ivBg.layer.shadowColor = [UIColor blackColor].CGColor;
    self.ivBg.layer.shadowOffset = CGSizeMake(2,3);// 设置阴影偏移量
    self.ivBg.layer.shadowOpacity = 0.2;// 设置阴影透明度
    self.ivBg.layer.shadowRadius = 4;// 设置阴影半径
    self.ivBg.layer.cornerRadius = AutoDistance(12);  //圆角
    self.ivBg.clipsToBounds = NO;
    
    self.labAdvise = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_10)];
//    self.labAdvise.text = @"填报意见: 可保底、所有专业录取风险低";
    self.labAdvise.hidden = YES;
    self.ivDiviceline = [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    [self addSubview:self.ivLogo];
    [self addSubview:self.labSchool];
    [self addSubview:self.labCity];
    [self addSubview:self.labDes];
    [self addSubview:self.ivBg];
    [self.ivBg addSubview:self.labAdvise];
    self.ivBg.hidden = YES;
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
    }];
    
    [self.labDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labSchool.mas_bottom).offset(AutoDistance(5));
        make.left.equalTo(self.ivLogo.mas_right).offset(AutoDistance(12));
    }];
    
    [self.ivBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ivLogo.mas_bottom).offset(AutoDistance(24));
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(HUZSCREEN_WIDTH-AutoDistance(AutoDistance(60)), AutoDistance(20)));
    }];
    
    [self.labAdvise mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.ivBg);
        make.left.mas_offset(AutoDistance(44));
    }];
    
    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(AutoDistance(8));
    }];
}

- (void)setModel:(HUZUniInfoModel *)model{
    _model = model;
    [self.ivLogo sd_setImageWithURL:[NSURL URLWithString:model.data.logoUrl] placeholderImage:ImageNamed(DEFAULT_IMAGE)];
    self.labSchool.text = model.data.schoolName;
    self.labCity.text = model.data.provinceName ? model.data.provinceName : model.data.uniCity;
    self.labAdvise.text = [NSString stringWithFormat:@"填报意见:%@",model.data.opinions];
    
    
    
    NSString *catygoryType = [model.data.category isEqualToString:@"0"] ? @"本科" : @"专科";
    NSString *schoolType = [NSString stringWithFormat:@"/%@",[self getSchoolType:model.data.schoolType]];
    NSString *keyOne = DRStringIsNotEmpty(model.data.keyOne) ? [NSString stringWithFormat:@"/%@",model.data.keyOne] : model.data.keyOne;
    NSString *keyTwo = DRStringIsNotEmpty(model.data.keyTwo) ? [NSString stringWithFormat:@"/%@",model.data.keyTwo] : model.data.keyTwo;
    NSString *schoolPrivate = [model.data.schoolPrivate isEqualToString:@"0"] ? @"/公办" : @"/民办";
    self.labDes.text = [NSString stringWithFormat:@"%@%@%@%@%@",catygoryType,schoolType,keyOne,keyTwo,schoolPrivate];
}

- (NSString *)getSchoolType:(NSString *)type{
    NSString *schoolType = @"";
    /// 学校类型：0综合，1工科，2师范，3农业，4医药，5军事，6林业，7语言，8财经，9体育，10艺术，11政法，12民族
    switch ([type intValue]) {
        case 0:
            schoolType = @"综合";
            break;
        case 1:
            schoolType = @"工科";
            break;
        case 2:
            schoolType = @"师范";
            break;
        case 3:
            schoolType = @"农业";
            break;
        case 4:
            schoolType = @"医药";
            break;
        case 5:
            schoolType = @"军事";
            break;
        case 6:
            schoolType = @"林业";
            break;
        case 7:
            schoolType = @"语言";
            break;
        case 8:
            schoolType = @"财经";
            break;
        case 9:
            schoolType = @"体育";
            break;
        case 10:
            schoolType = @"艺术";
            break;
        case 11:
            schoolType = @"政法";
            break;
        case 12:
            schoolType = @"民族";
            break;
        default:
            break;
    }
    return schoolType;
}

@end

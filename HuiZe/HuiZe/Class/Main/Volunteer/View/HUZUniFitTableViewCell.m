//
//  HUZUniFitTableViewCell.m
//  HuiZe
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZUniFitTableViewCell.h"
#import "HUZRecommendUniModel.h"
@implementation HUZUniFitTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZUniFitTableViewCell";
    HUZUniFitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
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
    
    self.labMajor = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
//    self.labMajor.hidden = YES;
    self.labMajor.text = @"16个专业推荐";
    
    self.labDes1 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    self.labDes1.text = @"18年录取最低分 544";
    [self.labDes1 addAttributestring:self.labDes1.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    
    self.labDes2 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labDes2.hidden = YES;
    self.labDes2.text = @"录取概率(VIP可见)";
    [self.labDes2 addAttributestring:self.labDes2.text font:FontS(FONT_12) color:ColorS(COLOR_F19147) range:NSMakeRange(4, 7)];
    
    self.labDes3 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labDes3.text = @"18年录取最低排名 121";
    [self.labDes3 addAttributestring:self.labDes3.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    
    self.labDes4 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labDes4.text = @"18年招生 9人";
    [self.labDes4 addAttributestring:self.labDes4.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    
    self.ivDiviceline= [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    [self.contentView addSubview:self.ivLogo];
    [self.contentView addSubview:self.labSchool];
    [self.contentView addSubview:self.labMajor];
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
    
    [self.labMajor mas_makeConstraints:^(MASConstraintMaker *make) {
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

-(void)setRecommendModel:(HUZRecommendUniDataModel *)recommendModel {
    _recommendModel = recommendModel;
    [self.ivLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",recommendModel.logoUrl]] placeholderImage:ImageNamed(@"ic_uni_logo")];
    self.labSchool.text = recommendModel.schoolName;
    self.labMajor.text = recommendModel.uniCity;
    
    self.labDes1.text = [NSString stringWithFormat:@"%@年录取最低分 %@",recommendModel.year,recommendModel.minScore];
    self.labDes1.textColor = ColorS(COLOR_989898);
    [self.labDes1 addAttributestring:self.labDes1.text font:FontS(FONT_12) color:ColorS(COLOR_414141) range:NSMakeRange(self.labDes1.text.length - recommendModel.minScore.length, recommendModel.minScore.length)];
    
    self.labDes3.text = [NSString stringWithFormat:@"%@年录取最低排名 %@",recommendModel.year,recommendModel.minRanking];
    [self.labDes3 addAttributestring:self.labDes3.text font:FontS(FONT_12) color:ColorS(COLOR_414141) range:NSMakeRange(self.labDes3.text.length - recommendModel.minRanking.length, recommendModel.minRanking.length)];

    self.labDes4.text = [NSString stringWithFormat:@"%@年招生 %@人",recommendModel.year,recommendModel.planNum];

    [self.labDes4 addAttributestring:self.labDes4.text font:FontS(FONT_12) color:ColorS(COLOR_414141) range:NSMakeRange(self.labDes4.text.length - recommendModel.planNum.length - 1, recommendModel.planNum.length)];
}

- (void)setModel:(HUZVolunteerFillModel *)model
{
    _model = model;
    
    [self.ivLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kUrl,model.logoUrl]] placeholderImage:ImageNamed(@"ic_uni_logo")];
    
    self.labSchool.text = model.schoolName;
    
    self.labMajor.text = [NSString stringWithFormat:@"%ld个专业推荐",model.subjectEntities.count];
    
    NSString *majorStr = [NSString stringWithFormat:@"%ld",model.subjectEntities.count];
    [self.labMajor addAttributestring:self.labMajor.text font:FontS(FONT_12) color:ColorS(COLOR_414141) range:NSMakeRange(0, majorStr.length)];
    
    self.labDes1.text = [NSString stringWithFormat:@"18年录取最低分 %@",model.minScore];
    
    self.labDes1.textColor = ColorS(COLOR_989898);
    
    [self.labDes1 addAttributestring:self.labDes1.text font:FontS(FONT_12) color:ColorS(COLOR_414141) range:NSMakeRange(self.labDes1.text.length - model.minScore.length, model.minScore.length)];


    if (HUZUserCenter.shareUserCenter.userModel.vip.intValue == 0) {
        self.labDes2.text =
        [NSString stringWithFormat:@"录取概率(VIP可见)"];
        
        [self.labDes2 addAttributestring:self.labDes2.text font:FontS(FONT_12) color:ColorS(COLOR_F19147) range:NSMakeRange(4,7)];

    }else{
        self.labDes2.text = [NSString stringWithFormat:@"录取概率%@",model.admissionOdds];
        
        [self.labDes2 addAttributestring:self.labDes2.text font:FontS(FONT_12) color:ColorS(COLOR_414141) range:NSMakeRange(self.labDes2.text.length - model.admissionOdds.length, model.admissionOdds.length)];

    }
    self.labDes3.text = [NSString stringWithFormat:@"18年录取最低排名 %@",model.minRanking];

    [self.labDes3 addAttributestring:self.labDes3.text font:FontS(FONT_12) color:ColorS(COLOR_414141) range:NSMakeRange(self.labDes3.text.length - model.minRanking.length, model.minRanking.length)];

    self.labDes4.text = [NSString stringWithFormat:@"18年招生 %@人",model.deliveryNum];

    [self.labDes4 addAttributestring:self.labDes4.text font:FontS(FONT_12) color:ColorS(COLOR_414141) range:NSMakeRange(self.labDes4.text.length - model.deliveryNum.length - 1, model.deliveryNum.length)];
}
@end

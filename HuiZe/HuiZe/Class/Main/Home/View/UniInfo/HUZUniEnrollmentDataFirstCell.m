//
//  HUZUniEnrollmentDataFirstCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/25.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniEnrollmentDataFirstCell.h"
#import "HUZUniEnrollmentDataModel.h"
@implementation HUZUniEnrollmentDataFirstCell
-(void)setDataModel:(HUZUniEnrollmentDataModel *)dataModel {
    _dataModel = dataModel;
    if (dataModel.recruitOne.count == 1) {
        self.labPlanDes1.text = dataModel.recruitOne.firstObject;
    }else if (dataModel.recruitOne.count > 1) {
        self.labPlanDes1.text = dataModel.recruitOne.firstObject;
        self.labPlanDes2.text = dataModel.recruitOne[1];
    }
    
    self.labStatusDes1.text = dataModel.wenke;
    self.labStatusDes2.text = dataModel.wenke;
    self.labPlan.text = [NSString stringWithFormat:@"%@年招生计划",dataModel.title];
    self.labStatus.text = [NSString stringWithFormat:@"%@年录取情况",dataModel.title];
    
}
+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZUniEnrollmentDataFirstCell";
    HUZUniEnrollmentDataFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
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
    
    self.ivPlan = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_enrollment_plan")];
    
    self.labPlan = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    
    
    self.labPlanDes1 = [TTTAttributedLabel new];
    [self.labPlanDes1 setTextColor:ColorS(COLOR_989898)];
    [self.labPlanDes1 setFont:FontS(FONT_10)];
    [self.labPlanDes1 setText:@"计划本科第一批招生10人" afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        //设置可点击文字的范围
        NSRange range = [[mutableAttributedString string] rangeOfString:@"10" options:NSCaseInsensitiveSearch];
        UIColor *color = ColorS(COLOR_2E86FF);
        if (color) {
            //设置可点击文本的颜色
            [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)color range:range];
        }
        return mutableAttributedString;
    }];
    
    self.labPlanDes2 = [TTTAttributedLabel new];
    [self.labPlanDes2 setTextColor:ColorS(COLOR_989898)];
    [self.labPlanDes2 setFont:FontS(FONT_10)];
    [self.labPlanDes2 setText:@"计划专科第一批招生10人" afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        //设置可点击文字的范围
        NSRange range = [[mutableAttributedString string] rangeOfString:@"10" options:NSCaseInsensitiveSearch];
        UIColor *color = ColorS(COLOR_2E86FF);
        if (color) {
            //设置可点击文本的颜色
            [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)color range:range];
        }
        return mutableAttributedString;
    }];
    
    self.ivStatus = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_enrollment_status")];
    
    self.labStatus = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    
    
    
    self.labStatusDes1 = [TTTAttributedLabel new];
    [self.labStatusDes1 setTextColor:ColorS(COLOR_989898)];
    [self.labStatusDes1 setFont:FontS(FONT_10)];
    [self.labStatusDes1 setText:@"文科(本科第一批最低分672分,专科第一批564分)" afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        //设置可点击文字的范围
        NSRange range1 = [[mutableAttributedString string] rangeOfString:@"672" options:NSCaseInsensitiveSearch];
        NSRange range2 = [[mutableAttributedString string] rangeOfString:@"564" options:NSCaseInsensitiveSearch];

        UIColor *color = ColorS(COLOR_2E86FF);
        if (color) {
            //设置可点击文本的颜色
            [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)color range:range1];
            [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)color range:range2];

        }
        return mutableAttributedString;
    }];
    
    self.labStatusDes2 = [TTTAttributedLabel new];
    [self.labStatusDes2 setTextColor:ColorS(COLOR_989898)];
    [self.labStatusDes2 setFont:FontS(FONT_10)];
    [self.labStatusDes2 setText:@"理科(本科第一批最低分672分,专科第一批564分)" afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        //设置可点击文字的范围
        NSRange range1 = [[mutableAttributedString string] rangeOfString:@"672" options:NSCaseInsensitiveSearch];
        NSRange range2 = [[mutableAttributedString string] rangeOfString:@"564" options:NSCaseInsensitiveSearch];

        UIColor *color = ColorS(COLOR_2E86FF);
        if (color) {
            //设置可点击文本的颜色
            [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)color range:range1];
            [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)color range:range2];
        }
        return mutableAttributedString;
    }];
    
    [self.contentView addSubview:self.ivBg];
    [self.contentView addSubview:self.ivPlan];
    [self.contentView addSubview:self.labPlan];
    [self.contentView addSubview:self.labPlanDes1];
    [self.contentView addSubview:self.labPlanDes2];
    
    [self.contentView addSubview:self.ivStatus];
    [self.contentView addSubview:self.labStatus];
    [self.contentView addSubview:self.labStatusDes1];
    [self.contentView addSubview:self.labStatusDes2];
    
    [self.ivBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(HUZSCREEN_WIDTH-AutoDistance(30), 206));
    }];
    
    [self.ivPlan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ivBg).offset(AutoDistance(24));
        make.left.equalTo(self.ivBg).offset(AutoDistance(28));
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    [self.labPlan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ivBg).offset(AutoDistance(26));
        make.left.equalTo(self.ivPlan.mas_right).offset(AutoDistance(8));
        make.right.mas_equalTo(-12);
    }];
    
    [self.labPlanDes1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labPlan.mas_bottom).offset(AutoDistance(6));
        make.left.equalTo(self.ivPlan.mas_right).offset(AutoDistance(8));
    }];

    [self.labPlanDes2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labPlanDes1.mas_bottom).offset(AutoDistance(6));
        make.left.equalTo(self.ivPlan.mas_right).offset(AutoDistance(8));
    }];

    [self.ivStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ivPlan.mas_bottom).offset(AutoDistance(37));
        make.left.equalTo(self.ivBg).offset(AutoDistance(28));
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];

    [self.labStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ivStatus);
        make.left.equalTo(self.ivStatus.mas_right).offset(AutoDistance(8));
        make.right.mas_equalTo(-12);
    }];

    self.labStatusDes1.numberOfLines = 0;
    self.labStatusDes2.numberOfLines = 0;
    [self.labStatusDes1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labStatus.mas_bottom).offset(AutoDistance(6));
        make.left.equalTo(self.ivStatus.mas_right).offset(AutoDistance(8));
        make.right.mas_equalTo(-18);
    }];
    
    [self.labStatusDes2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labStatusDes1.mas_bottom).offset(AutoDistance(6));
        make.left.equalTo(self.ivStatus.mas_right).offset(AutoDistance(8));
        make.right.mas_equalTo(-18);
        make.bottom.mas_lessThanOrEqualTo(-10);
    }];
}
@end

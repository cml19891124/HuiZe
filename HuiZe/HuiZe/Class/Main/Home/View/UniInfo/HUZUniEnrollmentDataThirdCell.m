//
//  HUZUniEnrollmentDataThirdCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/25.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniEnrollmentDataThirdCell.h"
#import "HUZUniInfoGeneralizeModel.h"

@implementation HUZUniEnrollmentDataThirdCell
-(void)setMajorModel:(HUZUniInfoGeneralizeMajorModel *)majorModel {
    _majorModel = majorModel;
    self.labMajor.text = majorModel.category;
    self.labDes1.text = [NSString stringWithFormat:@"%@录取最低分数%@",majorModel.year,majorModel.minScore];
    self.labDes2.text =  [NSString stringWithFormat:@"%@录取最低排名%@",majorModel.year,majorModel.minRanking];
    self.labDes3.text =  [NSString stringWithFormat:@"平均分%@",majorModel.average];
}
+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZUniEnrollmentDataThirdCell";
    HUZUniEnrollmentDataThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}


- (void)initView{
    
    self.labMajor = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    self.labMajor.numberOfLines = 0;
    self.labMajor.text = @"电子信息类";
    
    self.labDes1 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_10)];
    self.labDes1.text = @"18年录取最低分 544";
    [self.labDes1 addAttributestring:self.labDes1.text font:FontS(FONT_10) color:ColorS(COLOR_989898) space:@" "];
    
    self.labDes2 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_10)];
    self.labDes2.text = @"18年录取最低排名 121";
    [self.labDes2 addAttributestring:self.labDes2.text font:FontS(FONT_10) color:ColorS(COLOR_989898) space:@" "];

    self.labDes3 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_10)];
    self.labDes3.text = @"平均分 455";
    [self.labDes3 addAttributestring:self.labDes3.text font:FontS(FONT_10) color:ColorS(COLOR_989898) space:@" "];
    
    self.ivArrow = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_more_arrow")];
    
    self.ivDiviceline = [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);

    [self.contentView addSubview:self.labMajor];
    [self.contentView addSubview:self.labDes1];
    [self.contentView addSubview:self.labDes2];
    [self.contentView addSubview:self.labDes3];
    [self.contentView addSubview:self.ivArrow];
    [self.contentView addSubview:self.ivDiviceline];
    
    [self.labMajor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(18));
        make.left.mas_offset(AutoDistance(15));
        make.right.mas_offset(-AutoDistance(15));
    }];
    
    [self.labDes1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labMajor.mas_bottom).offset(AutoDistance(8));
        make.left.mas_offset(AutoDistance(15));
        make.bottom.mas_equalTo(-15);
    }];
    
    [self.labDes2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labMajor.mas_bottom).offset(AutoDistance(8));
        make.left.equalTo(self.labDes1.mas_right).offset(AutoDistance(36));
    }];
    
    [self.labDes3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labMajor.mas_bottom).offset(AutoDistance(8));
        make.left.equalTo(self.labDes2.mas_right).offset(AutoDistance(36));
    }];
    
    [self.ivArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labMajor);
        make.right.mas_offset(-AutoDistance(15));
        make.size.mas_equalTo(CGSizeMake(12, AutoDistance(12)));
    }];
    
    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(AutoDistance(2));
    }];
}
@end

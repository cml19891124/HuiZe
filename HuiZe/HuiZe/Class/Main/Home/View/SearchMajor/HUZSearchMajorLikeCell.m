//
//  HUZSearchMajorLikeCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/26.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZSearchMajorLikeCell.h"
#import "HUZUlikeMajorModel.h"

@implementation HUZSearchMajorLikeCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZSearchMajorLikeCell";
    HUZSearchMajorLikeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (void)initView{
    
    self.labMajor = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    self.labMajor.numberOfLines = 0;
    
    self.labDes1 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    
    self.labDes2 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    
    self.labDes3 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    
    self.ivDiviceline = [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    [self.contentView addSubview:self.labMajor];
    [self.contentView addSubview:self.labDes1];
    [self.contentView addSubview:self.labDes2];
    [self.contentView addSubview:self.labDes3];
    [self.contentView addSubview:self.ivDiviceline];
    
    [self.labMajor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(18));
        make.left.mas_offset(AutoDistance(15));
        make.right.mas_offset(AutoDistance(-15));
    }];
    
    [self.labDes1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labMajor.mas_bottom).offset(AutoDistance(6));
        make.left.mas_offset(AutoDistance(15));
    }];
    
    [self.labDes2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labDes1.mas_bottom).offset(AutoDistance(6));
        make.left.mas_offset(AutoDistance(15));
    }];
    
    [self.labDes3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labDes2);
        make.left.equalTo(self.labDes2.mas_right).offset(AutoDistance(21));
    }];
    
    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.labDes3.mas_bottom).mas_equalTo(10);
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(AutoDistance(8));
    }];
}

- (void)reloadData:(HUZUlikeMajorDataListModel *)entity{
    NSString *temStr = [NSString stringWithFormat:@"%@ %@",entity.zhuanyeNameTem,entity.schoolNameTem];
    NSRange range = [temStr rangeOfString:entity.schoolNameTem];
//    self.labMajor.att = [NSString stringWithFormat:@"%@ %@",entity.zhuanyeNameTem,entity.schoolNameTem];
    
    [self.labMajor addAttributestring:temStr font:[UIFont systemFontOfSize:10 weight:(UIFontWeightMedium)] color:ColorS(COLOR_989898) range:range];
    
//    - (void)addAttributestring:(NSString *)string font:(UIFont *)font color:(UIColor *)color range:(NSRange)range
//    [self.labMajor addAttributestring:self.labMajor.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    
    self.labDes1.text = [NSString stringWithFormat:@"%@年录取最低分 %@",entity.year,entity.minScore];
    [self.labDes1 addAttributestring:self.labDes1.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    self.labDes2.text = [NSString stringWithFormat:@"%@年录取最低排名 %@",entity.year,entity.minRanking];
    [self.labDes2 addAttributestring:self.labDes2.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    self.labDes3.text = [NSString stringWithFormat:@"2019年招生 %@人",entity.planNum];
    [self.labDes3 addAttributestring:self.labDes3.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];

}

@end

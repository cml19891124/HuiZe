//
//  HUZUniEnrollmentInfoMajorCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/25.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniEnrollmentInfoMajorCell.h"
#import "HUZUniEnrollmentInfoModel.h"
@implementation HUZUniEnrollmentInfoMajorCell
-(void)setInfoModel:(HUZUniEnrollmentInfoModel *)infoModel {
    _infoModel = infoModel;
    self.labMajor.text = self.infoModel.category;
    self.labDes.text = [NSString stringWithFormat:@"%@计划招生%@人",infoModel.year,infoModel.planNum];//@"18计划招生 4人";
}
+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZUniEnrollmentInfoMajorCell";
    HUZUniEnrollmentInfoMajorCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (void)initView{
    
    self.labMajor = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_14)];
    self.labMajor.text = @"电子信息类";
    
    self.labDes = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_14)];
    self.labDes.text = @"18计划招生 4人";
    [self.labDes addAttributestring:self.labDes.text font:FontS(FONT_14) color:ColorS(COLOR_989898) space:@" "];
    
    self.ivArrow = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_more_arrow")];
    
    self.ivDiviceline = [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    [self.contentView addSubview:self.labMajor];
    [self.contentView addSubview:self.labDes];
    [self.contentView addSubview:self.ivArrow];
    [self.contentView addSubview:self.ivDiviceline];
    
    [self.labMajor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(18));
        make.left.mas_offset(AutoDistance(15));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(210), AutoDistance(21)));
    }];
    
    [self.labDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labMajor.mas_bottom).offset(AutoDistance(8));
        make.left.mas_offset(AutoDistance(15));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(210), AutoDistance(14)));
    }];
    
    [self.ivArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.mas_offset(-AutoDistance(15));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(12), AutoDistance(12)));
    }];
    
    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(AutoDistance(2));
    }];
    
}

@end

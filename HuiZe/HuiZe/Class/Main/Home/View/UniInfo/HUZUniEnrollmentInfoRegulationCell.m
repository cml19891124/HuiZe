//
//  HUZUniEnrollmentInfoRegulationCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/25.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniEnrollmentInfoRegulationCell.h"
#import "HUZRecruitConstitutionListModel.h"
@implementation HUZUniEnrollmentInfoRegulationCell
-(void)setListMode:(HUZRecruitConstitutionListModel *)listMode {
    _listMode = listMode;
    NSString *subj = (listMode.type == 0) ? @"专科":@"本科";
    //self.labRegulation.text = [NSString stringWithFormat:@"%@%@年%@招生简章",listMode.schoolName,listMode.year,subj];//@"北京大学2018年本专科招生简章";
    self.labRegulation.text = listMode.title;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZUniEnrollmentInfoRegulationCell";
    HUZUniEnrollmentInfoRegulationCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (void)initView{
    
    self.labRegulation = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_14)];
    self.labRegulation.text = @"";
 
    self.ivArrow = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_more_arrow")];
    
    self.ivDiviceline = [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    [self.contentView addSubview:self.labRegulation];
    [self.contentView addSubview:self.ivArrow];
    [self.contentView addSubview:self.ivDiviceline];
    
    [self.labRegulation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.mas_offset(AutoDistance(15));
//        make.size.mas_equalTo(CGSizeMake(AutoDistance(280), AutoDistance(24)));
        make.right.mas_equalTo(-30);
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

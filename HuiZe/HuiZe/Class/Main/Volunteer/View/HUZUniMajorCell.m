//
//  HUZUniMajorCell.m
//  HuiZe
//
//  Created by mac on 2019/5/5.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZUniMajorCell.h"
#import "HUZIntelligenceDetailModel.h"
@implementation HUZUniMajorCell
-(void)setSchoolModel:(HUZDetailDataVolunteerSchoolEntityModel *)schoolModel {
    _schoolModel = schoolModel;
    [self.ivLogo sd_setImageWithURL:[NSURL URLWithString:schoolModel.logoUrl]];
    self.labSchool.text = schoolModel.schoolName;
    self.labCity.text = schoolModel.uniCity;
    self.labDes1.text = @"";
    self.labDes2.text = @"";
    self.labDes3.text = @"";
    self.labDes4.text = @"";
    self.labDes5.text = @"";
    self.labDes6.text = @"";
    [schoolModel.majorAllEntities enumerateObjectsUsingBlock:^(HUZDetailDataVolunteerMajorAllEntitiesModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *index = [NSString stringWithFormat:@"%zd. ",idx+1];
        switch (idx) {
            case 0:
                self.labDes1.text = [NSString stringWithFormat:@"%@%@",index,obj.category];
                break;
            case 1:
                self.labDes2.text = [NSString stringWithFormat:@"%@%@",index,obj.category];
                break;
            case 2:
                self.labDes3.text = [NSString stringWithFormat:@"%@%@",index,obj.category];
                break;
            case 3:
                self.labDes4.text = [NSString stringWithFormat:@"%@%@",index,obj.category];
                break;
            case 4:
                self.labDes5.text = [NSString stringWithFormat:@"%@%@",index,obj.category];
                break;
            case 5:
                self.labDes6.text = [NSString stringWithFormat:@"%@%@",index,obj.category];
                break;
            default:
                break;
        }
    }];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZUniMajorCell";
    HUZUniMajorCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (void)initView{
    
    self.contentView.backgroundColor = COLOR_BG_WHITE;
    
    self.iLab = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_17)];
    self.iLab.text = @"";
    
    self.ivLogo = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_uni_logo")];
    
    self.labSchool = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    self.labSchool.text = @"--";
    
    self.labCity = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labCity.text = @"--";
    
    self.labDes1 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labDes1.text = @"";
//    [self.labDes1 addAttributestring:self.labDes1.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    
    self.labDes2 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labDes2.text = @"";
//    [self.labDes2 addAttributestring:self.labDes2.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    
    self.labDes3 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labDes3.text = @"";
//    [self.labDes3 addAttributestring:self.labDes3.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    
    self.labDes4 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labDes4.text = @"";
//    [self.labDes4 addAttributestring:self.labDes4.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    
    self.labDes5 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labDes5.text = @"";
//    [self.labDes5 addAttributestring:self.labDes5.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    
    self.labDes6 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labDes6.text = @"";
//    [self.labDes6 addAttributestring:self.labDes6.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    
    
    [self.contentView addSubview:self.iLab];
    [self.contentView addSubview:self.ivLogo];
    [self.contentView addSubview:self.labSchool];
    [self.contentView addSubview:self.labCity];
    [self.contentView addSubview:self.labDes1];
    [self.contentView addSubview:self.labDes2];
    [self.contentView addSubview:self.labDes3];
    [self.contentView addSubview:self.labDes4];
    [self.contentView addSubview:self.labDes5];
    [self.contentView addSubview:self.labDes6];
    
    [self.iLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(17));
        make.left.mas_offset(AutoDistance(17));
    }];
    
    [self.ivLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(20));
        make.left.equalTo(self.iLab.mas_right).offset(AutoDistance(12));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(22), AutoDistance(22)));
    }];
    
    [self.labSchool mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.ivLogo);
        make.left.equalTo(self.ivLogo.mas_right).offset(AutoDistance(4));
    }];
    
    [self.labCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(24));
        make.left.equalTo(self.labSchool.mas_right).offset(AutoDistance(12));
    }];
    
    CGFloat w = (HUZSCREEN_WIDTH - (AutoDistance(56) + 15) - 80) / 3;
    
    [self.labDes1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labSchool.mas_bottom).offset(AutoDistance(18));
        make.left.mas_offset(AutoDistance(56));
        make.width.mas_equalTo(w);
    }];
    
    [self.labDes2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labDes1);
        make.left.equalTo(self.labDes1.mas_right).offset(AutoDistance(44));
        make.width.mas_equalTo(w);
    }];
    
    [self.labDes3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labDes1);
        make.left.equalTo(self.labDes2.mas_right).offset(AutoDistance(44));
//        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(w);
    }];
    
    [self.labDes4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labDes1.mas_bottom).offset(AutoDistance(8));
        make.leading.equalTo(self.labDes1);
        make.width.mas_equalTo(w);
    }];
    
    [self.labDes5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labDes4);
        make.left.equalTo(self.labDes4.mas_right).offset(AutoDistance(44));
        make.width.mas_equalTo(w);
    }];
    
    [self.labDes6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labDes5);
        make.left.equalTo(self.labDes5.mas_right).offset(AutoDistance(44));
//        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(w);
    }];
    
    UIView *topView = [UIView new];
    topView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    [self.contentView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(2);
    }];
}


@end

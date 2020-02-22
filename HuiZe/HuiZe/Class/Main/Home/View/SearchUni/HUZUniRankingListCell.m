//
//  HUZUniRankingListCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/24.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniRankingListCell.h"
#import "HUZUniRankingListModel.h"
@implementation HUZUniRankingListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZUniRankingListCell";
    HUZUniRankingListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (void)initView{
    
    self.labRanking = [[UILabel alloc] initWithTextColor:ColorS(COLOR_ffffff) autoTextFont:FontS(FONT_12) textAlignment:NSTextAlignmentCenter];
    ViewBorderRadius(self.labRanking, AutoDistance(4), AutoDistance(1), [UIColor clearColor]);
    
    self.ivLogo = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_uni_logo")];
    
    self.labSchool = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    self.labSchool.text = @"北京大学";
    
    self.labCity = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labCity.text = @"北京市";
    
    self.labDes1 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    self.labDes1.text = @"综合/985/211";
    
    self.labDes2 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_F19147) autoTextFont:FontS(FONT_12) textAlignment:NSTextAlignmentRight];
    self.labDes2.text = @"A +++";
    self.labDes2.hidden = YES;
    self.ivDiviceline = [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);

    [self.contentView addSubview:self.labRanking];
    [self.contentView addSubview:self.ivLogo];
    [self.contentView addSubview:self.labSchool];
    [self.contentView addSubview:self.labCity];
    [self.contentView addSubview:self.labDes1];
    [self.contentView addSubview:self.labDes2];
    [self.contentView addSubview:self.ivDiviceline];
    
    [self.labRanking mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(18));
        make.left.mas_offset(AutoDistance(15));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(24), AutoDistance(24)));
    }];
    
    [self.ivLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(18));
        make.left.equalTo(self.labRanking.mas_right).offset(AutoDistance(8));
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
    
    [self.labDes1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labSchool.mas_bottom).offset(AutoDistance(6));
        make.left.equalTo(self.labSchool);
    }];
    
    [self.labDes2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.mas_offset(-AutoDistance(30));
    }];
    
    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(AutoDistance(2));
    }];
}

- (void)reloadData:(id)entity indexPath:(NSIndexPath *)indexPath{
    HUZUniRankingListModel *listModel = (HUZUniRankingListModel *)entity;
    switch (self.type) {
        case 0:
            self.labRanking.text = listModel.usRanking;
            break;
        case 1:
            self.labRanking.text = listModel.qsRanking;
            break;
        case 2:
            self.labRanking.text = listModel.chinaRanking;
            break;
        case 3:
            self.labRanking.text = listModel.wslRanking;
            break;
        case 4:
            self.labRanking.text = listModel.reasonRanking;
            break;
        case 5:
            self.labRanking.text = listModel.cultureRanking;
            break;
        default:
            break;
    }
    self.labRanking.text = [NSString stringWithFormat:@"%zd",indexPath.row+1];
    if (indexPath.row < 3) {
        self.labRanking.backgroundColor = ColorS(COLOR_BG_2E86FF);
        self.labRanking.textColor = ColorS(COLOR_ffffff);
        ViewBorderRadius(self.labRanking, AutoDistance(4), AutoDistance(1), [UIColor clearColor]);
    }else{
        self.labRanking.backgroundColor = COLOR_BG_WHITE;
        self.labRanking.textColor = ColorS(COLOR_2E86FF);
        ViewBorderRadius(self.labRanking, AutoDistance(4), AutoDistance(1), ColorS(COLOR_BG_2E86FF));
    }
    
    
    self.labSchool.text = listModel.universityEntity.schoolName;
    self.labCity.text = listModel.universityEntity.uniCity;
    
    NSMutableString *des = [NSMutableString string];
    [des appendString:listModel.universityEntity.schoolTypeName];
    
    if (listModel.universityEntity.keyOne.length != 0 && ![listModel.universityEntity.keyOne isEqualToString:@"null"]) {
        [des appendString:@"/"];
        [des appendString:listModel.universityEntity.keyOne];
    }

    if (listModel.universityEntity.keyTwo.length != 0 && ![listModel.universityEntity.keyTwo isEqualToString:@"null"]) {
        [des appendString:@"/"];
        [des appendString:listModel.universityEntity.keyTwo];
    }

    self.labDes1.text = des.copy;
    
    
    
}


@end

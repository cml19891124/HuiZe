//
//  HUZGkSubjectCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/28.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZGkSubjectCell.h"
#import "HUZNewGkSubjectModel.h"
@interface HUZGkSubjectCell ()
@property (nonatomic,strong) UIImageView *ivContent;
@property (nonatomic,strong) UILabel *labCity;
@property (nonatomic,strong) UILabel *labDes;
@property (nonatomic,strong) UIImageView *ivArrow;
@property (nonatomic,strong) UIImageView *ivDiviceline;

@end

@implementation HUZGkSubjectCell
-(void)setSubjectModel:(HUZNewGkSubjectModel *)subjectModel {
    _subjectModel = subjectModel;
    self.labCity.text = subjectModel.provinceName;
    NSMutableString *des = [NSMutableString string];
    [des appendString:subjectModel.startTime];
    [des appendString:@"年启动、"];
    [des appendString:subjectModel.endTime];
    [des appendString:@"年实施"];
}
+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZGkSubjectCell";
    HUZGkSubjectCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (void)initView{
    
    self.ivContent = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_city")];
    
    self.labCity = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_17)];
    self.labCity.text = @"上海市";
    
    self.labDes = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    self.labDes.text = @"2014年启动、2017年实施";
    
    self.ivArrow = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_more_arrow")];

    
    self.ivDiviceline = [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    [self.contentView addSubview:self.ivContent];
    [self.contentView addSubview:self.labCity];
    [self.contentView addSubview:self.labDes];
    [self.contentView addSubview:self.ivArrow];
    [self.contentView addSubview:self.ivDiviceline];
    
    [self.ivContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(19));
        make.left.mas_offset(AutoDistance(15));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(22), AutoDistance(22)));
    }];
    
    [self.labCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ivContent.mas_right).offset(AutoDistance(8));
        make.centerY.equalTo(self.ivContent);
        make.size.mas_equalTo(CGSizeMake(AutoDistance(200), AutoDistance(24)));
    }];
    
    [self.labDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(AutoDistance(15));
        make.top.equalTo(self.labCity.mas_bottom).offset(AutoDistance(7));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(240), AutoDistance(17)));
    }];
    
    [self.ivArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.ivContent);
        make.right.mas_offset(-AutoDistance(15));
    }];
    
    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(AutoDistance(2));
    }];
}
@end

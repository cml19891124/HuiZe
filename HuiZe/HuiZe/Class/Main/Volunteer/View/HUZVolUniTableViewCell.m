//
//  HUZVolUniTableViewCell.m
//  HuiZe
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZVolUniTableViewCell.h"
#import "HUZUniInfoGeneralizeModel.h"
@interface HUZVolUniTableViewCell ()
@property (nonatomic,strong) UILabel *labMajor;
@property (nonatomic,strong) UILabel *labDes1;
@property (nonatomic,strong) UILabel *labDes2;
@property (nonatomic,strong) UILabel *labDes3;
@property (nonatomic,strong) UIImageView *ivDiviceline;

@end

@implementation HUZVolUniTableViewCell
-(void)setMajorModel:(HUZUniInfoGeneralizeMajorModel *)majorModel {
    _majorModel = majorModel;
    self.labMajor.text = majorModel.majIntroduce;
    self.labDes1.text = [NSString stringWithFormat:@"18年录取最低分 %@",majorModel.minScore];
    self.labDes2.text = [NSString stringWithFormat:@"18年录取最低排名  %@",majorModel.minRanking];
    self.labDes3.text = [NSString stringWithFormat:@"19年招生 %@人",majorModel.planNum];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZVolUniTableViewCell";
    HUZVolUniTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (void)initView{
    self.labMajor = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    self.labMajor.numberOfLines = 0;
    //self.labMajor.text = @"电子信息类";
    
    self.labDes1 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    //self.labDes1.text = @"18年录取最低分 544";

    
    self.labDes2 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    //self.labDes2.text = @"18年录取最低排名 121";
    //[self.labDes2 addAttributestring:self.labDes2.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    
    self.labDes3 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
//    self.labDes3.text = @"18年招生 9人";
    //[self.labDes3 addAttributestring:self.labDes3.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    
    self.dBtn = [[UIButton alloc]initWithImageNormal:@"ic_btn_del" imageSeleted:@"ic_btn_del"];
    
    
    self.ivDiviceline = [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    
    [self.contentView addSubview:self.labMajor];
    [self.contentView addSubview:self.labDes1];
    [self.contentView addSubview:self.labDes2];
    [self.contentView addSubview:self.labDes3];
    [self.contentView addSubview:self.ivDiviceline];
    [self.contentView addSubview:self.dBtn];
    
    [self.labMajor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(18));
        make.left.mas_offset(AutoDistance(55));
        make.right.mas_equalTo(-50);
    }];
    
    [self.labDes1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labMajor.mas_bottom).offset(AutoDistance(6));
        make.leading.equalTo(self.labMajor);
    }];
    
    [self.labDes2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labDes1.mas_bottom).offset(AutoDistance(6));
        make.leading.equalTo(self.labMajor);
        make.bottom.mas_equalTo(-20);
    }];
    
    [self.labDes3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labDes2);
        make.left.equalTo(self.labDes2.mas_right).offset(AutoDistance(21));
    }];
    
    [self.dBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.labMajor);
        make.right.mas_offset(-AutoDistance(26));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(15), AutoDistance(13)));
    }];
    
    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(AutoDistance(8));
    }];

}



@end

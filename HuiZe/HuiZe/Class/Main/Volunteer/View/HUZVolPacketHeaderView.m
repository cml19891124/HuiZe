//
//  HUZVolPacketHeaderView.m
//  HuiZe
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZVolPacketHeaderView.h"
#import "HUZPacketVolModel.h"

@implementation HUZVolPacketHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initView];
    }
    return self;
}

- (void)initView{
    
    self.contentView.backgroundColor = COLOR_BG_WHITE;
    
    self.ivBtn = [[UIButton alloc]initWithImageNormal:@"ic_uni_select_normal" imageSeleted:@"ic_uni_select_checked"];
    self.ivBtn.userInteractionEnabled = NO;
    [self.ivBtn addTarget:self action:@selector(tapClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.ivLogo = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_uni_logo")];
    
    self.deleteBtn = [UIButton buttonWithType:0];
    [self.deleteBtn setImage:[UIImage imageNamed:@"ic_btn_del"] forState:(UIControlStateNormal)];
    [self.deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.labSchool = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    self.labSchool.text = @"北京大学";
    
    self.labCity = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labCity.text = @"北京市";
    
    self.labDes1 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    self.labDes1.text = @"18年录取最低分 544";
    [self.labDes1 addAttributestring:self.labDes1.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    
    self.labDes2 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labDes2.text = @"录取概率(VIP可见)";
    [self.labDes2 addAttributestring:self.labDes2.text font:FontS(FONT_12) color:ColorS(COLOR_F19147) range:NSMakeRange(4, 7)];
    
    self.labDes3 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labDes3.text = @"18年录取最低排名 121";
    [self.labDes3 addAttributestring:self.labDes3.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    
    self.labDes4 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labDes4.text = @"18年招生 9人";
    [self.labDes4 addAttributestring:self.labDes4.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    
    
    [self.contentView addSubview:self.ivBtn];
    [self.contentView addSubview:self.deleteBtn];
    [self.contentView addSubview:self.ivLogo];
    [self.contentView addSubview:self.labSchool];
    [self.contentView addSubview:self.labCity];
    [self.contentView addSubview:self.labDes1];
    [self.contentView addSubview:self.labDes2];
    [self.contentView addSubview:self.labDes3];
    [self.contentView addSubview:self.labDes4];
    
    [self.ivBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(41));
        make.left.mas_offset(AutoDistance(17));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(20), AutoDistance(20)));
    }];
    
    [self.ivLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(20));
        make.left.equalTo(self.ivBtn.mas_right).offset(AutoDistance(8));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(22), AutoDistance(22)));
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.ivLogo.mas_centerY).mas_equalTo(0);
        make.right.mas_equalTo(-25);
        make.size.mas_equalTo(CGSizeMake(18, 16));
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
        make.leading.equalTo(self.labSchool);
    }];
    
    [self.labDes2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labDes1);
        make.left.equalTo(self.labDes1.mas_right).offset(AutoDistance(32));
    }];
    
    [self.labDes3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labDes2.mas_bottom).offset(AutoDistance(4));
        make.leading.equalTo(self.labSchool);
    }];
    
    [self.labDes4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labDes3);
        make.left.equalTo(self.labDes3.mas_right).offset(AutoDistance(32));
    }];
   
}

- (void)tapClick:(UIButton*)sender {
    sender.selected = !sender.selected;
    if (_selectBlock) {
        _selectBlock(sender.selected);
    }
}
-(void)deleteAction:(UIButton *)sender {
    if ([self.deletage respondsToSelector:@selector(deleteActionSection:)]) {
        [self.deletage deleteActionSection:self.section];
    }
}
- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    self.ivBtn.selected = isSelected;
}

- (void)setModel:(HUZPacketVolListModel *)model {
    _model = model;
    [self.ivLogo sd_setImageWithURL:[NSURL URLWithString:model.logoUrl] placeholderImage:ImageNamed(@"ic_uni_logo")];
    self.labSchool.text = model.schoolName;
    self.labCity.text = model.provinceName;
    self.labDes1.text = [NSString stringWithFormat:@"%@年录取最低分 %@",model.year, model.minScore];
    self.labDes2.text = [NSString stringWithFormat:@"录取概率%%%@",model.admissionOdds];//model.admissionOdds ? model.admissionOdds : @"暂无";//@"录取概率(VIP可见)";
    self.labDes3.text = [NSString stringWithFormat:@"%@年录取最低排名 %@",model.year, model.minRanking];
    self.labDes4.text = [NSString stringWithFormat:@"%@年招生 %@人",model.year, model.admissionNum];
    
    [self.labDes1 addAttributestring:self.labDes1.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
//    [self.labDes2 addAttributestring:self.labDes2.text font:FontS(FONT_12) color:ColorS(COLOR_F19147) range:NSMakeRange(4, 7)];
    [self.labDes3 addAttributestring:self.labDes3.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    [self.labDes4 addAttributestring:self.labDes4.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
}
@end

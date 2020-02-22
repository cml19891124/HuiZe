//
//  HUZVolPacketCell.m
//  HuiZe
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZVolPacketCell.h"
#import "HUZPacketVolModel.h"

@implementation HUZVolPacketCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZVolPacketCell";
    HUZVolPacketCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (void)initView{
    
    self.ivBtn = [[UIButton alloc]initWithImageNormal:@"ic_uni_select_normal" imageSeleted:@"ic_uni_select_checked"];//ic_uni_logo
    self.ivBtn.userInteractionEnabled = NO;
    [self.ivBtn addTarget:self action:@selector(tapClick:) forControlEvents:UIControlEventTouchUpInside];

    self.labMajor = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    self.labMajor.text = @"电子信息类";
    self.deleteBtn = [UIButton buttonWithType:0];
    [self.deleteBtn setImage:[UIImage imageNamed:@"ic_btn_del"] forState:(UIControlStateNormal)];
    [self.deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.labDes1 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    self.labDes1.text = @"18年录取最低分 544";
    [self.labDes1 addAttributestring:self.labDes1.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    
    self.labDes2 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    self.labDes2.text = @"18年录取最低排名 121";
    [self.labDes2 addAttributestring:self.labDes2.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    
    self.labDes3 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    self.labDes3.text = @"18年招生 9人";
    [self.labDes3 addAttributestring:self.labDes3.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    
    [self.contentView addSubview:self.ivBtn];
    [self.contentView addSubview:self.labMajor];
    [self.contentView addSubview:self.deleteBtn];
    [self.contentView addSubview:self.labDes1];
    [self.contentView addSubview:self.labDes2];
    [self.contentView addSubview:self.labDes3];


    [self.ivBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(37));
        make.left.mas_offset(AutoDistance(55));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(30), AutoDistance(30)));
    }];
    
    [self.labMajor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(14));
        make.left.equalTo(self.ivBtn.mas_right).offset(AutoDistance(8));
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.labMajor.mas_centerY).mas_equalTo(0);
        make.right.mas_equalTo(-25);
        make.size.mas_equalTo(CGSizeMake(18, 16));
    }];
    
    [self.labDes1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labMajor.mas_bottom).offset(AutoDistance(6));
        make.leading.equalTo(self.labMajor);
    }];
    
    [self.labDes2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labDes1.mas_bottom).offset(AutoDistance(6));
        make.leading.equalTo(self.labMajor);
    }];
    
    [self.labDes3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labDes2);
        make.left.equalTo(self.labDes2.mas_right).offset(AutoDistance(21));
    }];
    
}

- (void)setModel:(HUZSubjectVoListModel *)model {
    _model = model;
    self.labMajor.text = model.category;
    self.labDes1.text = [NSString stringWithFormat:@"%@年录取最低分 %@",model.year, model.minScore];
    self.labDes2.text = [NSString stringWithFormat:@"%@年录取最低排名 %@",model.year, model.minRanking];
    self.labDes3.text = [NSString stringWithFormat:@"%@年招生 %@人",model.year, model.admissionNum];
    [self.labDes1 addAttributestring:self.labDes1.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    [self.labDes2 addAttributestring:self.labDes2.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    [self.labDes3 addAttributestring:self.labDes3.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    self.ivBtn.selected = model.isSelected;
}
-(void)deleteAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(deleteMajorIndexPath:)]) {
        [self.delegate deleteMajorIndexPath:self.indexPath];
    }
}
- (void)tapClick:(UIButton*)sender {
    sender.selected = !sender.selected;
    if (_selectBlock) {
        _selectBlock(sender.selected);
    }
}

@end

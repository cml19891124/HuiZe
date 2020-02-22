//
//  HUZVolMajorSelectCell.m
//  HuiZe
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZVolMajorSelectCell.h"
#import "HUZVoluntaryModel.h"

@implementation HUZVolMajorSelectCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZVolMajorSelectCell";
    HUZVolMajorSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (void)initView{
    
    self.labMajor = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    self.labMajor.numberOfLines = 0;
    self.labMajor.text = @"电子信息类";
    
    self.labDes1 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    
    self.labDes2 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    
    self.labDes3 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    
    self.btnAdd = [[UIButton alloc]initWithTitle:@"备选专业" textColor:COLOR_BG_WHITE autoTextFont:FontS(FONT_12)];
    [self.btnAdd setImage:ImageNamed(@"ic_btn_uni_add") forState:UIControlStateNormal];
    [self.btnAdd setImage:ImageNamed(@"ic_btn_gg_small") forState:UIControlStateSelected];
    [self.btnAdd setTitle:@"已加备选" forState:UIControlStateSelected];
    [self.btnAdd addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
    ViewRadius(self.btnAdd, 4);
    
    self.ivDiviceline = [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    [self.contentView addSubview:self.labMajor];
    [self.contentView addSubview:self.labDes1];
    [self.contentView addSubview:self.labDes2];
    [self.contentView addSubview:self.labDes3];
    [self.contentView addSubview:self.ivDiviceline];
    [self.contentView addSubview:self.btnAdd];

    [self.labMajor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(18));
        make.left.mas_offset(AutoDistance(15));
        make.right.mas_equalTo(-115);
    }];
    
    [self.labDes1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labMajor.mas_bottom).offset(AutoDistance(6));
        make.left.mas_offset(AutoDistance(15));
    }];
    
    [self.labDes2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labDes1.mas_bottom).offset(AutoDistance(6));
        make.left.mas_offset(AutoDistance(15));
        make.bottom.mas_equalTo(-17);
    }];
    
    [self.labDes3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labDes2);
        make.left.equalTo(self.labDes2.mas_right).offset(AutoDistance(21));
    }];
    
    [self.btnAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(18));
        make.right.mas_offset(-AutoDistance(15));
        make.size.sizeOffset(CGSizeMake(AutoDistance(90), AutoDistance(40)));
    }];
    
    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(AutoDistance(8));
    }];
}

- (void)addClick:(UIButton*)sender {
    sender.selected = !sender.selected;
    [sender setBackgroundColor:sender.selected ? ColorS(COLOR_F19147) : ColorS(COLOR_2E86FF)];
    if (_addMajor) {
        _addMajor(sender.selected);
    }
}

- (void)setModel:(HUZVoluntaryListModel *)model {
    _model = model;
    if (model.year.length == 0) {
        model.year = @"2018";
    }
    
    self.labMajor.text = model.majIntroduce;
    self.labDes1.text = [NSString stringWithFormat:@"%@年录取最低分 %@",model.year, model.minScore];
    self.labDes2.text = [NSString stringWithFormat:@"%@年录取最低排名 %@",model.year, model.minRanking];
    self.labDes3.text = [NSString stringWithFormat:@"2019年招生 %@人",model.planNum];
    self.btnAdd.selected = model.alternative;
    [self.btnAdd setBackgroundColor:self.btnAdd.selected ? ColorS(COLOR_F19147) : ColorS(COLOR_2E86FF)];
    
    [self.labDes1 addAttributestring:self.labDes1.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    [self.labDes2 addAttributestring:self.labDes2.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    [self.labDes3 addAttributestring:self.labDes3.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    self.btnAdd.selected = model.alternative;
    [self.btnAdd setBackgroundColor:self.btnAdd.selected ? ColorS(COLOR_F19147) : ColorS(COLOR_2E86FF)];
}
@end

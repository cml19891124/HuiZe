//
//  HUZUniFillCell.m
//  HuiZe
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZUniFillCell.h"

@implementation HUZUniFillCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZUniFillCell";
    HUZUniFillCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (void)initView{
    
    self.contentView.backgroundColor = COLOR_BG_WHITE;
    
    self.iLab = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_17)];
    self.iLab.text = @"A.";
    
    self.ivLogo = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_uni_logo")];
    
    self.labSchool = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    self.labSchool.text = @"北京大学";
    
    self.labCity = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labCity.text = @"北京市";
    
    self.labDes1 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labDes1.text = @"1. 电子信息类";
    [self.labDes1 addAttributestring:self.labDes1.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    
    self.labDes2 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labDes2.text = @"2. 电子信息类";
    [self.labDes2 addAttributestring:self.labDes2.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    
    self.labDes3 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labDes3.text = @"3. 电子信息类";
    [self.labDes3 addAttributestring:self.labDes3.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    
    self.labDes4 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labDes4.text = @"4. 电子信息类";
    [self.labDes4 addAttributestring:self.labDes4.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    
    self.labDes5 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labDes5.text = @"5. 电子信息类";
    [self.labDes5 addAttributestring:self.labDes5.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    
    self.labDes6 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labDes6.text = @"6. 电子信息类";
    [self.labDes6 addAttributestring:self.labDes6.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
    
    self.dBtn = [[UIButton alloc]initWithImageNormal:@"ic_btn_del" imageSeleted:@"ic_btn_del"];
    
    self.btnContinue = [[UIButton alloc] initWithTitle:@"继续添加专业" textColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    [self.btnContinue addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];

    self.btnAdd = [[UIButton alloc]initWithImageNormal:@"ic_btn_add_circle" imageSeleted:@"ic_btn_add_circle"];
    [self.btnAdd addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.dBtn addTarget:self action:@selector(deleteSchoolClick:) forControlEvents:UIControlEventTouchUpInside];
    self.majorView = [UIView new];
    self.majorView.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.iLab];
    [self.contentView addSubview:self.ivLogo];
    [self.contentView addSubview:self.labSchool];
    [self.contentView addSubview:self.labCity];
    [self.contentView addSubview:self.labCity];

    [self.contentView addSubview:self.majorView];

    [self.contentView addSubview:self.labDes1];
    [self.contentView addSubview:self.labDes2];
    [self.contentView addSubview:self.labDes3];
    [self.contentView addSubview:self.labDes4];
    [self.contentView addSubview:self.labDes5];
    [self.contentView addSubview:self.labDes6];
    [self.contentView addSubview:self.dBtn];
    [self.contentView addSubview:self.btnContinue];
    [self.contentView addSubview:self.btnAdd];
    
    [self.iLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(20));
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
    
    [self.majorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labSchool.mas_bottom).offset(AutoDistance(10));
        make.left.mas_offset(AutoDistance(56));
        make.right.mas_offset(AutoDistance(-16));
        make.height.mas_offset(AutoDistance(60));

    }];

    /*
    [self.labDes1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labSchool.mas_bottom).offset(AutoDistance(18));
        make.left.mas_offset(AutoDistance(56));
    }];
    
    [self.labDes2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labDes1);
        make.left.equalTo(self.labDes1.mas_right).offset(AutoDistance(44));
    }];
    
    [self.labDes3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labDes1);
        make.left.equalTo(self.labDes2.mas_right).offset(AutoDistance(44));
    }];
    
    [self.labDes4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labDes1.mas_bottom).offset(AutoDistance(8));
        make.leading.equalTo(self.labDes1);
    }];
    
    [self.labDes5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labDes4);
        make.left.equalTo(self.labDes4.mas_right).offset(AutoDistance(44));
    }];
    
    [self.labDes6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labDes5);
        make.left.equalTo(self.labDes5.mas_right).offset(AutoDistance(44));
    }];*/
    
    [self.dBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.ivLogo);
        make.right.mas_offset(-AutoDistance(15));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(18), AutoDistance(18)));
    }];
    
    [self.btnContinue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-AutoDistance(12));
        make.left.mas_equalTo(AutoDistance(15));
        make.width.mas_equalTo(AutoDistance(200));
    }];
    [self.btnAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.btnContinue);
        make.right.mas_equalTo(-AutoDistance(12));
    }];
}

- (void)addClick:(UIButton*)btn {
    if (_addBlock) {
        _addBlock(self.indexPath);
    }
}

- (void)deleteSchoolClick:(UIButton *)button
{
    if (_deleteBlock) {
        _deleteBlock();
    }
}

- (void)setModel:(HUZSchoolModel *)model
{
    _model = model;
    
    self.labSchool.text = model.schoolName;
    
    self.labCity.text = model.uniCity;
    
    [self.ivLogo sd_setImageWithURL:[NSURL URLWithString:model.logoUrl] placeholderImage:ImageNamed(@"ic_uni_logo")];
    
    for (int i = 0; i < model.major.count; i ++) {
        
        HUZSubjectVoListModel *majorModel = model.major[i];
        self.labDes1 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
        self.labDes1.text = @"1. 电子信息类";
        [self.labDes1 addAttributestring:self.labDes1.text font:FontS(FONT_12) color:ColorS(COLOR_989898) space:@" "];
        CGSize titleSize = [majorModel.category sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:self.labDes1.font.fontName size:self.labDes1.font.pointSize]}];
        
        CGFloat startX = 10;
        CGFloat startY = 0;
        CGFloat buttonHeight = AutoDistance(30);
        
        titleSize.height = 20;
        titleSize.width += 20;
        
        if(startX + titleSize.width > HUZSCREEN_WIDTH - AutoDistance(72)){
            startX = 10;
            startY = startY + buttonHeight + 10;
        }
        self.labDes1.frame = CGRectMake(startX + titleSize.width * i, startY, titleSize.width, buttonHeight);
        startX = CGRectGetMaxX(self.labDes1.frame) + 10;
        [self.majorView addSubview:self.labDes1];
        
        self.labDes1.text = majorModel.category;

    }
}
@end

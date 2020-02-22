//
//  HUZUniPriorityFillCell.m
//  HuiZe
//
//  Created by mac on 2019/4/27.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZUniPriorityFillCell.h"

@implementation HUZUniPriorityFillCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZUniPriorityFillCell";
    HUZUniPriorityFillCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (void)initView{
    
    self.ivLogo = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_uni_logo")];
    
    self.labTitle = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_17) numberOfLines:1];
    
    self.labSubTitle = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12) numberOfLines:1];
    
    self.labDetailTitle = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15) numberOfLines:1];

    UIButton *btnArrow = [[UIButton alloc]initWithImage:ImageNamed(@"ic_arrow_detail")];
    btnArrow.userInteractionEnabled = NO;
    
    [self.contentView addSubview:self.ivLogo];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labSubTitle];
    [self.contentView addSubview:self.labDetailTitle];
    [self.contentView addSubview:btnArrow];
    
    [self.ivLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(17));
        make.left.mas_offset(15);
        make.size.mas_equalTo(CGSizeMake(AutoDistance(32), AutoDistance(32)));
    }];
    
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(16));
        make.left.equalTo(self.ivLogo.mas_right).offset(AutoDistance(12));
        make.height.mas_offset(24);
    }];
    
    [self.labSubTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTitle.mas_bottom).offset(AutoDistance(4));
        make.leading.equalTo(self.labTitle);
        make.height.mas_offset(17);
    }];
    
    [btnArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(21));
        make.right.offset(-AutoDistance(32));
        make.size.sizeOffset(CGSizeMake(AutoDistance(15), AutoDistance(15)));
    }];
    
    [self.labDetailTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btnArrow);
        make.right.equalTo(btnArrow.mas_left).offset(-AutoDistance(3));
        make.height.mas_offset(21);
    }];
}

- (void)setDic:(NSMutableDictionary *)dic {
    NSString *image = dic[@"image"];
    NSString *title = dic[@"title"];
    NSString *subtitle = dic[@"subtitle"];
    NSString *detailtitle = dic[@"detailtitle"];
    self.ivLogo.image = ImageNamed(image);
    self.labTitle.text = title;
    self.labSubTitle.text = subtitle;
    self.labDetailTitle.text = [NSString stringWithFormat:@"%@所", detailtitle];
}

@end

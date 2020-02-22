//
//  HUZPayViewCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/6.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZPayViewCell.h"


@implementation HUZPayViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZPayViewCell";
    HUZPayViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (void)initView{
    
    self.contentView.backgroundColor = COLOR_BG_WHITE;
    
    self.icPay = [UIImageView new];
    
    self.labPay = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    
    self.ivSelect = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_blue_select")];
    
    self.ivDiviceline = [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    [self.contentView addSubview:self.icPay];
    [self.contentView addSubview:self.labPay];
    [self.contentView addSubview:self.ivSelect];
    [self.contentView addSubview:self.ivDiviceline];
    
    [self.icPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(AutoDistance(15));
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(AutoDistance(26), AutoDistance(26)));
    }];
    
    [self.labPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.icPay.mas_right).offset(AutoDistance(10));
    }];
    
    [self.ivSelect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-AutoDistance(15));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(12), AutoDistance(12)));
    }];
    
    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(AutoDistance(4));
    }];
}

- (void)reloadData:(NSDictionary *)entity{
    self.icPay.image = ImageNamed(entity[@"icon"]);
    self.labPay.text = entity[@"name"];
}
@end


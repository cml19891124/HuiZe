//
//  HUZPushUpWindowCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/22.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZPushUpWindowCell.h"

@implementation HUZPushUpWindowCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZPushUpWindowCell";
    HUZPushUpWindowCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (void)initView{
    
    self.labContent = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    
    self.ivSelect = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_blue_select")];
    
    self.ivDiviceline = [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    [self.contentView addSubview:self.labContent];
    [self.contentView addSubview:self.ivSelect];
    [self.contentView addSubview:self.ivDiviceline];
    
    [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(AutoDistance(15));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.ivSelect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-AutoDistance(15));
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(AutoDistance(12), AutoDistance(12)));
    }];
    
    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(AutoDistance(2));
    }];
}

- (void)reloadData:(id)entity{
    self.labContent.text = entity;
}
@end

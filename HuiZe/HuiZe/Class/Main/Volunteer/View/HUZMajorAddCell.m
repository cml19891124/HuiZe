//
//  HUZMajorAddCell.m
//  HuiZe
//
//  Created by mac on 2019/5/5.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZMajorAddCell.h"

@implementation HUZMajorAddCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZMajorAddCell";
    HUZMajorAddCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (void)initView{
    
    self.contentView.backgroundColor = COLOR_BG_WHITE;
    
    self.lab = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    self.lab.text = @"添加专业";
    
    self.btnAdd = [[UIButton alloc]initWithImageNormal:@"ic_btn_add_circle" imageSeleted:@"ic_btn_add_circle"];
    self.btnAdd.userInteractionEnabled = NO;
    [self.contentView addSubview:self.lab];
    [self.contentView addSubview:self.btnAdd];
    
    [self.lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(12));
        make.left.mas_offset(AutoDistance(15));
    }];
    
    [self.btnAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lab);
        make.right.mas_offset(-AutoDistance(12));
    }];
}

@end

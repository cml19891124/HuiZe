//
//  HUZAutoDetailTableViewCell.m
//  HuiZe
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZAutoDetailTableViewCell.h"

@interface HUZAutoDetailTableViewCell ()

@end

@implementation HUZAutoDetailTableViewCell


+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZAutoDetailTableViewCell";
    HUZAutoDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (void)initView{
    
    self.lab = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_17)];
    
    self.btn = [[UIButton alloc] initWithTitle:@"" textColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_15)];

    [self.contentView addSubview:self.lab];
    [self.contentView addSubview:self.btn];
    
    [self.lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(17));
        make.left.mas_offset(AutoDistance(15));
//        make.width.mas_greaterThanOrEqualTo(100);
    }];
    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lab);
        make.right.mas_offset(-AutoDistance(5));
        make.left.mas_greaterThanOrEqualTo(self.lab.mas_right).mas_greaterThanOrEqualTo(10);
    }];

    
}
@end

//
//  HUZAboutUsCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/6.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZAboutUsCell.h"

@interface HUZAboutUsCell ()

@property (nonatomic,strong) UILabel *labContent;
@property (nonatomic,strong) UIImageView *ivArrow;
@property (nonatomic,strong) UIImageView *ivDiviceline;

@end

@implementation HUZAboutUsCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZAboutUsCell";
    HUZAboutUsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (void)initView{
    
    self.labContent = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_17)];
    
    self.ivArrow = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_more_arrow")];
    
    self.ivDiviceline = [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    [self.contentView addSubview:self.labContent];
    [self.contentView addSubview:self.ivArrow];
    [self.contentView addSubview:self.ivDiviceline];
    
    [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(AutoDistance(15));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.ivArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-AutoDistance(15));
        make.centerY.equalTo(self.contentView);
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


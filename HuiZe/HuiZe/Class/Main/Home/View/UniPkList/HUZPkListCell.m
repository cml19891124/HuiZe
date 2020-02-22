//
//  HUZPkListCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/28.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZPkListCell.h"

@interface HUZPkListCell ()

@property (nonatomic,strong) UIImageView *ivSelect;
@property (nonatomic,strong) UIImageView *ivLogo;
@property (nonatomic,strong) UILabel *labUni;
@property (nonatomic,strong) UILabel *labCity;
@property (nonatomic,strong) UIImageView *ivArrow;
@property (nonatomic,strong) UIImageView *ivDiviceline;

@end

@implementation HUZPkListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZPkListCell";
    HUZPkListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (void)initView{
    
    self.ivSelect = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_uni_select_normal") highlightedImage:ImageNamed(@"ic_uni_select_checked")];
    
    self.ivLogo = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_uni_logo")];
    
    self.labUni = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    self.labUni.text = @"北京大学";
    
    self.labCity = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    self.labCity.text = @"北京市";
    
    self.ivArrow = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_more_arrow")];
    
    self.ivDiviceline = [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    [self.contentView addSubview:self.ivSelect];
    [self.contentView addSubview:self.ivLogo];
    [self.contentView addSubview:self.labUni];
    [self.contentView addSubview:self.labCity];
    [self.contentView addSubview:self.ivArrow];
    [self.contentView addSubview:self.ivDiviceline];
    
    [self.ivSelect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.mas_offset(AutoDistance(15));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(20), AutoDistance(20)));
    }];
    
    [self.ivLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.ivSelect);
        make.left.equalTo(self.ivSelect.mas_right).offset(AutoDistance(12));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(22), AutoDistance(22)));
    }];
    
    [self.labUni mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.ivSelect);
        make.left.equalTo(self.ivLogo.mas_right).offset(AutoDistance(4));
    }];
    
    [self.labCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.ivSelect);
        make.left.equalTo(self.labUni.mas_right).offset(AutoDistance(12));
    }];
    
    [self.ivArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.ivSelect);
        make.right.mas_offset(-AutoDistance(15));
    }];
    
    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(AutoDistance(2));
    }];
}

- (void)reloadData:(NSDictionary *)entity hasSelect:(NSMutableArray *)dataSelect{
    self.labUni.text = entity[@"uni"];
    self.labCity.text = entity[@"city"];
    if ([dataSelect containsObject:entity]) {
        self.ivSelect.highlighted = YES;
    }else{
        self.ivSelect.highlighted = NO;
    }
}

@end


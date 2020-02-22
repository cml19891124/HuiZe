//
//  HUZMyFocusSchoolCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/5.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZMyFocusSchoolCell.h"
#import "HUZMyFocusSchoolCell.h"

@interface HUZMyFocusSchoolCell ()

@property (nonatomic,strong) UIImageView *ivLogo;
@property (nonatomic,strong) UILabel *labUni;
@property (nonatomic,strong) UILabel *labCity;
@property (nonatomic,strong) UIImageView *ivArrow;
@property (nonatomic,strong) UIImageView *ivDiviceline;

@end

@implementation HUZMyFocusSchoolCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZMyFocusSchoolCell";
    HUZMyFocusSchoolCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

- (void)initView{
    self.ivLogo = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_uni_logo")];
    self.ivLogo.hidden = YES;
    self.labUni = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    self.labUni.text = @"北京大学";
    
    self.labCity = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    self.labCity.text = @"北京市";
    
    self.ivArrow = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_more_arrow")];
    
    self.ivDiviceline = [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    [self.contentView addSubview:self.ivLogo];
    [self.contentView addSubview:self.labUni];
    [self.contentView addSubview:self.labCity];
    [self.contentView addSubview:self.ivArrow];
    [self.contentView addSubview:self.ivDiviceline];
    
    [self.ivLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.mas_offset(AutoDistance(15));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(22), AutoDistance(22)));
    }];
    
    [self.labUni mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.ivLogo);
        make.left.equalTo(self.ivLogo.mas_right).offset(AutoDistance(4));
    }];
    
    [self.labCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.ivLogo);
        make.left.equalTo(self.labUni.mas_right).offset(AutoDistance(12));
    }];
    
    [self.ivArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.ivLogo);
        make.right.mas_offset(-AutoDistance(15));
    }];
    
    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(AutoDistance(2));
    }];
}

- (void)setModel:(HUZFocusSchoolDataListModel *)model {
    _model = model;
    [self.ivLogo sd_setImageWithURL:[NSURL URLWithString:model.schoolId] placeholderImage:ImageNamed(DEFAULT_IMAGE)];
    self.labUni.text = model.schoolName;
    self.labCity.text = model.provinceName;
}

@end

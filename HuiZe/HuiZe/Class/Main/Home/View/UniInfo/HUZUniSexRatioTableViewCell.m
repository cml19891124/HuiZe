//
//  HUZUniSexRatioTableViewCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/24.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniSexRatioTableViewCell.h"

@implementation HUZUniSexRatioTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZUniSexRatioTableViewCell";
    HUZUniSexRatioTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

+ (CGFloat)calculateHeightWithEntity:(id)entity{
    return AutoDistance(178);
}

- (void)initView{
    
    self.ivBg = [UIView new];
    self.ivBg.backgroundColor = ColorS(COLOR_BG_000000);
    self.ivBg.alpha = 0.06;
    ViewRadius(self.ivBg, AutoDistance(8));
    
    self.ivMale = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_male")];
    
    self.ivFemale = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_female")];
    
    self.lineProgressView = [ZYLineProgressView new];
    self.lineProgressView.config.backLineColor = ColorS(COLOR_BG_D8D8D8);
    self.lineProgressView.config.progressLineColor = ColorS(COLOR_BG_2E86FF);
    self.lineProgressView.config.isShowDot = NO;
    self.lineProgressView.progress = 0.632;
    
    self.labMale = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    self.labMale.text = @"63.2%";
    
    self.labFemale = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12) textAlignment:NSTextAlignmentRight];
    self.labFemale.text = @"36.8%";

    [self.contentView addSubview:self.ivBg];
    [self.contentView addSubview:self.ivMale];
    [self.contentView addSubview:self.ivFemale];
    [self.contentView addSubview:self.lineProgressView];
    [self.contentView addSubview:self.labMale];
    [self.contentView addSubview:self.labFemale];
    
    
    [self.ivBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(HUZSCREEN_WIDTH-AutoDistance(30), AutoDistance(140)));
    }];
    
    [self.ivMale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(24));
        make.left.mas_offset(AutoDistance(60));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(48), AutoDistance(48)));
    }];
    
    [self.ivFemale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(24));
        make.right.mas_offset(-AutoDistance(60));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(48), AutoDistance(48)));
    }];
    
    [self.lineProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ivMale.mas_bottom).offset(AutoDistance(18));
        make.centerX.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(HUZSCREEN_WIDTH-AutoDistance(120), AutoDistance(5)));
    }];
    
    [self.labMale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineProgressView.mas_bottom).offset(AutoDistance(4));
        make.left.mas_offset(AutoDistance(60));
    }];
    
    [self.labFemale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineProgressView.mas_bottom).offset(AutoDistance(4));
        make.right.mas_offset(-AutoDistance(60));
    }];
}

- (void)setUniInfoModel:(HUZUniInfoGeneralizeDataModel *)uniInfoModel{
    _uniInfoModel = uniInfoModel;
    self.lineProgressView.progress = [uniInfoModel.schoolBoy floatValue]/100;
    self.labMale.text = [NSString stringWithFormat:@"%@%%",uniInfoModel.schoolBoy];
    self.labFemale.text = [NSString stringWithFormat:@"%@%%",uniInfoModel.schoolGirl];
    
}


@end

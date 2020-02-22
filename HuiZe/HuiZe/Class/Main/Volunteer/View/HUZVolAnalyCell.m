//
//  HUZVolAnalyCell.m
//  HuiZe
//
//  Created by mac on 2019/5/5.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZVolAnalyCell.h"

@implementation HUZVolAnalyCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZVolAnalyCell";
    HUZVolAnalyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

- (void)initView{
    
    self.contentView.backgroundColor = COLOR_BG_WHITE;
    
    self.tlab = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    
    [self.contentView addSubview:self.tlab];
    
    [self.tlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(15));
        make.left.mas_offset(AutoDistance(15));
    }];
}

- (void)setVolAnalyTpyeWith:(VolAnalyType)type andTitle:(NSString *)title andArray:(NSArray*)array {
    self.tlab.text  = title;
    switch (type) {
        case VolAnalyTypeOne:
        {
            HUZCompletenessModel *model = array[0];
            if ([model.type isEqualToString:@"2"]) {
                [self.fBtn setImage:ImageNamed(@"ic_btn_error") forState:UIControlStateNormal];
            }else if ([model.type isEqualToString:@"1"]) {
                [self.fBtn setImage:ImageNamed(@"ic_btn_warming") forState:UIControlStateNormal];
            }else if ([model.type isEqualToString:@"0"]) {
                [self.fBtn setImage:ImageNamed(@"ic_btn_fine") forState:UIControlStateNormal];
            }
            [self.fBtn setTitle:model.Reasonable forState:UIControlStateNormal];
            
            [self.contentView addSubview:self.fBtn];
            [self.fBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.tlab.mas_bottom).offset(AutoDistance(17));
                make.left.mas_offset(AutoDistance(15));
            }];
        }
            break;
        case VolAnalyTypeTwo:
        {
            HUZRationalityListModel *model0 = array[0];
            HUZRationalityListModel *model1 = array[1];
            HUZRationalityListModel *model2 = array[2];

            [self.fBtn setTitle:model0.Reasonable forState:UIControlStateNormal];
            if ([model0.type isEqualToString:@"2"]) {
                [self.fBtn setImage:ImageNamed(@"ic_btn_error") forState:UIControlStateNormal];
            }else if ([model0.type isEqualToString:@"1"]) {
                [self.fBtn setImage:ImageNamed(@"ic_btn_warming") forState:UIControlStateNormal];
            }else if ([model0.type isEqualToString:@"0"]) {
                [self.fBtn setImage:ImageNamed(@"ic_btn_fine") forState:UIControlStateNormal];
            }
            [self.sBtn setTitle:model1.Reasonable forState:UIControlStateNormal];
            if ([model1.type isEqualToString:@"2"]) {
                [self.sBtn setImage:ImageNamed(@"ic_btn_error") forState:UIControlStateNormal];
            }else if ([model1.type isEqualToString:@"1"]) {
                [self.sBtn setImage:ImageNamed(@"ic_btn_warming") forState:UIControlStateNormal];
            }else if ([model1.type isEqualToString:@"0"]) {
                [self.sBtn setImage:ImageNamed(@"ic_btn_fine") forState:UIControlStateNormal];
            }
            [self.tBtn setTitle:model2.Reasonable forState:UIControlStateNormal];
            if ([model2.type isEqualToString:@"2"]) {
                [self.tBtn setImage:ImageNamed(@"ic_btn_error") forState:UIControlStateNormal];
            }else if ([model2.type isEqualToString:@"1"]) {
                [self.tBtn setImage:ImageNamed(@"ic_btn_warming") forState:UIControlStateNormal];
            }else if ([model2.type isEqualToString:@"0"]) {
                [self.tBtn setImage:ImageNamed(@"ic_btn_fine") forState:UIControlStateNormal];
            }
            [self.contentView addSubview:self.fBtn];
            [self.fBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.tlab.mas_bottom).offset(AutoDistance(17));
                make.left.mas_offset(AutoDistance(15));
            }];
            [self.contentView addSubview:self.sBtn];
            [self.sBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.fBtn.mas_bottom).offset(AutoDistance(12));
                make.left.mas_offset(AutoDistance(15));
            }];
            
            [self.contentView addSubview:self.tBtn];
            [self.tBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.top.equalTo(self.sBtn.mas_bottom).offset(AutoDistance(12));
                            make.left.mas_offset(AutoDistance(15));
            }];
        }
            break;
        case VolAnalyTypeThree:
        {
            HUZCompletenessModel *model0 = array[0];
            HUZCompletenessModel *model1 = array[1];

            [self.fBtn setTitle:model0.Reasonable forState:UIControlStateNormal];
            if ([model0.type isEqualToString:@"2"]) {
                [self.fBtn setImage:ImageNamed(@"ic_btn_error") forState:UIControlStateNormal];
            }else if ([model0.type isEqualToString:@"1"]) {
                [self.fBtn setImage:ImageNamed(@"ic_btn_warming") forState:UIControlStateNormal];
            }else if ([model0.type isEqualToString:@"0"]) {
                [self.fBtn setImage:ImageNamed(@"ic_btn_fine") forState:UIControlStateNormal];
            }
            [self.sBtn setTitle:model1.Reasonable forState:UIControlStateNormal];
            if ([model1.type isEqualToString:@"2"]) {
                [self.sBtn setImage:ImageNamed(@"ic_btn_error") forState:UIControlStateNormal];
            }else if ([model1.type isEqualToString:@"1"]) {
                [self.sBtn setImage:ImageNamed(@"ic_btn_warming") forState:UIControlStateNormal];
            }else if ([model1.type isEqualToString:@"0"]) {
                [self.sBtn setImage:ImageNamed(@"ic_btn_fine") forState:UIControlStateNormal];
            }
//            [self.tBtn setTitle:model2.Reasonable forState:UIControlStateNormal];

            [self.contentView addSubview:self.fBtn];
            [self.fBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.tlab.mas_bottom).offset(AutoDistance(17));
                make.left.mas_offset(AutoDistance(15));
            }];
            [self.contentView addSubview:self.sBtn];
            [self.sBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.fBtn.mas_bottom).offset(AutoDistance(12));
                make.left.mas_offset(AutoDistance(15));
            }];
            [self.contentView addSubview:self.tBtn];
//            [self.tBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self.sBtn.mas_bottom).offset(AutoDistance(12));
//                make.left.mas_offset(AutoDistance(15));
//            }];
        }
            break;
        default:
            break;
    }
}

- (UIButton *)fBtn {
    if (!_fBtn) {
        _fBtn = [[UIButton alloc]initWithTitle:@"" textColor:ColorS(COLOR_848484) autoTextFont:FontS(FONT_12)];
        [_fBtn setImage:ImageNamed(@"ic_btn_fine") forState:UIControlStateNormal];
        _fBtn.imageEdgeInsets = UIEdgeInsetsMake(0.0,  -8.0 , 0.0, 0.0);
        _fBtn.userInteractionEnabled = NO;
    }
    return _fBtn;
}

- (UIButton *)sBtn {
    if (!_sBtn) {
        _sBtn = [[UIButton alloc]initWithTitle:@"" textColor:ColorS(COLOR_848484) autoTextFont:FontS(FONT_12)];
        [_sBtn setImage:ImageNamed(@"ic_btn_fine") forState:UIControlStateNormal];
        _sBtn.imageEdgeInsets = UIEdgeInsetsMake(0.0,  -8.0 , 0.0, 0.0);
        _sBtn.userInteractionEnabled = NO;
        
    }
    return _sBtn;
}

- (UIButton *)tBtn {
    if (!_tBtn) {
        _tBtn = [[UIButton alloc]initWithTitle:@"" textColor:ColorS(COLOR_848484) autoTextFont:FontS(FONT_12)];
        [_tBtn setImage:ImageNamed(@"ic_btn_fine") forState:UIControlStateNormal];
        _tBtn.imageEdgeInsets = UIEdgeInsetsMake(0.0,  -8.0 , 0.0, 0.0);
        _tBtn.userInteractionEnabled = NO;
    }
    return _tBtn;
}

@end

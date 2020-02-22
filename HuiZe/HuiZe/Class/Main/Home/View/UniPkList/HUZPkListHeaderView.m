//
//  HUZPkListHeaderView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/28.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZPkListHeaderView.h"

@implementation HUZPkListHeaderView

- (void)initView{
    self.backgroundColor = COLOR_BG_WHITE;
    
    self.ivBg = [UIView new];
    self.ivBg.backgroundColor = ColorS(COLOR_000000);
    self.ivBg.alpha = 0.08;
    ViewRadius(self.ivBg, AutoDistance(4));
    
    self.ivSearch = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_search")];
    
    self.tfKeyword = [UITextField new];
    self.tfKeyword.placeholder  = @"搜索院校";
    self.tfKeyword.returnKeyType = UIReturnKeySearch;
    self.tfKeyword.textColor = ColorS(COLOR_414141);
    self.tfKeyword.font = FontS(FONT_12);
    self.tfKeyword.clearButtonMode = UITextFieldViewModeAlways;
    self.ivDiviceline = [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    [self addSubview:self.ivBg];
    [self addSubview:self.ivSearch];
    [self addSubview:self.tfKeyword];
    [self addSubview:self.ivDiviceline];
    
    [self.ivBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(HUZSCREEN_WIDTH-AutoDistance(30), AutoDistance(30)));
    }];
    
    [self.ivSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ivBg).offset(AutoDistance(12));
        make.centerY.equalTo(self.ivBg);
        make.size.mas_equalTo(CGSizeMake(AutoDistance(15), AutoDistance(15)));
    }];
    
    [self.tfKeyword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ivSearch.mas_right).offset(AutoDistance(8));
        make.right.equalTo(self.ivBg).offset(-AutoDistance(10));
        make.centerY.equalTo(self.ivBg);
    }];
    
    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(AutoDistance(8));
    }];
}

@end

//
//  HUZSearchNavView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/19.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZSearchNavView.h"

@implementation HUZSearchNavView

- (void)initView{
    
    
    self.ivBg = [UIView new];
    self.ivBg.backgroundColor = ColorS(COLOR_000000);
    self.ivBg.alpha = 0.08;
    ViewRadius(self.ivBg, AutoDistance(4));
    
    self.ivSearch = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_search")];
    
    self.tfKeyword = [UITextField new];
    self.tfKeyword.placeholder  = @"关键字";
    self.tfKeyword.returnKeyType = UIReturnKeySearch;
    self.tfKeyword.textColor = ColorS(COLOR_414141);
    self.tfKeyword.font = FontS(FONT_12);
    
    [self addSubview:self.ivBg];
    [self addSubview:self.ivSearch];
    [self addSubview:self.tfKeyword];
    
    [self.ivBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(HUZSCREEN_WIDTH-AutoDistance(58), AutoDistance(30)));
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
    
}

@end

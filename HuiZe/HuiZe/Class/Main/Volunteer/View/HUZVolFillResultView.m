//
//  HUZVolFillResultView.m
//  HuiZe
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZVolFillResultView.h"

@implementation HUZVolFillResultView

-(void)initView {
    
    UIImageView *bgImage = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_btn_result_bg")];

    self.bBtn = [[UIButton alloc]initWithImageNormal:@"nav_back_white" imageSeleted:@"nav_back_white"];

    self.ivLogo = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_btn_result")];

    self.labResult = [[UILabel alloc] initWithTextColor:COLOR_BG_WHITE autoTextFont:FontS(FONT_24)];
    self.labResult.text = @"--";
    self.labResult.textAlignment = NSTextAlignmentCenter;
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = COLOR_BG_WHITE;
    
    self.labAnaly = [[UILabel alloc] initWithTextColor:COLOR_BG_WHITE autoTextFont:FontS(FONT_14)];
    self.labAnaly.text = @"此志愿表--";
    self.labAnaly.textAlignment = NSTextAlignmentCenter;
    self.detailBtn = [[UIButton alloc]initWithTitle:@"查看详情" textColor:COLOR_BG_WHITE autoTextFont:FontS(FONT_17)];
    self.detailBtn.backgroundColor = ColorS(COLOR_2E86FF);
    ViewRadius(self.detailBtn, 22);
    
    self.volBtn = [[UIButton alloc]initWithTitle:@"我的志愿表" textColor:ColorS(COLOR_2E86FF) autoTextFont:FontS(FONT_17)];
    self.volBtn.backgroundColor = COLOR_BG_WHITE;
    ViewRadius(self.volBtn, 22);
    
    [self addSubview:bgImage];
    [self addSubview:self.bBtn];
    [self addSubview:self.ivLogo];
    [self addSubview:self.labResult];
    [self addSubview:line];
    [self addSubview:self.labAnaly];
    [self addSubview:self.detailBtn];
    [self addSubview:self.volBtn];

    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.left.equalTo(self);
    }];
    
    [self.bBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(33));
        make.left.mas_offset(AutoDistance(15));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(20), AutoDistance(28)));
    }];
    
    [self.ivLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(108));
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(AutoDistance(80), AutoDistance(80)));
    }];
    
    [self.labResult mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(AutoDistance(100));
        make.top.equalTo(self.ivLogo.mas_bottom).offset(AutoDistance(25));
        make.centerX.equalTo(self);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(AutoDistance(60));
        make.height.mas_equalTo(AutoDistance(2));
        make.top.equalTo(self.labResult.mas_bottom).offset(AutoDistance(5));
        make.centerX.equalTo(self);
    }];
    
    [self.labAnaly mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(AutoDistance(135));
        make.top.equalTo(self.labResult.mas_bottom).offset(AutoDistance(31));
        make.centerX.equalTo(self);
    }];
    
    [self.detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(AutoDistance(300));
        make.height.mas_equalTo(AutoDistance(44));
        make.top.equalTo(self.labAnaly.mas_bottom).offset(AutoDistance(64));
        make.centerX.equalTo(self);
    }];
    
    [self.volBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.detailBtn);
        make.height.mas_equalTo(AutoDistance(44));
        make.top.equalTo(self.detailBtn.mas_bottom).offset(AutoDistance(32));
        make.centerX.equalTo(self);
    }];
}

@end

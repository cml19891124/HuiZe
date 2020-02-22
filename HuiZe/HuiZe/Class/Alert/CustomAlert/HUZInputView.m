//
//  HUZInputView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/22.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZInputView.h"

@implementation HUZInputView

- (void)initView{
    
    self.backgroundColor = COLOR_BG_WHITE;
    ViewRadius(self, AutoDistance(8));
    
    self.labTitle = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15) textAlignment:NSTextAlignmentCenter];
    
    self.tfInput = [UITextField new];
    [self.tfInput setFont:FontS(FONT_17)];
    self.tfInput.textColor = ColorS(COLOR_414141);
//    self.tfInput.keyboardType = UIKeyboardTypeNumberPad;
    
    self.btnCancel = [[UIButton alloc] initWithTitle:@"取消" textColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_17)];
    
    self.btnConfirm = [[UIButton alloc] initWithTitle:@"确定" textColor:ColorS(COLOR_2E86FF) autoTextFont:FontS(FONT_17)];
    
    [self addSubview:self.labTitle];
    [self addSubview:self.tfInput];
    [self addSubview:self.btnCancel];
    [self addSubview:self.btnConfirm];
    
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.mas_offset(AutoDistance(24));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(230), AutoDistance(21)));
    }];
    
    [self.tfInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTitle.mas_bottom).offset(AutoDistance(6));
        make.left.mas_offset(AutoDistance(24));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(240), AutoDistance(21)));
    }];
    
    [self.btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfInput.mas_bottom).offset(AutoDistance(22));
        make.left.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(AutoDistance(278)/2.0, AutoDistance(30)));
    }];
    
    [self.btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfInput.mas_bottom).offset(AutoDistance(22));
        make.right.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(AutoDistance(278)/2.0, AutoDistance(30)));
    }];
}

@end

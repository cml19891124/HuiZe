//
//  HUZForgetPsdView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/20.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZForgetPsdView.h"

@implementation HUZForgetPsdView

- (void)initView{
    
    self.backgroundColor = COLOR_BG_WHITE;
    
    self.btnBack = [[UIButton alloc] initWithTitle:@"忘记密码" textColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_24)];
    [self.btnBack setImage:ImageNamed(NAV_BACK_BLACK) forState:UIControlStateNormal];
    [self.btnBack LeftImageRightTitleWithSpace:AutoDistance(15)];
    [self.btnBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    self.labTip = [[UILabel alloc] initWithTextColor:ColorS(COLOR_2E86FF) autoTextFont:FontS(FONT_12)];
    self.labTip.text = @"原手机认证成功、请重新设置密码";
    
    self.tfPsd = [ACFloatingTextField new];
    self.tfPsd.placeholder = @"请设置新密码";
    [self.tfPsd setFont:FontS(FONT_15)];
    self.tfPsd.delegate = self;
    [self.tfPsd becomeFirstResponder];
    self.tfPsd.textColor = ColorS(COLOR_989898);
    self.tfPsd.lineColor = ColorS(COLOR_C8C8C8);
    self.tfPsd.selectedLineColor = ColorS(COLOR_C8C8C8);
    [self.tfPsd addTarget:self action:@selector(tfTextChange:) forControlEvents:UIControlEventEditingChanged];
    self.tfPsd.secureTextEntry = YES;
    
    self.btnEye = [[UIButton alloc] initWithImageNormal:@"ic_psd_hide" imageSeleted:@"ic_psd_nohide2"];
    [self.btnEye addTarget:self action:@selector(setSecure) forControlEvents:UIControlEventTouchUpInside];
    self.btnEye.selected = NO;
    
    self.btnComplete = [[UIButton alloc] initWithNormalColor:ColorS(COLOR_989898) selectColor:ColorS(COLOR_2E86FF)];
    [self.btnComplete setTitle:@"完成" forState:UIControlStateNormal];
    [self.btnComplete addTarget:self action:@selector(completion) forControlEvents:UIControlEventTouchUpInside];
    self.btnComplete.enabled = NO;
    ViewRadius(self.btnComplete, AutoDistance(22));
    
    [self addSubview:self.btnBack];
    [self addSubview:self.labTip];
    [self addSubview:self.tfPsd];
    [self addSubview:self.btnEye];
    [self addSubview:self.btnComplete];
    
    
    [self.btnBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT));
        make.left.mas_offset(AutoDistance(15));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(120),AutoDistance(33)));
    }];
    
    [self.labTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnBack.mas_bottom).offset(AutoDistance(12));
        make.left.mas_offset(AutoDistance(38));
    }];
    
    [self.tfPsd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTip.mas_bottom).offset(AutoDistance(59));
        make.left.mas_offset(AutoDistance(38));
        make.right.mas_offset(-AutoDistance(38));
        make.height.mas_equalTo(AutoDistance(44));
    }];
    
    [self.btnEye mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.tfPsd);
        make.right.mas_offset(-AutoDistance(46));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(17), AutoDistance(17)));
    }];
    
    [self.btnComplete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.tfPsd.mas_bottom).offset(AutoDistance(174));
        make.size.mas_equalTo(CGSizeMake(HUZSCREEN_WIDTH- AutoDistance(76), AutoDistance(44)));
    }];
}

- (void)back{
    [[UIViewController currentViewController].navigationController popViewControllerAnimated:YES];
}

- (void)completion {
    if (self.completeBlock) {
        self.completeBlock(self.tfPsd.text);
    }
}

- (void)setSecure{
    self.btnEye.selected = !self.btnEye.selected;
    self.tfPsd.secureTextEntry = self.btnEye.selected ? NO :YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == self.tfPsd) {
        self.tfPsd.placeholder = @"密码";
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.tfPsd && DRStringIsEmpty(self.tfPsd.text)) {
        self.tfPsd.placeholder = @"请输入手机号";
    }
}

- (void)tfTextChange:(UITextField *)textField{
    self.btnComplete.enabled = DRStringIsNotEmpty(self.tfPsd.text) ? YES : NO;
}


@end

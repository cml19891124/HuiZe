//
//  HUZPsdLoginView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/20.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZPsdLoginView.h"

@implementation HUZPsdLoginView

- (void)initView{
    self.ivBg = [[UIImageView alloc] initWithImage:ImageNamed(@"bg／bgr")];
    
    
    self.btnBack = [[UIButton alloc] initWithTitle:@"欢迎来到慧择云志愿" textColor:ColorS(COLOR_ffffff) autoTextFont:FontS(FONT_24)];
    [self.btnBack setImage:ImageNamed(NAV_BACK_WHITE) forState:UIControlStateNormal];
    [self.btnBack LeftImageRightTitleWithSpace:AutoDistance(15)];
    [self.btnBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    self.tfPhone = [ACFloatingTextField new];
    self.tfPhone.placeholder = @"请输入手机号";
    NSString *mobile = HUZUserCenterManager.mobile;
    if (DRStringIsNotEmpty(mobile)) {
        self.tfPhone.text = mobile;
    }
    [self.tfPhone becomeFirstResponder];
    [self.tfPhone setFont:FontS(FONT_15)];
    self.tfPhone.delegate = self;
    self.tfPhone.textColor = ColorS(COLOR_C8C8C8);
    self.tfPhone.keyboardType = UIKeyboardTypeNumberPad;
    [self.tfPhone addTarget:self action:@selector(tfTextChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.tfPsd = [ACFloatingTextField new];
    self.tfPsd.placeholder = @"请输入密码";
    [self.tfPsd setFont:FontS(FONT_15)];
    self.tfPsd.delegate = self;
    self.tfPsd.textColor = ColorS(COLOR_C8C8C8);
    [self.tfPsd addTarget:self action:@selector(tfTextChange:) forControlEvents:UIControlEventEditingChanged];
    self.tfPsd.secureTextEntry = YES;
    
    self.btnEye = [[UIButton alloc] initWithImageNormal:@"ic_psd_hide" imageSeleted:@"ic_psd_nohide"];
    self.btnEye.selected = NO;
    [self.btnEye addTarget:self action:@selector(setSecure) forControlEvents:UIControlEventTouchUpInside];
    
    self.btnSmsLogin = [[UIButton alloc] initWithTitle:@"手机验证码登录" textColor:ColorS(COLOR_ffffff) autoTextFont:FontS(FONT_12)];
    [self.btnSmsLogin setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.btnSmsLogin addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    self.btnForget = [[UIButton alloc] initWithTitle:@"忘记密码?" textColor:ColorS(COLOR_ffffff) autoTextFont:FontS(FONT_12)];
    [self.btnForget setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];

    self.btnLogin = [[UIButton alloc] initWithNormalColor:ColorS(COLOR_989898) selectColor:ColorS(COLOR_2E86FF)];
    [self.btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    [self.btnLogin addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    self.btnLogin.enabled = NO;
    ViewRadius(self.btnLogin, AutoDistance(22));
    
    [self addSubview:self.ivBg];
    [self addSubview:self.btnBack];
    [self addSubview:self.tfPhone];
    [self addSubview:self.tfPsd];
    [self addSubview:self.btnEye];
    [self addSubview:self.btnSmsLogin];
    [self addSubview:self.btnForget];
    [self addSubview:self.btnLogin];
    
    [self.ivBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    [self.btnBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT));
        make.left.mas_offset(AutoDistance(15));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(250),AutoDistance(33)));
    }];
    
    [self.tfPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnBack.mas_bottom).offset(AutoDistance(88));
        make.left.mas_offset(AutoDistance(38));
        make.right.mas_offset(-AutoDistance(38));
        make.height.mas_equalTo(AutoDistance(44));
    }];
    
    [self.tfPsd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPhone.mas_bottom).offset(AutoDistance(64));
        make.left.mas_offset(AutoDistance(38));
        make.right.mas_offset(-AutoDistance(38));
        make.height.mas_equalTo(AutoDistance(44));
    }];
    
    [self.btnEye mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.tfPsd).offset(AutoDistance(4));
        make.right.mas_offset(-AutoDistance(46));
        make.size.mas_equalTo(CGSizeMake(17, 17));
    }];
    
    [self.btnSmsLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPsd.mas_bottom).offset(AutoDistance(12));
        make.left.equalTo(self).offset(AutoDistance(38));
        make.size.mas_equalTo(CGSizeMake(100, 17));
    }];
    
    [self.btnForget mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPsd.mas_bottom).offset(AutoDistance(12));
        make.right.mas_offset(-AutoDistance(38));
        make.size.mas_equalTo(CGSizeMake(100, 17));
    }];
    
    [self.btnLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.tfPsd.mas_bottom).offset(AutoDistance(82));
        make.size.mas_equalTo(CGSizeMake(HUZSCREEN_WIDTH- AutoDistance(76), AutoDistance(44)));
    }];
}

- (void)back{
    [[UIViewController currentViewController].navigationController popViewControllerAnimated:YES];
}

- (void)setSecure{
    self.btnEye.selected = !self.btnEye.selected;
    self.tfPsd.secureTextEntry = self.btnEye.selected ? NO :YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == self.tfPhone) {
        self.tfPhone.placeholder = @"手机号";
    }else if (textField == self.tfPsd){
        self.tfPsd.placeholder = @"密码";
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.tfPhone && DRStringIsEmpty(self.tfPhone.text)) {
        self.tfPhone.placeholder = @"请输入手机号";
    }else if (textField == self.tfPsd && DRStringIsEmpty(self.tfPsd.text)){
        self.tfPsd.placeholder = @"请输入密码";
    }
}

- (void)tfTextChange:(UITextField *)textField{
    self.btnLogin.enabled = (DRStringIsNotEmpty(self.tfPhone.text) && DRStringIsNotEmpty(self.tfPsd.text)) ? YES : NO;
}

- (void)login { // 登录注册
    if (self.loginBlock) {
        self.loginBlock(self.tfPhone.text, self.tfPsd.text);
    }
}
@end

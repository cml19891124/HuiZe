//
//  HUZCodeLoginView.m
//  HuiZe
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZCodeLoginView.h"

@implementation HUZCodeLoginView

- (void)initView{
    self.backgroundColor = [UIColor clearColor];
    
    self.labWel = [[UILabel alloc] initWithTextColor:ColorS(COLOR_ffffff) autoTextFont:FontS(FONT_24)];
    self.labWel.text = @"欢迎来到慧择云志愿";
    
    self.tfPhone = [ACFloatingTextField new];
    self.tfPhone.placeholder = @"请输入手机号";
    [self.tfPhone setFont:FontS(FONT_15)];
    self.tfPhone.delegate = self;
    NSString *mobile = HUZUserCenterManager.mobile;
    if (DRStringIsNotEmpty(mobile)) {
        self.tfPhone.text = mobile;
    }
    self.tfPhone.textColor = ColorS(COLOR_C8C8C8);
    self.tfPhone.keyboardType = UIKeyboardTypeNumberPad;
    [self.tfPhone addTarget:self action:@selector(tfTextChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.btnCode = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, AutoDistance(100), AutoDistance(30))];
    [self.btnCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.btnCode.titleLabel.font = FontS(FONT_14);
    [self.btnCode setTitleColor:ColorS(COLOR_C8C8C8) forState:UIControlStateNormal];
    [self.btnCode addTarget:self action:@selector(codeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.tfPsd = [ACFloatingTextField new];
    self.tfPsd.placeholder = @"请输入验证码";
    [self.tfPsd setFont:FontS(FONT_15)];
    self.tfPsd.delegate = self;
    self.tfPsd.rightView = self.btnCode;
    self.tfPsd.rightViewMode = UITextFieldViewModeAlways;
    self.tfPsd.keyboardType = UIKeyboardTypeNumberPad;
    self.tfPsd.textColor = ColorS(COLOR_C8C8C8);
    [self.tfPsd addTarget:self action:@selector(tfTextChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    self.btnSmsLogin = [[UIButton alloc] initWithTitle:@"账号密码登录" textColor:ColorS(COLOR_ffffff) autoTextFont:FontS(FONT_12)];
    [self.btnSmsLogin setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    
    self.btnForget = [[UIButton alloc] initWithTitle:@"忘记密码?" textColor:ColorS(COLOR_ffffff) autoTextFont:FontS(FONT_12)];
    [self.btnForget setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];

    self.btnLogin = [[UIButton alloc] initWithNormalColor:ColorS(COLOR_989898) selectColor:ColorS(COLOR_2E86FF)];
    [self.btnLogin setTitle:@"登录/注册" forState:UIControlStateNormal];
    [self.btnLogin addTarget:self action:@selector(loginAndRegist) forControlEvents:UIControlEventTouchUpInside];
    self.btnLogin.enabled = NO;
    ViewRadius(self.btnLogin, AutoDistance(22));
    
    [self addSubview:self.labWel];
    [self addSubview:self.tfPhone];
    [self addSubview:self.tfPsd];
    [self addSubview:self.btnSmsLogin];
    [self addSubview:self.btnForget];
    [self addSubview:self.btnLogin];

    [self.labWel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(AutoDistance(38));
        make.top.mas_offset(AutoDistance(HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT));
    }];
    
    [self.tfPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labWel.mas_bottom).offset(AutoDistance(88));
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

- (void)codeButtonClick {
    if (self.codeBlock) {
        self.codeBlock(self.tfPhone.text);
    }
}

- (void)loginAndRegist { // 登录注册
    if (self.loginBlock) {
        self.loginBlock(self.tfPhone.text, self.tfPsd.text);
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == self.tfPhone) {
        self.tfPhone.placeholder = @"手机号";
    }else if (textField == self.tfPsd){
        self.tfPsd.placeholder = @"验证码";
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.tfPhone && DRStringIsEmpty(self.tfPhone.text)) {
        self.tfPhone.placeholder = @"请输入手机号";
    }else if (textField == self.tfPsd && DRStringIsEmpty(self.tfPsd.text)){
        self.tfPsd.placeholder = @"请输入验证码";
    }
}

- (void)tfTextChange:(UITextField *)textField{
    self.btnLogin.enabled = (DRStringIsNotEmpty(self.tfPhone.text) && DRStringIsNotEmpty(self.tfPsd.text)) ? YES : NO;
}

- (Calculagraph *)codeTimer {
    if (!_codeTimer) {
        _codeTimer = [[Calculagraph alloc] init];
        [_codeTimer addObserver:self forKeyPath:@"time" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _codeTimer;
}

#pragma mark 计时器KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"time"]) {
        NSInteger seconds = [[change objectForKey:@"new"] integerValue];
        NSString *time = [NSString stringWithFormat:@"%zdS",60-seconds];
        self.btnCode.enabled = NO;
        [self.btnCode setTitle:time forState:UIControlStateDisabled];
        
        if ([time isEqualToString:@"0S"]) {
            [self.codeTimer stop];
            self.btnCode.enabled = YES;
        }
    }
}


- (void)dealloc {
    [self.codeTimer removeObserver:self forKeyPath:@"time"];
}

@end

//
//  HUZBindPhoneView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/20.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZBindPhoneView.h"

@implementation HUZBindPhoneView

- (void)initView{
    self.ivBg = [[UIImageView alloc] initWithImage:ImageNamed(@"bg／bgr")];
    
    self.btnBack = [[UIButton alloc] initWithTitle:@"欢迎来到慧择云志愿" textColor:ColorS(COLOR_ffffff) autoTextFont:FontS(FONT_24)];
    [self.btnBack setImage:ImageNamed(NAV_BACK_WHITE) forState:UIControlStateNormal];
    [self.btnBack LeftImageRightTitleWithSpace:AutoDistance(15)];
    [self.btnBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    self.tfPhone = [ACFloatingTextField new];
    self.tfPhone.placeholder = @"请输入手机号";
    [self.tfPhone setFont:FontS(FONT_15)];
    self.tfPhone.delegate = self;
    [self.tfPhone becomeFirstResponder];
    self.tfPhone.textColor = ColorS(COLOR_C8C8C8);
    self.tfPhone.keyboardType = UIKeyboardTypeNumberPad;
    [self.tfPhone addTarget:self action:@selector(tfTextChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.btnCode = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, AutoDistance(100), AutoDistance(30))];
    [self.btnCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.btnCode.titleLabel.font = FontS(FONT_14);
    [self.btnCode setTitleColor:ColorS(COLOR_C8C8C8) forState:UIControlStateNormal];
    [self.btnCode addTarget:self action:@selector(codeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.tfSms = [ACFloatingTextField new];
    self.tfSms.placeholder = @"请输入验证码";
    [self.tfSms setFont:FontS(FONT_15)];
    self.tfSms.delegate = self;
    self.tfSms.rightView = self.btnCode;
    self.tfSms.rightViewMode = UITextFieldViewModeAlways;
    self.tfSms.keyboardType = UIKeyboardTypeNumberPad;
    self.tfSms.textColor = ColorS(COLOR_C8C8C8);
    [self.tfSms addTarget:self action:@selector(tfTextChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    self.btnNext = [[UIButton alloc] initWithNormalColor:ColorS(COLOR_989898) selectColor:ColorS(COLOR_2E86FF)];
    [self.btnNext setTitle:@"下一步" forState:UIControlStateNormal];
    [self.btnNext addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    self.btnNext.enabled = NO;
    ViewRadius(self.btnNext, AutoDistance(22));
    
    [self addSubview:self.ivBg];
    [self addSubview:self.btnBack];
    [self addSubview:self.tfPhone];
    [self addSubview:self.tfSms];
    [self addSubview:self.btnNext];
    
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
    
    [self.tfSms mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPhone.mas_bottom).offset(AutoDistance(64));
        make.left.mas_offset(AutoDistance(38));
        make.right.mas_offset(-AutoDistance(38));
        make.height.mas_equalTo(AutoDistance(44));
    }];
    
    [self.btnNext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.tfSms.mas_bottom).offset(AutoDistance(82));
        make.size.mas_equalTo(CGSizeMake(HUZSCREEN_WIDTH- AutoDistance(76), AutoDistance(44)));
    }];
}

- (void)back{
    [[UIViewController currentViewController].navigationController popViewControllerAnimated:YES];
}


- (void)codeButtonClick {
    if (self.codeBlock) {
        self.codeBlock(self.tfPhone.text);
    }
}

- (void)next {
    if (self.loginBlock) {
        self.loginBlock(self.tfPhone.text, self.tfSms.text);
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == self.tfPhone) {
        self.tfPhone.placeholder = @"手机号";
    }else if (textField == self.tfSms){
        self.tfSms.placeholder = @"验证码";
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.tfPhone && DRStringIsEmpty(self.tfPhone.text)) {
        self.tfPhone.placeholder = @"请输入手机号";
    }else if (textField == self.tfSms && DRStringIsEmpty(self.tfSms.text)){
        self.tfSms.placeholder = @"请输入验证码";
    }
}

- (void)tfTextChange:(UITextField *)textField{
    self.btnNext.enabled = (DRStringIsNotEmpty(self.tfPhone.text) && DRStringIsNotEmpty(self.tfSms.text)) ? YES : NO;
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

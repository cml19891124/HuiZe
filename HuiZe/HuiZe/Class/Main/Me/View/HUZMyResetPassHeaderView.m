//
//  HUZMyResetPassHeaderView.m
//  HuiZe
//
//  Created by mac on 2019/5/14.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZMyResetPassHeaderView.h"

@interface HUZMyResetPassHeaderView ()
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *lab;
@end

@implementation HUZMyResetPassHeaderView

- (void)initView{
    
    self.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, AutoDistance(12), HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT - HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT - AutoDistance(12))];
    self.bgView.backgroundColor = COLOR_BG_WHITE;
    [self addSubview:self.bgView];
    
    self.lab = [[UILabel alloc] initWithTextColor:ColorS(COLOR_2E86FF) autoTextFont:FontS(FONT_12)];
    self.lab.text = @"设置密码后可以通过手机号 + 密码登录 慧择高考";
    self.lab.frame = CGRectMake(AutoDistance(38), AutoDistance(26), HUZSCREEN_WIDTH - 2 * AutoDistance(38), AutoDistance(17));
    [self.bgView addSubview:self.lab];
    
    self.btnOldEye = [[UIButton alloc] initWithImageNormal:@"ic_psd_hide" imageSeleted:@"ic_psd_nohide2"];
    self.btnOldEye.frame = CGRectMake(0, 0, AutoDistance(17), AutoDistance(17));
    self.btnOldEye.selected = NO;
    [self.btnOldEye addTarget:self action:@selector(setOldSecure) forControlEvents:UIControlEventTouchUpInside];
    
    self.tfOldPass = [ACFloatingTextField new];
    self.tfOldPass.placeholder = @"请输入旧密码";
    [self.tfOldPass setFont:FontS(FONT_15)];
    self.tfOldPass.delegate = self;
    self.tfOldPass.textColor = ColorS(COLOR_989898);
    self.tfOldPass.lineColor = ColorS(COLOR_C8C8C8);
    self.tfOldPass.rightView = self.btnOldEye;
    self.tfOldPass.secureTextEntry = YES;
    self.tfOldPass.rightViewMode = UITextFieldViewModeAlways;
    self.tfOldPass.selectedLineColor = ColorS(COLOR_C8C8C8);
    self.tfOldPass.keyboardType = UIKeyboardTypeDefault;
    [self.tfOldPass addTarget:self action:@selector(tfTextChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.btnNewEye = [[UIButton alloc] initWithImageNormal:@"ic_psd_hide" imageSeleted:@"ic_psd_nohide2"];
    self.btnNewEye.frame = CGRectMake(0, 0, AutoDistance(17), AutoDistance(17));
    self.btnNewEye.selected = NO;
    [self.btnNewEye addTarget:self action:@selector(setNewSecure) forControlEvents:UIControlEventTouchUpInside];
    
    self.tfNewPass = [ACFloatingTextField new];
    self.tfNewPass.placeholder = @"请输入新密码";
    [self.tfNewPass setFont:FontS(FONT_15)];
    self.tfNewPass.delegate = self;
    self.tfNewPass.textColor = ColorS(COLOR_989898);
    self.tfNewPass.lineColor = ColorS(COLOR_C8C8C8);
    self.tfNewPass.rightView = self.btnNewEye;
    self.tfNewPass.secureTextEntry = YES;
    self.tfNewPass.rightViewMode = UITextFieldViewModeAlways;
    self.tfNewPass.selectedLineColor = ColorS(COLOR_C8C8C8);
    self.tfNewPass.keyboardType = UIKeyboardTypeDefault;
    [self.tfNewPass addTarget:self action:@selector(tfTextChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.btnForget = [[UIButton alloc] initWithTitle:@"忘记密码?" textColor:ColorS(COLOR_ffffff) autoTextFont:FontS(FONT_12)];
    [self.btnForget setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    
    self.btnNext = [[UIButton alloc] initWithNormalColor:ColorS(COLOR_989898) selectColor:ColorS(COLOR_2E86FF)];
    [self.btnNext setTitle:@"确定" forState:UIControlStateNormal];
    self.btnNext.enabled = NO;
    [self.btnNext addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    ViewRadius(self.btnNext, AutoDistance(22));
    
    [self addSubview:self.tfOldPass];
    [self addSubview:self.tfNewPass];
    [self addSubview:self.btnForget];
    [self addSubview:self.btnNext];
    
    [self.tfOldPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lab.mas_bottom).offset(AutoDistance(32));
        make.left.mas_offset(AutoDistance(38));
        make.right.mas_offset(-AutoDistance(38));
        make.height.mas_equalTo(AutoDistance(44));
    }];
    
    [self.tfNewPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfOldPass.mas_bottom).offset(AutoDistance(60));
        make.left.mas_offset(AutoDistance(38));
        make.right.mas_offset(-AutoDistance(38));
        make.height.mas_equalTo(AutoDistance(44));
    }];
    
    [self.btnForget mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfNewPass.mas_bottom).offset(AutoDistance(12));
        make.right.mas_offset(-AutoDistance(38));
        make.size.mas_equalTo(CGSizeMake(100, 17));
    }];
    
    [self.btnNext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.tfNewPass.mas_bottom).offset(AutoDistance(82));
        make.size.mas_equalTo(CGSizeMake(HUZSCREEN_WIDTH- AutoDistance(76), AutoDistance(44)));
    }];
    
}

- (void)setOldSecure{
    self.btnOldEye.selected = !self.btnOldEye.selected;
    self.tfOldPass.secureTextEntry = self.btnOldEye.selected ? NO :YES;
}
- (void)setNewSecure{
    self.btnNewEye.selected = !self.btnNewEye.selected;
    self.tfNewPass.secureTextEntry = self.btnNewEye.selected ? NO :YES;
}

- (void)next {
    if (self.passBlock) {
        self.passBlock(self.tfOldPass.text, self.tfNewPass.text);
    }
}

- (void)tfTextChange:(UITextField *)textField{
    self.btnNext.enabled = (DRStringIsNotEmpty(self.tfOldPass.text) && DRStringIsNotEmpty(self.tfNewPass.text)) ? YES : NO;
}


@end

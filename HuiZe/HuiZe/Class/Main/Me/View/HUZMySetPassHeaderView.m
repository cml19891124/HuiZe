//
//  HUZMySetPassHeaderView.m
//  HuiZe
//
//  Created by mac on 2019/5/14.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZMySetPassHeaderView.h"

@interface HUZMySetPassHeaderView ()
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *lab;
@end

@implementation HUZMySetPassHeaderView

- (void)initView{
    
    self.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, AutoDistance(12), HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT - HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT - AutoDistance(12))];
    self.bgView.backgroundColor = COLOR_BG_WHITE;
    [self addSubview:self.bgView];
    
    self.lab = [[UILabel alloc] initWithTextColor:ColorS(COLOR_2E86FF) autoTextFont:FontS(FONT_12)];
    self.lab.text = @"设置密码后可以通过手机号 + 密码登录 慧择高考";
    self.lab.frame = CGRectMake(AutoDistance(38), AutoDistance(26), HUZSCREEN_WIDTH - 2 * AutoDistance(38), AutoDistance(17));
    [self.bgView addSubview:self.lab];
    
    self.btnEye = [[UIButton alloc] initWithImageNormal:@"ic_psd_hide" imageSeleted:@"ic_psd_nohide2"];
    self.btnEye.frame = CGRectMake(0, 0, AutoDistance(17), AutoDistance(17));
    self.btnEye.selected = NO;
    [self.btnEye addTarget:self action:@selector(setSecure) forControlEvents:UIControlEventTouchUpInside];
    
    self.tfPass = [ACFloatingTextField new];
    self.tfPass.placeholder = @"设置密码";
    [self.tfPass setFont:FontS(FONT_15)];
    self.tfPass.delegate = self;
    self.tfPass.textColor = ColorS(COLOR_989898);
    self.tfPass.lineColor = ColorS(COLOR_C8C8C8);
    self.tfPass.rightView = self.btnEye;
    self.tfPass.secureTextEntry = YES;
    self.tfPass.rightViewMode = UITextFieldViewModeAlways;
    self.tfPass.selectedLineColor = ColorS(COLOR_C8C8C8);
    self.tfPass.keyboardType = UIKeyboardTypeDefault;
    [self.tfPass addTarget:self action:@selector(tfTextChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    self.btnNext = [[UIButton alloc] initWithNormalColor:ColorS(COLOR_989898) selectColor:ColorS(COLOR_2E86FF)];
    [self.btnNext setTitle:@"确定" forState:UIControlStateNormal];
    self.btnNext.enabled = NO;
    [self.btnNext addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    ViewRadius(self.btnNext, AutoDistance(22));
    
    [self addSubview:self.tfPass];
    [self addSubview:self.btnNext];
    
    [self.tfPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lab.mas_bottom).offset(AutoDistance(32));
        make.left.mas_offset(AutoDistance(38));
        make.right.mas_offset(-AutoDistance(38));
        make.height.mas_equalTo(AutoDistance(44));
    }];
    
    
    [self.btnNext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.tfPass.mas_bottom).offset(AutoDistance(82));
        make.size.mas_equalTo(CGSizeMake(HUZSCREEN_WIDTH- AutoDistance(76), AutoDistance(44)));
    }];
    
}

- (void)setSecure{
    self.btnEye.selected = !self.btnEye.selected;
    self.tfPass.secureTextEntry = self.btnEye.selected ? NO :YES;
}

- (void)next {
    if (self.passBlock) {
        self.passBlock(self.tfPass.text);
    }
}

- (void)tfTextChange:(UITextField *)textField{
    self.btnNext.enabled = DRStringIsNotEmpty(self.tfPass.text) ? YES : NO;
}

@end

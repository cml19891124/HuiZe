//
//  HUZBindPhoneHeadView.m
//  HuiZe
//
//  Created by mac on 2019/5/6.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZBindPhoneHeadView.h"

@interface HUZBindPhoneHeadView ()
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *lab;
@property (nonatomic,strong) UILabel *phoneLab;
@end

@implementation HUZBindPhoneHeadView

- (void)initView{
    
    self.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, AutoDistance(12), HUZSCREEN_WIDTH, AutoDistance(58))];
    self.bgView.backgroundColor = COLOR_BG_WHITE;
    [self addSubview:self.bgView];
    
    self.lab = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_17)];
    self.lab.text = @"手机号";
    self.lab.frame = CGRectMake(AutoDistance(15), AutoDistance(17), AutoDistance(60), AutoDistance(24));
    [self.bgView addSubview:self.lab];
    
    self.phoneLab = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_15)];
    NSString *phone = HUZUserCenterManager.userModel.mobile;
    self.phoneLab.text = phone;
    self.phoneLab.textAlignment = NSTextAlignmentRight;
    self.phoneLab.frame = CGRectMake(HUZSCREEN_WIDTH - AutoDistance(125) - AutoDistance(15), AutoDistance(19), AutoDistance(125), AutoDistance(24));
    [self.bgView addSubview:self.phoneLab];

    self.btnConfirm = [[UIButton alloc] initWithTitle:@"更换手机号" textColor:ColorS(COLOR_ffffff) autoTextFont:FontS(FONT_17)];
    self.btnConfirm.backgroundColor = ColorS(COLOR_BG_2E86FF);
    self.btnConfirm.frame = CGRectMake(AutoDistance(15), CGRectGetMaxY(self.bgView.frame) + AutoDistance(64), HUZSCREEN_WIDTH - 2 * AutoDistance(15), AutoDistance(44));
    ViewRadius(self.btnConfirm, AutoDistance(22));
    [self addSubview:self.btnConfirm];

}

@end

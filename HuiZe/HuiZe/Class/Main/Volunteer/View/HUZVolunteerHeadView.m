//
//  HUZVolunteerHeadView.m
//  HuiZe
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZVolunteerHeadView.h"

@implementation HUZVolunteerHeadView

- (void)initView{
    
    self.backgroundColor = ColorS(COLOR_BG_2E86FF);
    
    self.btnCheck = [[UIButton alloc]initWithTitle:@"查看我的成绩报告" textColor:[UIColor whiteColor] autoTextFont:FontS(FONT_14)];
    [self.btnCheck setImage:ImageNamed(@"ic_btn_report_check") forState:UIControlStateNormal];
    [self.btnCheck setImageEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 0)];
    [self.btnCheck addTarget:self action:@selector(reportTap) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btnCheck];
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    
    UIView *centerLine = [[UIView alloc]init];
    centerLine.backgroundColor = ColorS(COLOR_CFCFCF);
    [bottomView addSubview:centerLine];
    
    self.leftView = [[HUZTwoLabelSwipeView alloc]init];
    NSString *schoolNum = HUZUserCenterManager.userModel.schoolNum;
    NSString *majorNum = HUZUserCenterManager.userModel.majorNum;
    NSString *leftStr = [NSString stringWithFormat:@"%@个大学 %@个专业", DRStringIsNotEmpty(schoolNum) ? schoolNum : @"0", DRStringIsNotEmpty(majorNum) ? majorNum : @"0"];
    [self.leftView.labTop setText:leftStr afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        NSRange firstRange = [[mutableAttributedString string] rangeOfString:DRStringIsNotEmpty(schoolNum) ? schoolNum : @"0" options:NSCaseInsensitiveSearch];
        [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[ColorS(COLOR_2E86FF) CGColor] range:firstRange];
        NSRange secondRange = [[mutableAttributedString string] rangeOfString:DRStringIsNotEmpty(majorNum) ? majorNum : @"0" options:NSBackwardsSearch];
        [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[ColorS(COLOR_2E86FF) CGColor] range:secondRange];
        return mutableAttributedString;
    }];
    self.leftView.labBtom.text = @"我的备选";
    [bottomView addSubview:self.leftView];

    self.rightView = [[HUZTwoLabelSwipeView alloc]init];
    NSString *volunteerNum =  HUZUserCenterManager.userModel.volunteerNum;
    NSString *rightStr = [NSString stringWithFormat:@"创建%@", DRStringIsNotEmpty(volunteerNum) ? volunteerNum : @"0"];
    [self.rightView.labTop setText:rightStr afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        NSRange range = [[mutableAttributedString string] rangeOfString:DRStringIsNotEmpty(volunteerNum) ? volunteerNum : @"0" options:NSCaseInsensitiveSearch];
        [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[ColorS(COLOR_2E86FF) CGColor] range:range];
        return mutableAttributedString;
    }];
    self.rightView.labBtom.text = @"我的志愿表";
    [bottomView addSubview:self.rightView];

    [self.btnCheck mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(43));
        make.left.mas_offset(AutoDistance(24));
    }];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_offset(AutoDistance(80));
    }];
    
    [centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bottomView);
        make.top.mas_offset(AutoDistance(18));
        make.bottom.mas_offset(-AutoDistance(17));
        make.width.mas_equalTo(AutoDistance(1));
    }];
    
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.equalTo(bottomView);
        make.width.mas_equalTo(HUZSCREEN_WIDTH/2 - 5);
    }];
    
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.top.equalTo(bottomView);
        make.width.mas_equalTo(HUZSCREEN_WIDTH/2 - 5);
    }];
    
}

- (void)reportTap {
    if (_reportBlock) {
        _reportBlock();
    }
}

@end

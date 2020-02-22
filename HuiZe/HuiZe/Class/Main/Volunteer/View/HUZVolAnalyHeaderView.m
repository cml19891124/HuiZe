//
//  HUZVolAnalyHeaderView.m
//  HuiZe
//
//  Created by mac on 2019/5/5.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZVolAnalyHeaderView.h"

@implementation HUZVolAnalyHeaderView


- (void)initView {
    
    self.backgroundColor = COLOR_BG_WHITE;
    
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(148))];
    self.bgView.backgroundColor = ColorS(COLOR_BG_1ACD38);
    self.bgView.userInteractionEnabled = YES;
    [self addSubview:self.bgView];
    
    self.bBtn = [[UIButton alloc]initWithImage:ImageNamed(@"nav_back_white")];
    self.bBtn.frame = CGRectMake(AutoDistance(15), AutoDistance(44), AutoDistance(20), AutoDistance(15));
    [self.bgView addSubview:self.bBtn];
    
    self.rlab = [[UILabel alloc] initWithTextColor:COLOR_BG_WHITE autoTextFont:FontS(FONT_20)];
    self.rlab.frame = CGRectMake((HUZSCREEN_WIDTH - AutoDistance(100))/2, AutoDistance(76), AutoDistance(100), AutoDistance(28));
    self.rlab.text = @"合理";
    self.rlab.textAlignment = NSTextAlignmentCenter;
    [self.bgView addSubview:self.rlab];
    
    self.nlab = [[UILabel alloc] initWithTextColor:COLOR_BG_WHITE autoTextFont:FontS(FONT_12)];
    self.nlab.frame = CGRectMake(0, CGRectGetMaxY(self.rlab.frame) + AutoDistance(6),HUZSCREEN_WIDTH, AutoDistance(28));
    self.nlab.text = @"";
    self.nlab.textAlignment = NSTextAlignmentCenter;
    [self.bgView addSubview:self.nlab];

    CGFloat spacing = 8.0;
    
    self.errorBtn = [[UIButton alloc]initWithTitle:@"严重错误" textColor:ColorS(COLOR_848484) autoTextFont:FontS(FONT_12)];
    [self.errorBtn setImage:ImageNamed(@"ic_btn_error") forState:UIControlStateNormal];
    self.errorBtn.frame = CGRectMake(AutoDistance(15), CGRectGetMaxY(self.bgView.frame) + AutoDistance(13), AutoDistance(75), AutoDistance(17));
    self.errorBtn.imageEdgeInsets = UIEdgeInsetsMake(0.0,  -spacing , 0.0, 0.0);
    self.errorBtn.userInteractionEnabled = NO;
    [self addSubview:self.errorBtn];
    
    self.subjectBtn = [[UIButton alloc]initWithTitle:@"建议优化" textColor:ColorS(COLOR_848484) autoTextFont:FontS(FONT_12)];
    [self.subjectBtn setImage:ImageNamed(@"ic_btn_warming") forState:UIControlStateNormal];
    self.subjectBtn.frame = CGRectMake((HUZSCREEN_WIDTH -  AutoDistance(75))/2, CGRectGetMaxY(self.bgView.frame) + AutoDistance(13), AutoDistance(75), AutoDistance(17));
    self.subjectBtn.imageEdgeInsets = UIEdgeInsetsMake(0.0,  -spacing , 0.0, 0.0);
    self.subjectBtn.userInteractionEnabled = NO;
    [self addSubview:self.subjectBtn];
    
    self.fillBtn = [[UIButton alloc]initWithTitle:@"填报合理" textColor:ColorS(COLOR_848484) autoTextFont:FontS(FONT_12)];
    [self.fillBtn setImage:ImageNamed(@"ic_btn_fine") forState:UIControlStateNormal];
    self.fillBtn.frame = CGRectMake( HUZSCREEN_WIDTH - AutoDistance(75) - AutoDistance(15), CGRectGetMaxY(self.bgView.frame) + AutoDistance(13), AutoDistance(75), AutoDistance(17));
    self.fillBtn.imageEdgeInsets = UIEdgeInsetsMake(0.0,  -spacing , 0.0, 0.0);
    self.fillBtn.userInteractionEnabled = NO;
    [self addSubview:self.fillBtn];
    
    self.blab = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    self.blab.frame = CGRectMake((HUZSCREEN_WIDTH - AutoDistance(225))/2, CGRectGetMaxY(self.subjectBtn.frame) + AutoDistance(20), AutoDistance(225), AutoDistance(21));
    self.blab.text = @"以下从四个维度进行合理性分析";
    self.blab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.blab];
    
}


@end

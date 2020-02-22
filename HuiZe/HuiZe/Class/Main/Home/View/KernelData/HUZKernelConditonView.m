//
//  HUZKernelConditonView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/23.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZKernelConditonView.h"

@implementation HUZKernelConditonView

- (void)initView{
    
    self.btnYear = [[UIButton alloc] initWithTitle:@"2018年" textColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_14)];
    [self.btnYear setImage:ImageNamed(@"ic_pull_down2") forState:UIControlStateNormal];
    self.btnYear.frame = CGRectMake(AutoDistance(12), AutoDistance(15), AutoDistance(70), AutoDistance(20));
    self.btnYear.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    self.btnScore = [[UIButton alloc] initWithTitle:@"投档最低分位次" textColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_14)];
//    [self.btnScore setImage:ImageNamed(@"ic_pull_down2") forState:UIControlStateNormal];
    self.btnScore.frame = CGRectMake(HUZSCREEN_WIDTH-AutoDistance(135), AutoDistance(15), AutoDistance(120), AutoDistance(20));
    self.btnScore.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    [self addSubview:self.btnYear];
    [self addSubview:self.btnScore];

//    [self.btnYear LeftTitleRightImageWithSpace:AutoDistance(4)];
//    [self.btnScore LeftTitleRightImageWithSpace:AutoDistance(4)];
    
}

@end


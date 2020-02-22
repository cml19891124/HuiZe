//
//  HUZUniEnrollmentInfoFooterView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/25.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniEnrollmentInfoFooterView.h"

@implementation HUZUniEnrollmentInfoFooterView

- (void)initView{
    self.backgroundColor = COLOR_BG_WHITE;
    self.btnMore = [[UIButton alloc] initWithTitle:@"查看更多" textColor:ColorS(COLOR_2E86FF) autoTextFont:FontS(FONT_12)];
    [self.btnMore setImage:ImageNamed(@"ic_arrow_blue") forState:UIControlStateNormal];
    self.btnMore.frame = CGRectMake((HUZSCREEN_WIDTH - 80)/2.0, AutoDistance(10), AutoDistance(80), AutoDistance(17));
    [self addSubview:self.btnMore];
    [self.btnMore jk_setImagePosition:LXMImagePositionRight spacing:8];
    
    self.ivDiviceline = [[UIImageView alloc] initWithFrame:CGRectMake(0, AutoDistance(41), HUZSCREEN_WIDTH, AutoDistance(8))];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    [self addSubview:self.ivDiviceline];

}

@end

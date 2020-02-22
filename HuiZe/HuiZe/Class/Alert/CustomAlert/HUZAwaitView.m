//
//  HUZAwaitView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/28.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZAwaitView.h"

@implementation HUZAwaitView

- (void)initView{
    self.backgroundColor = COLOR_BG_WHITE;
    ViewRadius(self, AutoDistance(8));
    
    self.labTitle = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_17) textAlignment:NSTextAlignmentCenter];
    self.labTitle.text = @"\"敬请期待\"";
    self.labTitle.numberOfLines = 0;
    [self.labTitle sizeToFit];
    self.labTitle.frame = CGRectMake(0, AutoDistance(32), AutoDistance(278), AutoDistance(48));
    
    self.btnCancel = [[UIButton alloc] initWithTitle:@"取消" textColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_17)];
    self.btnCancel.frame = CGRectMake(0, AutoDistance(91), AutoDistance(139), AutoDistance(21));
    
    self.btnConfirm = [[UIButton alloc] initWithTitle:@"确定" textColor:ColorS(COLOR_2E86FF) autoTextFont:FontS(FONT_17)];
    self.btnConfirm.frame = CGRectMake(AutoDistance(139), AutoDistance(91), AutoDistance(139), AutoDistance(21));

    [self addSubview:self.labTitle];
    [self addSubview:self.btnCancel];
    [self addSubview:self.btnConfirm];
    
}

@end

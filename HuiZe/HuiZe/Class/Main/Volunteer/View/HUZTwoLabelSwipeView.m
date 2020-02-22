//
//  HUZTwoLabelSwipeView.m
//  HuiZe
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZTwoLabelSwipeView.h"

@implementation HUZTwoLabelSwipeView

- (void)initView{
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [self addGestureRecognizer:tap];
    
    self.labTop = [[TTTAttributedLabel alloc]initWithTextColor:ColorS(COLOR_414141) TextFont:FONT_14];
    self.labBtom = [[UILabel alloc]initWithTextColor:ColorS(COLOR_989898) TextFont:FONT_12];
    
    [self addSubview:self.labTop];
    [self addSubview:self.labBtom];

    [self.labTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(17));
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(AutoDistance(20));
    }];
    [self.labBtom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTop.mas_bottom).offset(AutoDistance(7));
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(AutoDistance(17));
    }];
    
}

- (void)tapClick:(UITapGestureRecognizer *)tap {
    if (_tapClick) {
        _tapClick();
    }
}
@end

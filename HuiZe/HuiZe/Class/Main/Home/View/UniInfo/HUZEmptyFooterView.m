//
//  HUZEmptyFooterView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/25.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZEmptyFooterView.h"

@implementation HUZEmptyFooterView

- (void)initView{
    self.backgroundColor = COLOR_BG_WHITE;
    
    self.ivDiviceline = [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    [self addSubview:self.ivDiviceline];
    
    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(AutoDistance(8));
    }];
}

@end


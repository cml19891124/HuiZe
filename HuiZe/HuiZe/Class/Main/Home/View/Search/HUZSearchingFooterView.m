//
//  HUZSearchingFooterView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/20.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZSearchingFooterView.h"

@implementation HUZSearchingFooterView

- (void)initView{
    self.btnMore = [UIButton new];
    [self.btnMore setTitle:@"查看更多的专业" forState:UIControlStateNormal];
    [self.btnMore setTitleColor:ColorS(COLOR_C8C8C8) forState:UIControlStateNormal];
    [self.btnMore.titleLabel setFont:FontS(FONT_14)];
    [self.btnMore setImage:ImageNamed(@"ic_more_arrow") forState:UIControlStateNormal];
    [self addSubview:self.btnMore];
    
    [self.btnMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(10));
        make.left.mas_offset(AutoDistance(25));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(125), AutoDistance(20)));
        
    }];
    [self.btnMore jk_setImagePosition:LXMImagePositionRight spacing:5];

}
@end

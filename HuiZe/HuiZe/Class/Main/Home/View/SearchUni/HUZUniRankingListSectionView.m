//
//  HUZUniRankingListSectionView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/24.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniRankingListSectionView.h"

@implementation HUZUniRankingListSectionView

- (void)initView{
    
    self.backgroundColor = COLOR_BG_WHITE;
    
    self.btnArea = [[UIButton alloc] initWithTitle:@"选择地区" textColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_14)];
    [self.btnArea setImage:ImageNamed(@"ic_pull_down2") forState:UIControlStateNormal];
    
    self.btnType = [[UIButton alloc] initWithTitle:@"学校类别" textColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_14)];
    [self.btnType setImage:ImageNamed(@"ic_pull_down2") forState:UIControlStateNormal];
    
    self.ivDiviceline = [UIImageView new];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    [self addSubview:self.btnArea];
    [self addSubview:self.btnType];
    [self addSubview:self.ivDiviceline];
    
    [self.btnArea mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(12));
        make.left.mas_offset(AutoDistance(15));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(70), AutoDistance(20)));
    }];
    
    [self.btnType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(12));
        make.right.mas_offset(-AutoDistance(12));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(AutoDistance(70)), AutoDistance(20)));
    }];
    
    [self.ivDiviceline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(AutoDistance(2));
    }];
    
    [self.btnArea jk_setImagePosition:LXMImagePositionRight spacing:0];
    [self.btnType jk_setImagePosition:LXMImagePositionRight spacing:0];
    
}

@end

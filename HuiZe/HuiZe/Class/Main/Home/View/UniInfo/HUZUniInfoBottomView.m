//
//  HUZUniInfoBottomView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/25.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniInfoBottomView.h"

@implementation HUZUniInfoBottomView

- (void)initView{
    
    self.backgroundColor = COLOR_BG_WHITE;
    
    self.btnShare = [[UIButton alloc] initWithTitle:@"分享" textColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_10)];
    self.btnShare.hidden = YES;
    [self.btnShare setImage:ImageNamed(@"btn_share_uni") forState:UIControlStateNormal];
    
    self.btnCollect = [[UIButton alloc] initWithTitle:@"关注" textColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_10)];
    [self.btnCollect setImage:ImageNamed(@"btn_collect_uni_normal") forState:UIControlStateNormal];
    [self.btnCollect setImage:ImageNamed(@"btn_collect_sel_normal") forState:UIControlStateSelected];
    
    [self addSubview:self.btnShare];
    [self addSubview:self.btnCollect];
    
    [self.btnShare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(AutoDistance(3));
        make.right.mas_offset(-AutoDistance(98));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(50), AutoDistance(45)));
    }];
    
    [self.btnCollect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(AutoDistance(3));
        make.right.mas_offset(-AutoDistance(19));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(50), AutoDistance(45)));
    }];
    
    [self.btnShare jk_setImagePosition:LXMImagePositionTop spacing:2];
    [self.btnCollect jk_setImagePosition:LXMImagePositionTop spacing:2];

}
@end

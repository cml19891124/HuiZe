//
//  HUZOpenAllFooterView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/28.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZOpenAllFooterView.h"

@implementation HUZOpenAllFooterView

- (void)initView{
    self.backgroundColor = COLOR_BG_WHITE;
    
    self.btnOpen = [[UIButton alloc] initWithImageNormal:@"ic_arrow_down" imageSeleted:@"ic_arrow_up"];;
    [self.btnOpen setTitle:@"展开全部" forState:UIControlStateNormal];
    [self.btnOpen setTitle:@"收起" forState:UIControlStateSelected];
    [self.btnOpen setTitleColor:ColorS(COLOR_2E86FF) forState:UIControlStateNormal];
    self.btnOpen.titleLabel.font = FontS(FONT_12);
    self.btnOpen.frame = CGRectMake((HUZSCREEN_WIDTH - 80)/2.0, AutoDistance(8), AutoDistance(80), AutoDistance(17));

    [self addSubview:self.btnOpen];
    
    [self.btnOpen jk_setImagePosition:LXMImagePositionRight spacing:8];
}

@end

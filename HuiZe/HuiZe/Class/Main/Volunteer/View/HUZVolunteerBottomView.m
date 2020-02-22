//
//  HUZVolunteerBottomView.m
//  HuiZe
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZVolunteerBottomView.h"

@implementation HUZVolunteerBottomView

- (void)initView {
    [self addSubview:self.viewBotm];
    [self addSubview:self.btnSelected];
}

- (UIView *)viewBotm {
    if (!_viewBotm) {
        _viewBotm = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(49))];
        _viewBotm.backgroundColor = ColorS(COLOR_2E86FF);
        [_viewBotm addSubview:self.btnSelected];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, 0.5)];
        lineView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
        [_viewBotm addSubview:lineView];
    }
    return _viewBotm;
}

- (UIButton *)btnSelected {
    if (!_btnSelected) {
        _btnSelected = [[UIButton alloc]initWithTitle:@"保存并审核" textColor:COLOR_BG_WHITE autoTextFont:FontS(FONT_17)];
        _btnSelected.frame = CGRectMake(( HUZSCREEN_WIDTH  - AutoDistance(150))/2, AutoDistance(10), AutoDistance(150), AutoDistance(24));
        _btnSelected.backgroundColor = [UIColor clearColor];
    }
    return _btnSelected;
}

@end

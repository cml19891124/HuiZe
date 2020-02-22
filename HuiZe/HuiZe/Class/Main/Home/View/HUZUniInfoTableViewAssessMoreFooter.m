//
//  HUZUniInfoTableViewAssessMoreFooter.m
//  HuiZe
//
//  Created by tbb on 2019/11/18.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZUniInfoTableViewAssessMoreFooter.h"

@implementation HUZUniInfoTableViewAssessMoreFooter

- (void)initView{
    self.backgroundColor = COLOR_BG_WHITE;
    self.btnMore = [[UIButton alloc] initWithTitle:@"展开更多" textColor:ColorS(COLOR_2E86FF) autoTextFont:FontS(FONT_12)];
    [self.btnMore setTitle:@"展开更多" forState:(UIControlStateNormal)];
    [self.btnMore setTitle:@"点击收起" forState:(UIControlStateSelected)];
    [self.btnMore setImage:ImageNamed(@"ic_arrow_more_down") forState:UIControlStateNormal];
    [self.btnMore setImage:ImageNamed(@"ic_arrow_more_up") forState:UIControlStateSelected];
    
    self.btnMore.frame = CGRectMake((HUZSCREEN_WIDTH - 80)/2.0, AutoDistance(10), AutoDistance(80), AutoDistance(17));
    [self addSubview:self.btnMore];
    [self.btnMore jk_setImagePosition:LXMImagePositionRight spacing:8];
    
    UIView *view = [UIView new];
    view.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(8);
    }];
}
@end

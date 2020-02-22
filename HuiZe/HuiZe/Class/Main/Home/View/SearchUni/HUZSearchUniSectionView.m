//
//  HUZSearchUniSectionView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/23.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZSearchUniSectionView.h"

//@interface HUZSearchUniSectionView ()

//@property (nonatomic,assign) CGFloat toLeft;

//@end

@implementation HUZSearchUniSectionView

//- (void)initView{
//    self.backgroundColor = COLOR_BG_WHITE;
//
//    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH - AutoDistance(31), AutoDistance(44))];
//    self.scrollView.backgroundColor = COLOR_BG_WHITE;
//    self.scrollView.showsVerticalScrollIndicator = NO;
//    self.scrollView.showsHorizontalScrollIndicator = NO;
//    [self addSubview:self.scrollView];
//
//    self.ivBg = [[UIView alloc] initWithFrame:CGRectMake(HUZSCREEN_WIDTH - AutoDistance(31), 0, AutoDistance(31), AutoDistance(44))];
//    self.ivBg.backgroundColor = COLOR_BG_WHITE;
//    [self addSubview:self.ivBg];
//
//    self.ivSearchConditon = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_search_condition")];
//    self.ivSearchConditon.frame = CGRectMake(5, 15, AutoDistance(12), AutoDistance(12));
//    [self.ivBg addSubview:self.ivSearchConditon];
//}
//
//- (void)setType:(HUZSearchUniType)type{
//    if (type == HUZSearchUniHot) {
//        self.scrollView.frame = CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(44));
//        self.ivBg.hidden = YES;
//    }
//}
//
//- (void)setDatas:(NSArray *)datas{
//    self.toLeft = AutoDistance(15);
//
//    for (int i = 0; i < datas.count; i ++) {
//        NSString *str = datas[i];
//        CGFloat btnW = [str jk_widthWithFont:FontS(FONT_14) constrainedToHeight:AutoDistance(20)];
//        CGFloat btnH = AutoDistance(26);
//        CGFloat space = AutoDistance(26);
//
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(self.toLeft, AutoDistance(9), btnW , btnH);
//        [btn setTitle:str forState:UIControlStateNormal];
//        [btn setTitleColor:ColorS(COLOR_989898) forState:UIControlStateNormal];
//        [btn.titleLabel setFont:FontS(FONT_14)];
//        [self.scrollView addSubview:btn];
//        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//
//        if (i == 0) {
//            [btn setTitleColor:ColorS(COLOR_2E86FF) forState:UIControlStateNormal];
//        }
//
//        self.toLeft = self.toLeft + btnW + space;
//    }
//
//    [self.scrollView setContentSize:CGSizeMake(self.toLeft , AutoDistance(44))];
//}
//
//- (void)btnClick:(UIButton *)sender{
//    for (UIButton *subview in self.scrollView.subviews) {
//        if ([subview isKindOfClass:[UIButton class]]) {
//            if (subview == sender) {
//                [subview setTitleColor:ColorS(COLOR_2E86FF) forState:UIControlStateNormal];
//            }else{
//                [subview setTitleColor:ColorS(COLOR_989898) forState:UIControlStateNormal];
//            }
//        }
//    }
//}

@end

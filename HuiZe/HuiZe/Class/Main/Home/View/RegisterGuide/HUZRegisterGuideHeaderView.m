//
//  HUZRegisterGuideHeaderView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/28.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZRegisterGuideHeaderView.h"

@implementation HUZRegisterGuideHeaderView

- (void)initView{
    
    self.bannerView = [[HUZHomeBannerView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(172)-AutoDistance(47))];
    
//    self.btnBd = [[UIButton alloc] initWithTitle:@"常识百科" textColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
//    self.btnBd.userInteractionEnabled = NO;
//    self.btnBd.backgroundColor = ColorS(COLOR_BG_D8D8D8);
//    self.btnBd.frame = CGRectMake(AutoDistance(15), AutoDistance(172), HUZSCREEN_WIDTH-AutoDistance(30), AutoDistance(47));
//    ViewRadius(self.btnBd, AutoDistance(8));
    
    [self addSubview:self.bannerView];
//    [self addSubview:self.btnBd];
}
@end

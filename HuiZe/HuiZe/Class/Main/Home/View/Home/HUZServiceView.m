//
//  HUZServiceView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/18.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZServiceView.h"

@implementation HUZServiceView

- (void)initView{
    self.ivBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (HUZSCREEN_WIDTH - 45)/2.0, (HUZSCREEN_WIDTH - 45)/2.0 * 0.455)];;
    
    self.labContent = [[UILabel alloc] initWithTextColor:ColorS(COLOR_ffffff) autoTextFont:FontS(FONT_14)];
    self.labContent.frame = CGRectMake(AutoDistance(17), AutoDistance(18), AutoDistance(86), AutoDistance(20));
    
    self.labDes = [[UILabel alloc] initWithTextColor:ColorS(COLOR_ffffff) autoTextFont:FontS(FONT_12)];
    self.labDes.frame = CGRectMake(AutoDistance(17), AutoDistance(40), AutoDistance(86), AutoDistance(17));
    
    self.ivLogo = [UIImageView new];
    self.ivLogo.frame = CGRectMake(AutoDistance(122), AutoDistance(32), AutoDistance(24), AutoDistance(25));
    
    self.labTitle = [[UILabel alloc] initWithTextColor:ColorS(COLOR_ffffff) autoTextFont:FontS(FONT_15)];
    self.labTitle.frame = CGRectMake(AutoDistance(24), AutoDistance(26), AutoDistance(100), AutoDistance(21));
    
    [self addSubview:self.ivBg];
    [self.ivBg addSubview:self.labContent];
    [self.ivBg addSubview:self.labDes];
    [self.ivBg addSubview:self.ivLogo];
    [self.ivBg addSubview:self.labTitle];

}



@end

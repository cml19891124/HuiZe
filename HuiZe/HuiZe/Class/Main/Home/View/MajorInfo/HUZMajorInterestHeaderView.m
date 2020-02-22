//
//  HUZMajorInterestHeaderView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/28.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZMajorInterestHeaderView.h"

@interface HUZMajorInterestHeaderView ()

@property (nonatomic,strong) UILabel *labInterest;
@end

@implementation HUZMajorInterestHeaderView

- (void)initView{
    self.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    self.labInterest = [[UILabel alloc] initWithTextColor:ColorS(COLOR_C8C8C8) autoTextFont:FontS(FONT_12) textAlignment:NSTextAlignmentCenter];
    self.labInterest.text = @"你可能感兴趣的专业";
    self.labInterest.frame = CGRectMake((HUZSCREEN_WIDTH-AutoDistance(120))/2.0, AutoDistance(10), AutoDistance(120), AutoDistance(17));
    [self addSubview:self.labInterest];
}

@end

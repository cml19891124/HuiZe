//
//  HUZVolSelHeaderView.m
//  HuiZe
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZVolSelHeaderView.h"

@implementation HUZVolSelHeaderView

- (void)initView{
    
    self.backgroundColor = COLOR_BG_WHITE;
    
    [UIView huz_bezierPathWithRoundedRect:self];
    
    self.leftbtn = [[UIButton alloc]initWithTitle:@"录取分数" textColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    self.leftbtn.frame = CGRectMake(AutoDistance(15), AutoDistance(6), AutoDistance(85), AutoDistance(20));
    [self.leftbtn setImage:ImageNamed(@"ic_btn_sort") forState:UIControlStateNormal];
    CGFloat spacing = 4.0;
    CGSize imageSize = self.leftbtn.imageView.frame.size;
    self.leftbtn.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, 0.0, imageSize.width + spacing);
    CGSize titleSize = self.leftbtn.titleLabel.frame.size;
    self.leftbtn.imageEdgeInsets = UIEdgeInsetsMake(0.0, titleSize.width + spacing, 0.0, - titleSize.width);
    [self.leftbtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [self addSubview:self.leftbtn];
    
    self.rightbtn = [[UIButton alloc]initWithTitle:@"筛选" textColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_15)];
    self.rightbtn.frame = CGRectMake(HUZSCREEN_WIDTH - AutoDistance(100) - AutoDistance(15), AutoDistance(6), AutoDistance(100), AutoDistance(20));
    [self.rightbtn setImage:ImageNamed(@"ic_btn_ld") forState:UIControlStateNormal];
    CGSize imageSize1 = self.rightbtn.imageView.frame.size;
    self.rightbtn.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize1.width, 0.0, imageSize1.width + spacing);
    CGSize titleSize1 = self.rightbtn.titleLabel.frame.size;
    self.rightbtn.imageEdgeInsets = UIEdgeInsetsMake(0.0, titleSize1.width + spacing, 0.0, - titleSize1.width);
    [self.rightbtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [self addSubview:self.rightbtn];
}

@end

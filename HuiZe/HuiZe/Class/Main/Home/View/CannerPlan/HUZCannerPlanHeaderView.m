//
//  HUZCannerPlanHeaderView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/28.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZCannerPlanHeaderView.h"

@interface HUZCannerPlanHeaderView ()

@property (nonatomic,strong) UIImageView *ivDiviceline1;
@property (nonatomic,strong) UILabel *labTitle;
@property (nonatomic,strong) UIImageView *ivDiviceline2;
@property (nonatomic,strong) UILabel *labContent;

@end

@implementation HUZCannerPlanHeaderView

- (void)initView{
    
    self.ivDiviceline1 = [UIImageView new];
    self.ivDiviceline1.backgroundColor = ColorS(COLOR_BG_979797);
    self.ivDiviceline2 = [UIImageView new];
    self.ivDiviceline2.backgroundColor = ColorS(COLOR_BG_979797);
    
    self.labTitle = [[UILabel alloc] initWithTextColor:ColorS(COLOR_9DA7B2) autoTextFont:FontS(FONT_17) textAlignment:NSTextAlignmentCenter];
    self.labTitle.text = @"找到真正合适自己的专业";
    
    self.ivDiviceline1 = [UIImageView new];
    self.ivDiviceline1.backgroundColor = ColorS(COLOR_BG_979797);
    
    self.labContent = [[UILabel alloc] initWithTextColor:ColorS(COLOR_848484) autoTextFont:FontS(FONT_12) numberOfLines:0];
    self.labContent.text = @"据统计、每年都有70%大学生后悔当初选择的志愿. 究其原因、是因为当初没有真正找到适合自己的专业. \n慧择云志愿联合国际权威评测机构、推出适用于选择专业的性格和兴趣测评、帮你从生涯规划的角度科学填志愿。";
    [self.labContent changeSpacewithLineSpace:AutoDistance(3) WordSpace:AutoDistance(1)];
    
    [self addSubview:self.ivDiviceline1];
    [self addSubview:self.ivDiviceline2];
    [self addSubview:self.labTitle];
    [self addSubview:self.labContent];
    
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(24));
        make.centerX.equalTo(self);
    }];
    
    [self.ivDiviceline1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.labTitle.mas_left).offset(-AutoDistance(7));
        make.centerY.equalTo(self.labTitle);
        make.size.mas_equalTo(CGSizeMake(AutoDistance(60), AutoDistance(1)));
    }];

    [self.ivDiviceline2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.labTitle.mas_right).offset(AutoDistance(7));
        make.left.mas_equalTo(self.labTitle.mas_right).mas_equalTo(AutoDistance(7));
        make.centerY.equalTo(self.labTitle);
        make.size.mas_equalTo(CGSizeMake(AutoDistance(60), AutoDistance(1)));
    }];
    
    [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTitle.mas_bottom).offset(AutoDistance(12));
        make.left.mas_offset(AutoDistance(15));
        make.right.mas_offset(-AutoDistance(15));
    }];
}

@end

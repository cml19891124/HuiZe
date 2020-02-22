//
//  HUZGradeCircleView.m
//  HuiZe
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZGradeCircleView.h"

@implementation HUZGradeCircleView

- (void)initView {
        
    self.progressView = [[ZZCircleProgress alloc] initWithFrame:CGRectZero pathBackColor:ColorS(COLOR_BG_D8D8D8) pathFillColor:ColorS(COLOR_BG_2E86FF) startAngle:0 strokeWidth:AutoDistance(4)];
    self.progressView.showPoint = NO;
    self.progressView.showProgressText = NO;
    self.progressView.progress = 0.88;
    
    self.labContent = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_10)];
    
    self.labDes = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12)];
    
    [self addSubview:self.labContent];
    [self addSubview:self.progressView];
    [self addSubview:self.labDes];

    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(AutoDistance(60), AutoDistance(60)));
    }];
    
    [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.progressView);
        make.height.mas_equalTo(AutoDistance(14));
    }];
   
    [self.labDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.progressView.mas_bottom).offset(AutoDistance(7));
        make.centerX.equalTo(self.progressView);
        make.height.mas_equalTo(AutoDistance(17));
    }];
}

@end

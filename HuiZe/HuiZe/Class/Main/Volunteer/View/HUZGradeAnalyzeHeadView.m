//
//  HUZGradeAnalyzeHeadView.m
//  HuiZe
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZGradeAnalyzeHeadView.h"

@implementation HUZGradeAnalyzeHeadView

- (void)initView{
    
    self.gkInfoView = [HUZGradeSegmentInfoView new];
    [self addSubview:self.gkInfoView];
    
    [self.gkInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(14));
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(HUZSCREEN_WIDTH - AutoDistance(30), AutoDistance(121)));
    }];
    
    
    self.gradeView = [HUZGradeDetailAnalyzeView new];
    [self addSubview:self.gradeView];

    [self.gradeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.gkInfoView.mas_bottom).offset(AutoDistance(18));
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(HUZSCREEN_WIDTH - AutoDistance(30), AutoDistance(1000)));
    }];
}

- (void)setModel:(HUZGradeAnalyzeModel *)model {
    self.gradeView.schoolView.model = model;
    self.gradeView.professView.model = model;
    self.gradeView.cityView.model = model;
}
@end

//
//  HUZGradeDetailAnalyzeView.m
//  HuiZe
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZGradeDetailAnalyzeView.h"

@implementation HUZGradeDetailAnalyzeView

- (void)initView{
    
    self.backgroundColor = COLOR_BG_WHITE;
    ViewRadius(self, AutoDistance(12));
    
    self.topView = [[HUZTwoLabelSwipeView alloc]init];
    self.topView.labTop.text = @"相近成绩考生去向";
    self.topView.labBtom.text = @"";
    [self addSubview:self.topView];
    
    self.schoolView = [[HUZGradeDetailSchoolView alloc]init];
    [self addSubview:self.schoolView];
    
    self.professView = [[HUZGradeDetailProfessView alloc]init];
    [self addSubview:self.professView];
    
    self.cityView = [[HUZGradeDeatilCityView alloc]init];
    [self addSubview:self.cityView];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.height.mas_equalTo(AutoDistance(40));
    }];
    
    [self.schoolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.equalTo(self.topView.mas_bottom).offset(AutoDistance(20));
        make.height.mas_equalTo(AutoDistance(275));
    }];
    [self.professView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.equalTo(self.schoolView.mas_bottom).offset(AutoDistance(30));
        make.height.equalTo(self.schoolView);
    }];
    
    [self.cityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.equalTo(self.professView.mas_bottom).offset(AutoDistance(30));
        make.height.equalTo(self.schoolView);
    }];
}

@end

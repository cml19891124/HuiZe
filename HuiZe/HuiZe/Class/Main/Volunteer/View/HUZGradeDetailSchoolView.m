//
//  HUZGradeDetailSchoolView.m
//  HuiZe
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZGradeDetailSchoolView.h"

@implementation HUZGradeDetailSchoolView

- (void)initView{
    
    self.backgroundColor = COLOR_BG_WHITE;
    ViewRadius(self, AutoDistance(12));
    
    self.labTop = [[UILabel alloc]init];
    self.labTop.textColor = ColorS(COLOR_848484);
    self.labTop.font = FontS(FONT_12);
    self.labTop.text = @"录取人数最多的5所学校";
    [self addSubview:self.labTop];
    
    self.circleView1 = [HUZGradeCircleView new];
    self.circleView1.labContent.text = @"210";
    self.circleView1.labDes.text = @"河北工业大学";
    [self addSubview:self.circleView1];
    
    self.circleView2 = [HUZGradeCircleView new];
    self.circleView2.labContent.text = @"210";
    self.circleView2.labDes.text = @"燕山大学";
    [self addSubview:self.circleView2];
    
    self.circleView3 = [HUZGradeCircleView new];
    self.circleView3.labContent.text = @"210";
    self.circleView3.labDes.text = @"郑州大学";
    [self addSubview:self.circleView3];
    
    self.circleView4 = [HUZGradeCircleView new];
    self.circleView4.labContent.text = @"210";
    self.circleView4.labDes.text = @"太原理工大学";
    [self addSubview:self.circleView4];
    
    self.circleView5 = [HUZGradeCircleView new];
    self.circleView5.labContent.text = @"210";
    self.circleView5.labDes.text = @"东北大学";
    [self addSubview:self.circleView5];
    
    [self.labTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(AutoDistance(17));
    }];
    
    [self.circleView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTop.mas_bottom).offset(AutoDistance(30));
        make.left.mas_offset(AutoDistance(74));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(60), AutoDistance(85)));
    }];
    
    [self.circleView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTop.mas_bottom).offset(AutoDistance(30));
        make.right.mas_offset(-AutoDistance(74));
        make.size.equalTo(self.circleView1);
    }];
    
    [self.circleView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.circleView1.mas_bottom).offset(AutoDistance(30));
        make.left.mas_offset(AutoDistance(30));
        make.size.equalTo(self.circleView1);
    }];
    
    [self.circleView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.circleView1.mas_bottom).offset(AutoDistance(30));
        make.centerX.equalTo(self);
        make.size.equalTo(self.circleView1);
    }];
    
    [self.circleView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.circleView2.mas_bottom).offset(AutoDistance(30));
        make.right.mas_offset(-AutoDistance(30));
        make.size.equalTo(self.circleView1);
    }];
}

- (void)setModel:(HUZGradeAnalyzeModel *)model {
    self.circleView1.labContent.text = model.data.admissionDetailsEntities[0].admissionNum;
    self.circleView1.labDes.text =  model.data.admissionDetailsEntities[0].universityEntity.schoolName;
    self.circleView2.labContent.text = model.data.admissionDetailsEntities[1].admissionNum;
    self.circleView2.labDes.text = model.data.admissionDetailsEntities[1].universityEntity.schoolName;
    self.circleView3.labContent.text = model.data.admissionDetailsEntities[2].admissionNum;
    self.circleView3.labDes.text = model.data.admissionDetailsEntities[2].universityEntity.schoolName;
    self.circleView4.labContent.text = model.data.admissionDetailsEntities[3].admissionNum;
    self.circleView4.labDes.text = model.data.admissionDetailsEntities[3].universityEntity.schoolName;
    self.circleView5.labContent.text = model.data.admissionDetailsEntities[4].admissionNum;
    self.circleView5.labDes.text = model.data.admissionDetailsEntities[4].universityEntity.schoolName;
}
@end

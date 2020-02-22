//
//  HUZWriteInfoHeaderView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/22.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZWriteInfoHeaderView.h"

@implementation HUZWriteInfoHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
    
    self.labTitle1 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_15)];
    
    self.labTitle2 = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_15)];

    [self addSubview:self.labTitle1];
    [self addSubview:self.labTitle2];
    
    [self.labTitle1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(AutoDistance(38));
        make.top.mas_offset(AutoDistance(14));
    }];
    
    [self.labTitle2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(AutoDistance(209));
        make.top.mas_offset(AutoDistance(14));
    }];
    
}

- (void)setIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        self.labTitle1.text = @"你的角色";
        self.labTitle2.text = @"";
    }
    
    else if (indexPath.section == 1){
        self.labTitle1.text = @"高考省份  不可修改";
        [self.labTitle1 addAttributestring:self.labTitle1.text font:FontS(FONT_12) color:ColorS(COLOR_FF0000) range:NSMakeRange(6, 4)];
        self.labTitle2.text = @"高考年份  不可修改";
        [self.labTitle2 addAttributestring:self.labTitle2.text font:FontS(FONT_12) color:ColorS(COLOR_FF0000) range:NSMakeRange(6, 4)];
    }
    
    else if (indexPath.section == 2){
        self.labTitle1.text = @"选择科目  不可修改";
        [self.labTitle1 addAttributestring:self.labTitle1.text font:FontS(FONT_12) color:ColorS(COLOR_FF0000) range:NSMakeRange(6, 4)];
        self.labTitle2.text = @"";
    }
    
    else{
        self.labTitle1.text = @"高考成绩预估分数";
        self.labTitle2.text = @"高考排名";
    }
}

@end

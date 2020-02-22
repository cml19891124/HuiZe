//
//  HUZCurrentStudentsPlanSectionView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/23.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZCurrentStudentsPlanSectionView.h"

@implementation HUZCurrentStudentsPlanSectionView

- (void)initView{
    
    self.backgroundColor = COLOR_BG_WHITE;
    
    self.btnBatch = [[UIButton alloc] initWithTitle:@"" textColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_14)];
    [self.btnBatch setImage:ImageNamed(@"ic_pull_down2") forState:UIControlStateNormal];
    self.btnBatch.frame = CGRectMake(AutoDistance(12), AutoDistance(15), AutoDistance(100), AutoDistance(20));
    
    self.btnType = [[UIButton alloc] initWithTitle:@"" textColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_14)];
    [self.btnType setImage:ImageNamed(@"ic_pull_down2") forState:UIControlStateNormal];
    self.btnType.frame = CGRectMake(HUZSCREEN_WIDTH-AutoDistance(55)/2.0, AutoDistance(12), AutoDistance(55), AutoDistance(20));
    
    self.btnSubjectType = [[UIButton alloc] initWithTitle:@"" textColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_14)];
    [self.btnSubjectType setImage:ImageNamed(@"ic_pull_down2") forState:UIControlStateNormal];
    self.btnSubjectType.frame = CGRectMake(HUZSCREEN_WIDTH-AutoDistance(62), AutoDistance(12), AutoDistance(50), AutoDistance(20));
    
    [self addSubview:self.btnBatch];
    [self addSubview:self.btnType];
    [self addSubview:self.btnSubjectType];
    self.btnType.hidden = YES;
}

- (void)setBatch:(NSString *)batch{
    CGFloat W = [batch jk_widthWithFont:FontS(FONT_14) constrainedToHeight:AutoDistance(20)];
    self.btnBatch.frame = CGRectMake(AutoDistance(12), AutoDistance(12), W + AutoDistance(20), AutoDistance(20));
    [self.btnBatch setTitle:batch forState:UIControlStateNormal];
    [self.btnBatch LeftTitleRightImageWithSpace:AutoDistance(4)];
}

- (void)setType:(NSString *)type{
    CGFloat W = [type jk_widthWithFont:FontS(FONT_14) constrainedToHeight:AutoDistance(20)];
    CGFloat btnW = W + AutoDistance(20);
    self.btnType.frame = CGRectMake((HUZSCREEN_WIDTH-btnW)/2.0, AutoDistance(12), btnW, AutoDistance(20));
    [self.btnType setTitle:type forState:UIControlStateNormal];
    [self.btnType LeftTitleRightImageWithSpace:AutoDistance(4)];
}

- (void)setSubject:(NSString *)subject{
    CGFloat W = [subject jk_widthWithFont:FontS(FONT_14) constrainedToHeight:AutoDistance(20)];
    CGFloat btnW = W + AutoDistance(20);
    self.btnSubjectType.frame = CGRectMake(HUZSCREEN_WIDTH-AutoDistance(15)-btnW, AutoDistance(12), btnW, AutoDistance(20));
    [self.btnSubjectType setTitle:subject forState:UIControlStateNormal];
    [self.btnSubjectType LeftTitleRightImageWithSpace:AutoDistance(4)];
}

@end

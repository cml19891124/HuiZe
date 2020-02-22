//
//  HUZUniEnrollmentInfoSectionView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/25.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniEnrollmentInfoSectionView.h"

@implementation HUZUniEnrollmentInfoSectionView

- (void)initView{
    
    self.backgroundColor = COLOR_BG_WHITE;
    
    self.labTitle = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:BoldFontS(FONT_15)];
    self.labTitle.frame = CGRectMake(AutoDistance(15), AutoDistance(15), AutoDistance(200), AutoDistance(20));
    
    self.ivBatch = [HUZChooseTypeView new];
    self.ivBatch.labContent.text = @"本科第一批";
    self.ivBatch.frame = CGRectMake(AutoDistance(8), AutoDistance(50), AutoDistance(90), AutoDistance(20));

    self.ivScore = [HUZChooseTypeView new];
    self.ivScore.labContent.text = @"录取最低分";
    self.ivScore.frame = CGRectMake((HUZSCREEN_WIDTH-AutoDistance(90))/2.0, AutoDistance(50), AutoDistance(90), AutoDistance(20));
    
    self.ivSubject = [HUZChooseTypeView new];
    self.ivSubject.labContent.text = @"理科";
    self.ivSubject.frame = CGRectMake(HUZSCREEN_WIDTH-AutoDistance(70), AutoDistance(50), AutoDistance(45), AutoDistance(20));
    
    [self addSubview:self.labTitle];
    [self addSubview:self.ivBatch];
    [self addSubview:self.ivScore];
    [self addSubview:self.ivSubject];

}

- (void)setType:(HUZUniEnrollmentInfoType)type{
    if (type == HUZUniEnrollmentInfoRegulation) {
        self.ivBatch.hidden = YES;
        self.ivScore.hidden = YES;
        self.ivSubject.hidden = YES;
    }else if (type == HUZUniEnrollmentInfoPlan){
        self.ivBatch.hidden = NO;
        self.ivScore.hidden = NO;
        self.ivSubject.hidden = NO;
    }else{
        self.ivBatch.hidden = NO;
        self.ivScore.hidden = NO;
        self.ivSubject.hidden = NO;
        self.ivBatch.labContent.text = @"2018";
        self.ivScore.labContent.text = @"河北";
        self.ivSubject.labContent.text = @"理科";
        self.ivBatch.frame = CGRectMake(AutoDistance(8), AutoDistance(50), AutoDistance(50), AutoDistance(20));

    }
}


@end

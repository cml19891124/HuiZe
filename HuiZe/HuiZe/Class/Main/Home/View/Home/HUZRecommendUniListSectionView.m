//
//  HUZRecommendUniListSectionView.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/14.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZRecommendUniListSectionView.h"

@implementation HUZRecommendUniListSectionView

- (void)initView{
    
    self.backgroundColor = COLOR_BG_WHITE;
    
    self.btnBatch = [[UIButton alloc] initWithTitle:@"批次" textColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_14)];
    [self.btnBatch setImage:ImageNamed(@"ic_pull_down2") forState:UIControlStateNormal];
    self.btnBatch.frame = CGRectMake(AutoDistance(12), AutoDistance(15), AutoDistance(60), AutoDistance(20));
    
    self.btnType = [[UIButton alloc] initWithTitle:@"学校层次" textColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_14)];
    [self.btnType setImage:ImageNamed(@"ic_pull_down2") forState:UIControlStateNormal];
    self.btnType.frame = CGRectMake(HUZSCREEN_WIDTH-AutoDistance(115), AutoDistance(12), AutoDistance(100), AutoDistance(20));
    
    [self addSubview:self.btnBatch];
    [self addSubview:self.btnType];
    
    [self.btnBatch LeftTitleRightImageWithSpace:AutoDistance(4)];
    [self.btnType LeftTitleRightImageWithSpace:AutoDistance(4)];

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
    self.btnType.frame = CGRectMake(HUZSCREEN_WIDTH-btnW-AutoDistance(15), AutoDistance(12), btnW, AutoDistance(20));
    [self.btnType setTitle:type forState:UIControlStateNormal];
    [self.btnType LeftTitleRightImageWithSpace:AutoDistance(4)];
}

@end

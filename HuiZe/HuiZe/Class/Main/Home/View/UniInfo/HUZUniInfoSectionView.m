//
//  HUZUniInfoSectionView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/24.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniInfoSectionView.h"

@implementation HUZUniInfoSectionView

- (void)initView{
    self.backgroundColor = COLOR_BG_WHITE;
    
    self.labSection = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:BoldFontS(FONT_15)];
    self.labSection.frame = CGRectMake(AutoDistance(15), AutoDistance(15), AutoDistance(200), AutoDistance(21));
    [self addSubview:self.labSection];
}

@end

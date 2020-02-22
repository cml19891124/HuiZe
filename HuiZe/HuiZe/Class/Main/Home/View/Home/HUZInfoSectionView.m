//
//  HUZInfoSectionView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/19.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZInfoSectionView.h"

@implementation HUZInfoSectionView

- (void)initView{
    
    self.datas = [NSArray new];
    self.datas = @[@"热门推荐",@"独家解析",@"资讯头条",@"报考指南",@"备考经验",@"大学导航"];
    
    self.backgroundColor = COLOR_BG_WHITE;
    self.labgkInfo = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_17)];
    self.labgkInfo.frame = CGRectMake(15, 12, 100, 24);
    self.labgkInfo.text = @"高考资讯";
    [self addSubview:self.labgkInfo];
    
}

- (void)setDatas:(NSArray *)datas{
    _datas = datas;
}

@end

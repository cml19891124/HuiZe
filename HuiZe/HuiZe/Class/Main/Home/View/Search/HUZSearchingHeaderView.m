//
//  HUZSearchingHeaderView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/20.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZSearchingHeaderView.h"

@implementation HUZSearchingHeaderView

- (void)initView{
    self.labTitle = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_12)];
    self.labTitle.frame = CGRectMake(AutoDistance(27), AutoDistance(24), AutoDistance(200), AutoDistance(17));
    [self addSubview:self.labTitle];
}

@end

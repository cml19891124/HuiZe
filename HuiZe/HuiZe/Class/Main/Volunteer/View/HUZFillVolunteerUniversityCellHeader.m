//
//  HUZFillVolunteerUniversityCellHeader.m
//  HuiZe
//
//  Created by tbb on 2019/10/29.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZFillVolunteerUniversityCellHeader.h"
#import "HUZFillVolunteerUniversityCellFooter.h"
@implementation HUZFillVolunteerUniversityCellHeader
- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    self.backgroundColor = ColorS(COLOR_BG_F6F6F6);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

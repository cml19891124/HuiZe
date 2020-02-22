//
//  HUZFillVolunteerAddSchoolCell.m
//  HuiZe
//
//  Created by tbb on 2019/10/28.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZFillVolunteerAddSchoolCell.h"

@implementation HUZFillVolunteerAddSchoolCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    self.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

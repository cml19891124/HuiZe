//
//  HUZUniInfoCommonTextCell.m
//  HuiZe
//
//  Created by tbb on 2019/9/6.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZUniInfoCommonTextCell.h"

@implementation HUZUniInfoCommonTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.leftConst.constant = AutoDistance(15);
    self.rightConst.constant = AutoDistance(15);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  HUZFillVolunteerBatchCell.m
//  HuiZe
//
//  Created by tbb on 2019/10/28.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZFillVolunteerBatchCell.h"

@implementation HUZFillVolunteerBatchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.showBtn setImage:[UIImage imageNamed:@"ic_btn_top"] forState:(UIControlStateSelected)];
    [self.showBtn setImage:[UIImage imageNamed:@"ic_btn_down"] forState:(UIControlStateNormal)];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

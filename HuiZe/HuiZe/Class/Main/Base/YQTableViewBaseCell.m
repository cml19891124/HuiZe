//
//  YQTableViewBaseCell.m
//  Pension
//
//  Created by tbb on 2019/5/28.
//  Copyright © 2019  YIQI. All rights reserved.
//

#import "YQTableViewBaseCell.h"

@implementation YQTableViewBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.contentView.backgroundColor = UIColor.whiteColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

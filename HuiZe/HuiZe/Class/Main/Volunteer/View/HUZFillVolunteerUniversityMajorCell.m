//
//  HUZFillVolunteerUniversityMajorCell.m
//  HuiZe
//
//  Created by tbb on 2019/10/29.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZFillVolunteerUniversityMajorCell.h"
#import "HUZUniInfoGeneralizeModel.h"
@implementation HUZFillVolunteerUniversityMajorCell
-(void)setMajorModel:(HUZUniInfoGeneralizeMajorModel *)majorModel {
    _majorModel = majorModel;
    self.contentLb.attributedText = majorModel.showMajIntroduceAttributed;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

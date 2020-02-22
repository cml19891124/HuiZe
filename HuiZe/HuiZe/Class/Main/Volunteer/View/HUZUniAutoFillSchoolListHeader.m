//
//  HUZUniAutoFillSchoolListHeader.m
//  HuiZe
//
//  Created by tbb on 2019/11/20.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZUniAutoFillSchoolListHeader.h"
#import "HUZUniAutoFillSchoolListModel.h"
@implementation HUZUniAutoFillSchoolListHeader

-(void)setSchoolModel:(HUZUniAutoFillSchoolListModel *)schoolModel {
    _schoolModel = schoolModel;
    [self.logoIcon sd_setImageWithURL:[NSURL URLWithString:schoolModel.logoUrl]];
    self.nameLb.text = schoolModel.yuanxiaomingcheng;
    self.cityLb.text = schoolModel.uniCity;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.logoIcon.layer.cornerRadius = 12.5;
}

@end

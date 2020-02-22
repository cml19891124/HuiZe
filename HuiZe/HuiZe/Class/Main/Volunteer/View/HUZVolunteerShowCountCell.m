//
//  HUZVolunteerShowCountCell.m
//  HuiZe
//
//  Created by tbb on 2019/9/9.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZVolunteerShowCountCell.h"
#import "HUZUser.h"
@implementation HUZVolunteerShowCountCell
-(void)setUserModel:(HUZUser *)userModel {
    _userModel = userModel;
    NSString *schoolNum = userModel.schoolNum;
    NSString *majorNum = userModel.majorNum;
    NSString *leftStr = [NSString stringWithFormat:@"%@个大学 %@个专业", DRStringIsNotEmpty(schoolNum) ? schoolNum : @"0", DRStringIsNotEmpty(majorNum) ? majorNum : @"0"];
    self.leftCountLb.text = leftStr;
    
    
    NSString *volunteerNum =  HUZUserCenterManager.userModel.volunteerNum;
    NSString *rightStr = [NSString stringWithFormat:@"创建%@", DRStringIsNotEmpty(volunteerNum) ? volunteerNum : @"0"];
    self.rightCountLb.text = rightStr;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  HUZVolunteerShowCountCell.h
//  HuiZe
//
//  Created by tbb on 2019/9/9.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HUZTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN
@class HUZUser;
@interface HUZVolunteerShowCountCell : HUZTableViewCell
@property (weak, nonatomic) IBOutlet UIView *leftBgView;
@property (weak, nonatomic) IBOutlet UIView *rightBgView;
@property (weak, nonatomic) IBOutlet UILabel *leftCountLb;
@property (weak, nonatomic) IBOutlet UILabel *leftTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *rightCountLb;
@property (weak, nonatomic) IBOutlet UILabel *rightTitleLb;
@property (nonatomic, strong) HUZUser * userModel;
@end

NS_ASSUME_NONNULL_END

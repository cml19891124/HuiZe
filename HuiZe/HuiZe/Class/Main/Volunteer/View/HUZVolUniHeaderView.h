//
//  HUZVolUniHeaderView.h
//  HuiZe
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZView.h"

NS_ASSUME_NONNULL_BEGIN
@class HUZSchoolModel;
@interface HUZVolUniHeaderView : HUZView
@property (nonatomic, strong) HUZSchoolModel * schoolModel;
@property (nonatomic,strong) UIButton *dBtn;
@end

NS_ASSUME_NONNULL_END

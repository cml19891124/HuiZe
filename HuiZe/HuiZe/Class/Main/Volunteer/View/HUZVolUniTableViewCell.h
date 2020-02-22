//
//  HUZVolUniTableViewCell.h
//  HuiZe
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@class HUZUniInfoGeneralizeMajorModel;
typedef void(^DelBlock)(void);
@interface HUZVolUniTableViewCell : HUZTableViewCell
@property (nonatomic,copy) DelBlock delBlock;
@property (nonatomic, strong) HUZUniInfoGeneralizeMajorModel * majorModel;
@property (nonatomic,strong) UIButton *dBtn;
@end

NS_ASSUME_NONNULL_END

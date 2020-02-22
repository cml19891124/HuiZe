//
//  HUZPPPSelectCell.h
//  HuiZe
//
//  Created by mac on 2019/4/27.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZTableViewCell.h"
#import "HUZPPPModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZPPPSelectCell : HUZTableViewCell
@property (strong, nonatomic) UILabel *titleLab;
@property (strong, nonatomic) UIButton *selectBtn;
@property (strong, nonatomic) HUZPPPModel *model;
@end

NS_ASSUME_NONNULL_END

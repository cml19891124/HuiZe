//
//  HUZUniInfoCommonCell.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/24.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@class HUZMajorInfoModel;
@interface HUZUniInfoCommonCell : HUZTableViewCell

@property (nonatomic,strong) UILabel *labContent;
@property (nonatomic,strong) UILabel *labDes;
@property (nonatomic,strong) UIImageView *ivArrow;
@property (nonatomic,strong) UIImageView *ivDiviceline;

@property (nonatomic, strong) HUZMajorInfoModel * infoModel;
@end

NS_ASSUME_NONNULL_END

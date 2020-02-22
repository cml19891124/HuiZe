//
//  HUZUniEnrollmentInfoMajorCell.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/25.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@class HUZUniEnrollmentInfoModel;
@interface HUZUniEnrollmentInfoMajorCell : HUZTableViewCell

@property (nonatomic,strong) UILabel *labMajor;
@property (nonatomic,strong) UILabel *labDes;
@property (nonatomic,strong) UIImageView *ivArrow;
@property (nonatomic,strong) UIImageView *ivDiviceline;


@property (nonatomic, strong) HUZUniEnrollmentInfoModel * infoModel;

@end

NS_ASSUME_NONNULL_END

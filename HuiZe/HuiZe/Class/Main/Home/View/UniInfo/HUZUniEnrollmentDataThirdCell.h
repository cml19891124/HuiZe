//
//  HUZUniEnrollmentDataThirdCell.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/25.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@class HUZUniInfoGeneralizeMajorModel;
@interface HUZUniEnrollmentDataThirdCell : HUZTableViewCell

@property (nonatomic,strong) UILabel *labMajor;
@property (nonatomic,strong) UILabel *labDes1;
@property (nonatomic,strong) UILabel *labDes2;
@property (nonatomic,strong) UILabel *labDes3;
@property (nonatomic,strong) UIImageView *ivArrow;
@property (nonatomic,strong) UIImageView *ivDiviceline;
@property (nonatomic, strong) HUZUniInfoGeneralizeMajorModel * majorModel;
@end

NS_ASSUME_NONNULL_END

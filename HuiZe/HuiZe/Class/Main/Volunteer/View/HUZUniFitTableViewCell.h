//
//  HUZUniFitTableViewCell.h
//  HuiZe
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZTableViewCell.h"

#import "HUZVolunteerFillDataModel.h"

NS_ASSUME_NONNULL_BEGIN
@class HUZRecommendUniDataModel;
@interface HUZUniFitTableViewCell : HUZTableViewCell
@property (nonatomic,strong) UIImageView *ivLogo;
@property (nonatomic,strong) UILabel *labSchool;
@property (nonatomic,strong) UILabel *labMajor;
@property (nonatomic,strong) UILabel *labDes1;
@property (nonatomic,strong) UILabel *labDes2;
@property (nonatomic,strong) UILabel *labDes3;
@property (nonatomic,strong) UILabel *labDes4;
@property (nonatomic,strong) UIImageView *ivDiviceline;

@property (strong, nonatomic) HUZVolunteerFillModel *model;

@property (nonatomic, strong) HUZRecommendUniDataModel * recommendModel;
@end

NS_ASSUME_NONNULL_END

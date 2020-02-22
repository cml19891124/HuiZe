//
//  HUZUniMajorCell.h
//  HuiZe
//
//  Created by mac on 2019/5/5.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@class HUZDetailDataVolunteerSchoolEntityModel;
@interface HUZUniMajorCell : HUZTableViewCell
@property (nonatomic,strong) UILabel *iLab;
@property (nonatomic,strong) UIImageView *ivLogo;
@property (nonatomic,strong) UILabel *labSchool;
@property (nonatomic,strong) UILabel *labCity;
@property (nonatomic,strong) UILabel *labDes1;
@property (nonatomic,strong) UILabel *labDes2;
@property (nonatomic,strong) UILabel *labDes3;
@property (nonatomic,strong) UILabel *labDes4;
@property (nonatomic,strong) UILabel *labDes5;
@property (nonatomic,strong) UILabel *labDes6;

@property (nonatomic, strong) HUZDetailDataVolunteerSchoolEntityModel * schoolModel;
@end

NS_ASSUME_NONNULL_END

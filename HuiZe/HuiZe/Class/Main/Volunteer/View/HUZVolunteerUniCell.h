//
//  HUZVolunteerUniCell.h
//  HuiZe
//
//  Created by mac on 2019/4/27.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZTableViewCell.h"
#import "HUZVoluntPriorityModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddMajor)(void);
@interface HUZVolunteerUniCell : HUZTableViewCell
@property (nonatomic,strong) UIImageView *ivLogo;
@property (nonatomic,strong) UILabel *labSchool;
@property (nonatomic,strong) UILabel *labCity;
@property (nonatomic,strong) UILabel *labDes1;
@property (nonatomic,strong) UILabel *labDes2;
@property (nonatomic,strong) UILabel *labDes3;
@property (nonatomic,strong) UILabel *labDes4;
@property (nonatomic,strong) UIImageView *ivDiviceline;
@property (nonatomic,strong) UIButton *btnAdd;
@property (nonatomic,copy) AddMajor addMajor;

@property (nonatomic,strong) HUZVoluntPriority *model;

@end

NS_ASSUME_NONNULL_END

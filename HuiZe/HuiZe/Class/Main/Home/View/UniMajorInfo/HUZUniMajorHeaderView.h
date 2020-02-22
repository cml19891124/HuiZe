//
//  HUZUniMajorHeaderView.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/26.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZView.h"

NS_ASSUME_NONNULL_BEGIN
@class HUZUniInfoGeneralizeDataModel;
@interface HUZUniMajorHeaderView : HUZView

@property (nonatomic,strong) UIImageView *ivLogo;
@property (nonatomic,strong) UILabel *labSchool;
@property (nonatomic,strong) UILabel *labCity;
@property (nonatomic,strong) UILabel *labDes;
@property (nonatomic,strong) UIImageView *ivDiviceline;

@property (nonatomic, strong) HUZUniInfoGeneralizeDataModel * infoModel;
@end

NS_ASSUME_NONNULL_END

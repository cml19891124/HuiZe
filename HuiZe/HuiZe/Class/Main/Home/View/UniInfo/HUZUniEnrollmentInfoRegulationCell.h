//
//  HUZUniEnrollmentInfoRegulationCell.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/25.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@class HUZRecruitConstitutionListModel;
@interface HUZUniEnrollmentInfoRegulationCell : HUZTableViewCell

@property (nonatomic,strong) UILabel *labRegulation;
@property (nonatomic,strong) UIImageView *ivArrow;
@property (nonatomic,strong) UIImageView *ivDiviceline;
@property (nonatomic, strong) HUZRecruitConstitutionListModel * listMode;
@end

NS_ASSUME_NONNULL_END

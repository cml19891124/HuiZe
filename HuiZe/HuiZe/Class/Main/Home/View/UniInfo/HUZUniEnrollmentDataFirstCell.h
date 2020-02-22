//
//  HUZUniEnrollmentDataFirstCell.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/25.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@class HUZUniEnrollmentDataModel;
@interface HUZUniEnrollmentDataFirstCell : HUZTableViewCell

@property (nonatomic,strong) UIView *ivBg;
@property (nonatomic,strong) UIImageView *ivPlan;
@property (nonatomic,strong) UILabel *labPlan;
@property (nonatomic,strong) TTTAttributedLabel *labPlanDes1;
@property (nonatomic,strong) TTTAttributedLabel *labPlanDes2;

@property (nonatomic,strong) UIImageView *ivStatus;
@property (nonatomic,strong) UILabel *labStatus;
@property (nonatomic,strong) TTTAttributedLabel *labStatusDes1;
@property (nonatomic,strong) TTTAttributedLabel *labStatusDes2;
@property (nonatomic, strong) HUZUniEnrollmentDataModel * dataModel;
@end

NS_ASSUME_NONNULL_END

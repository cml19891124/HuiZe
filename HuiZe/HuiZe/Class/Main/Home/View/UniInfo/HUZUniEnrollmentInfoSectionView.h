//
//  HUZUniEnrollmentInfoSectionView.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/25.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZView.h"
#import "HUZChooseTypeView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,HUZUniEnrollmentInfoType){
    HUZUniEnrollmentInfoPlan = 1,     /// 专业招生计划
    HUZUniEnrollmentInfoRegulation,   /// 招生简章
    HUZOpenUni,                       /// 专业详情界面---开设院校
};

@interface HUZUniEnrollmentInfoSectionView : HUZView

@property (nonatomic,strong) UILabel *labTitle;
@property (nonatomic,strong) HUZChooseTypeView *ivBatch;
@property (nonatomic,strong) HUZChooseTypeView *ivScore;
@property (nonatomic,strong) HUZChooseTypeView *ivSubject;

@property (nonatomic,assign) HUZUniEnrollmentInfoType type;


@end

NS_ASSUME_NONNULL_END

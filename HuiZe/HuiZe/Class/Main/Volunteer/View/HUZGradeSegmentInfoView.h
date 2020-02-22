//
//  HUZGradeSegmentInfoView.h
//  HuiZe
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZView.h"
#import "HUZKernalScoreSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZGradeSegmentInfoView : HUZView

@property (nonatomic,strong) UILabel *labScoreLine;
@property (nonatomic,strong) UILabel *labCenter;
@property (nonatomic,strong) UIButton *btnYear;
@property (nonatomic,strong) UILabel *labScore;
@property (nonatomic,strong) UILabel *labScoreDes;
@property (nonatomic,strong) UILabel *labNum;
@property (nonatomic,strong) UILabel *labNumDes;
@property (nonatomic,strong) UILabel *labTotalNum;
@property (nonatomic,strong) UILabel *labTotalNumDes;

@property (nonatomic,assign) HUZKernalScoreSectionModel *scoreSectionModel;  /// 一分一段

@end

NS_ASSUME_NONNULL_END

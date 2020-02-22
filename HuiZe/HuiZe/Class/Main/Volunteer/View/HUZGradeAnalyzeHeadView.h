//
//  HUZGradeAnalyzeHeadView.h
//  HuiZe
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZView.h"
#import "HUZGradeSegmentInfoView.h"
#import "HUZGradeDetailAnalyzeView.h"
#import "HUZGradeAnalyzeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZGradeAnalyzeHeadView : HUZView
@property (nonatomic,strong) HUZGradeSegmentInfoView *gkInfoView;
@property (nonatomic,strong) HUZGradeDetailAnalyzeView *gradeView;

@property (nonatomic,strong) HUZGradeAnalyzeModel *model;

@end

NS_ASSUME_NONNULL_END

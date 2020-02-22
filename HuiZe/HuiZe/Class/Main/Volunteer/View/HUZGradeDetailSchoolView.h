//
//  HUZGradeDetailSchoolView.h
//  HuiZe
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZView.h"
#import "HUZGradeCircleView.h"
#import "HUZGradeAnalyzeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZGradeDetailSchoolView : HUZView
@property (nonatomic,strong) UILabel *labTop;
@property (nonatomic,strong) HUZGradeCircleView *circleView1;
@property (nonatomic,strong) HUZGradeCircleView *circleView2;
@property (nonatomic,strong) HUZGradeCircleView *circleView3;
@property (nonatomic,strong) HUZGradeCircleView *circleView4;
@property (nonatomic,strong) HUZGradeCircleView *circleView5;

@property (nonatomic,strong) HUZGradeAnalyzeModel *model;


@end

NS_ASSUME_NONNULL_END

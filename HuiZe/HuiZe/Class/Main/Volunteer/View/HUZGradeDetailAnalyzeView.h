//
//  HUZGradeDetailAnalyzeView.h
//  HuiZe
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZView.h"
#import "HUZTwoLabelSwipeView.h"
#import "HUZGradeDetailSchoolView.h"
#import "HUZGradeDetailProfessView.h"
#import "HUZGradeDeatilCityView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZGradeDetailAnalyzeView : HUZView
@property (nonatomic,strong) HUZTwoLabelSwipeView *topView;
@property (nonatomic,strong) HUZGradeDetailSchoolView *schoolView;
@property (nonatomic,strong) HUZGradeDetailProfessView *professView;
@property (nonatomic,strong) HUZGradeDeatilCityView *cityView;

@end

NS_ASSUME_NONNULL_END

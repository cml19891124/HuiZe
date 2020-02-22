//
//  HUZHistoryStudentsPlanSectionView.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/23.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZHistoryStudentsPlanSectionView : HUZView

@property (nonatomic,strong) UIButton *btnYear;
@property (nonatomic,strong) UIButton *btnBatch;
@property (nonatomic,strong) UIButton *btnType;
@property (nonatomic,strong) UIButton *btnSubjectType;

@property (nonatomic,strong) NSString *year;
@property (nonatomic,strong) NSString *batch;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *subject;

@end

NS_ASSUME_NONNULL_END

//
//  HUZKernelDataView.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/22.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZView.h"
#import "HUZKernelDataItemView.h"
#import "HUZKernalScoreSectionModel.h"
#import "HUZKernalScoreLineModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZKernelDataView : HUZView

@property (nonatomic,strong) HUZKernelDataItemView *gkInfoView;
@property (nonatomic,strong) HUZKernelDataItemView *scorelineView;

@property (nonatomic,assign) HUZKernalScoreSectionModel *scoreSectionModel;  /// 一分一段
@property (nonatomic,strong) HUZKernalScoreLineModel *scoreLineModel;  /// 分数线

@end

NS_ASSUME_NONNULL_END

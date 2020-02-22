//
//  HUZHistoryStudentsPlanTableView.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/23.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZSegmentTableView.h"
#import "HUZHistoryStudentsPlanSectionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZHistoryStudentsPlanTableView : HUZSegmentTableView

@property (nonatomic, assign) NSInteger vipState;
@property (nonatomic, strong) HUZGoToBuyVipView *droplineToBuyVipView;
@end

NS_ASSUME_NONNULL_END

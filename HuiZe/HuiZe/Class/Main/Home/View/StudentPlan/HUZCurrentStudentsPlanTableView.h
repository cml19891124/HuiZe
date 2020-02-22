//
//  HUZCurrentStudentsPlanTableView.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/23.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZSegmentTableView.h"
#import "HUZCurrentStudentsPlanSectionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZCurrentStudentsPlanTableView : HUZSegmentTableView
@property (nonatomic, assign) NSInteger vipState;

@property (nonatomic, strong) HUZGoToBuyVipView *droplineToBuyVipView;
@end

NS_ASSUME_NONNULL_END

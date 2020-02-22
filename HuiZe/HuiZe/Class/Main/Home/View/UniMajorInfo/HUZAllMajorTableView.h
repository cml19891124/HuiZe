//
//  HUZAllMajorTableView.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/26.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZSegmentTableView.h"

typedef NS_ENUM(NSInteger,HUZAllMajorType){
    HUZAllMajor = 1,  /// 所有专业
    HUZSpecialMajor,  /// 特色专业
    HUZHistoryEnrollment,  /// 具体招录情况-专业历年录取
};

NS_ASSUME_NONNULL_BEGIN

@interface HUZAllMajorTableView : HUZSegmentTableView

@property (nonatomic,assign) HUZAllMajorType type;
@property (nonatomic, copy) NSString * schoolId;

@end

NS_ASSUME_NONNULL_END

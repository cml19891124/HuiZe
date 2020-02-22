//
//  HUZMajorBasicInfoTableView.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/28.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZSegmentTableView.h"

NS_ASSUME_NONNULL_BEGIN
@class HUZMajorInfoModel;
@interface HUZMajorBasicInfoTableView : HUZSegmentTableView

@property (nonatomic,strong) NSArray *dataHeader;
@property (nonatomic, strong) HUZMajorInfoModel * infoModel;
@property (nonatomic,strong) NSString *majorId;  /// 专业id
@end

NS_ASSUME_NONNULL_END

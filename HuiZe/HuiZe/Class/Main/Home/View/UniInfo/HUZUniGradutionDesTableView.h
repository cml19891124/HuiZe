//
//  HUZUniGradutionDesTableView.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/25.
//  Copyright © 2019年 yiqi. All rights reserved.
//

/**
 大学详细-毕业去向
 */

#import "HUZSegmentTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZUniGradutionDesTableView : HUZSegmentTableView

@property (nonatomic,strong) NSString *schoolId; /// 学校id
@property (nonatomic, assign) NSInteger vipState;
@end

NS_ASSUME_NONNULL_END

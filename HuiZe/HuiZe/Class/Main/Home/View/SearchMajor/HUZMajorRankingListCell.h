//
//  HUZMajorRankingListCell.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/29.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZTableViewCell.h"
@class HUZMajorRankingModel;
NS_ASSUME_NONNULL_BEGIN
@class HUZUniInfoGeneralizeMajorModel,HUZUniInfoAssessModel;
@interface HUZMajorRankingListCell : HUZTableViewCell
@property (nonatomic, strong) HUZUniInfoGeneralizeMajorModel * majorModel;

@property (nonatomic, strong) HUZMajorRankingModel * rankingModel;
@property (nonatomic, strong) NSIndexPath * indexPath;

@property (nonatomic, strong) HUZUniInfoAssessModel * assessModel;
@end

NS_ASSUME_NONNULL_END

//
//  HUZUniRankingViewController.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/24.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZCollectionViewController.h"

typedef NS_ENUM(NSInteger,HUZUniOrMajorRankingType){
    HUZUniRankingType = 1,  /// 高校榜单
    HUZMajorRankingType /// 专业排行榜
};

NS_ASSUME_NONNULL_BEGIN

@interface HUZUniRankingViewController : HUZCollectionViewController

@property (nonatomic,assign) HUZUniOrMajorRankingType type;


@end

NS_ASSUME_NONNULL_END

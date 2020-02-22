//
//  HUZHomeRecommendCell.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/18.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,HUZHomeRecommendType){
    HUZHomeRecommendUni = 1, /// 推荐院校
    HUZHomeRecommendMajor ,  /// 推荐专业
};

@interface HUZHomeRecommendCell : HUZTableViewCell


@property (nonatomic,assign) HUZHomeRecommendType type;

@property (nonatomic,strong) NSArray *datasUni;
@property (nonatomic,strong) NSArray *datasMajor;

@end

NS_ASSUME_NONNULL_END

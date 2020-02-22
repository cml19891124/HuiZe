//
//  HUZRecommendUniListModel.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/16.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZModel.h"
#import "HUZListModel.h"
#import "HUZRecommendUniModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZRecommendUnilistDataModel : HUZListModel

@property (nonatomic,strong) NSArray<HUZRecommendUniDataModel *> *list;

@end

@interface HUZRecommendUniListModel : HUZModel

@property (nonatomic,strong) HUZRecommendUnilistDataModel *data;

@end

NS_ASSUME_NONNULL_END

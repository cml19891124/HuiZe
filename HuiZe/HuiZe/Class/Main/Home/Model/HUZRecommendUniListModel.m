//
//  HUZRecommendUniListModel.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/16.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZRecommendUniListModel.h"

@implementation HUZRecommendUnilistDataModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [HUZRecommendUniDataModel class]};
}


@end


@implementation HUZRecommendUniListModel

@end

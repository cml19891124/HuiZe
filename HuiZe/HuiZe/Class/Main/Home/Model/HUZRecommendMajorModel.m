//
//  HUZRecommendMajorModel.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/11.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZRecommendMajorModel.h"

@implementation HUZRecommendMajorDataModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"};
}
@end

@implementation HUZRecommendMajorModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [HUZRecommendMajorDataModel class]};
}


@end

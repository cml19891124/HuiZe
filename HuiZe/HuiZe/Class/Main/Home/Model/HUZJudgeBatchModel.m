//
//  HUZJudgeBatchModel.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/23.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZJudgeBatchModel.h"

@implementation HUZJudgeBatchDataModel

//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}

@end

@implementation HUZJudgeBatchModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data":[HUZJudgeBatchDataModel class]};
}

@end

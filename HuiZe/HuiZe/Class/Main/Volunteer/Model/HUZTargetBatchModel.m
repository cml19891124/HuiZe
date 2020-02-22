//
//  HUZTargetBatchModel.m
//  HuiZe
//
//  Created by tbb on 2019/11/20.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZTargetBatchModel.h"

@implementation HUZTargetBatchModel
//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"};
}


@end
@implementation HUZTargetBatchDataModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"suitableBatch" : [HUZTargetBatchModel class]};
}
@end



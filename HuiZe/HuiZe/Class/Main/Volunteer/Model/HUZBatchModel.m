//
//  HUZBatchModel.m
//  HuiZe
//
//  Created by mac on 2019/5/21.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZBatchModel.h"

@implementation HUZBatch
//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}
@end

@implementation HUZBatchModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [HUZBatch class]};
}
@end

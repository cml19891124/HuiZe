//
//  HUZProvinceModel.m
//  HuiZe
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZProvinceModel.h"

@implementation HUZProvince
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"};
}
@end

@implementation HUZProvinceModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [HUZProvince class]};
}

@end

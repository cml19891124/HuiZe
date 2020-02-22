//
//  HUZRegisterGuideModel.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/10.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZRegisterGuideModel.h"

@implementation HUZRegisterGuideDataModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id"  : @"id"};
}
@end

@implementation HUZRegisterGuideModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [HUZRegisterGuideDataModel class]};
}

@end

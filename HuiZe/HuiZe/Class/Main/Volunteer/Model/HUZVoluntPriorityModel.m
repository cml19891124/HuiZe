//
//  HUZVoluntPriorityModel.m
//  HuiZe
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZVoluntPriorityModel.h"

@implementation HUZVoluntPriority
//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}
@end

@implementation HUZVoluntPriorityListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"admissionDetailsEntities" : [HUZVoluntPriority class],
             @"admissionDetailsEntities1" : [HUZVoluntPriority class],
             @"admissionDetailsEntities2" : [HUZVoluntPriority class]
             };
}
@end

@implementation HUZVoluntPriorityModel

@end

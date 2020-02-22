//
//  HUZVoluntaryModel.m
//  HuiZe
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZVoluntaryModel.h"

@implementation HUZVoluntary

@end

@implementation HUZVoluntaryListModel
//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"admissionMajorEntity" : [HUZVoluntary class]};
}
@end

@implementation HUZVoluntaryModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [HUZVoluntaryListModel class]};
}
@end

//
//  HUZUlikeMajorModel.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/13.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUlikeMajorModel.h"

@implementation HUZUlikeMajorDataListModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id"  : @"id"};
}
@end

@implementation HUZUlikeMajorDataModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [HUZUlikeMajorDataListModel class]};
}
@end

@implementation HUZUlikeMajorModel

@end

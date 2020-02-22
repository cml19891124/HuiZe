//
//  HUZCommonSenseModel.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/10.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZCommonSenseModel.h"

@implementation HUZCommonSenseDataListModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id"  : @"id"};
}
@end

@implementation HUZCommonSenseDataModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [HUZCommonSenseDataListModel class]};
}
@end

@implementation HUZCommonSenseModel

@end

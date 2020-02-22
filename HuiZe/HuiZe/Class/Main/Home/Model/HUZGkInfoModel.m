//
//  HUZGkInfoModel.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/9.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZGkInfoModel.h"

@implementation HUZGkInfoDataListModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"};
}
@end

@implementation HUZGkInfoDataModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [HUZGkInfoDataListModel class]};
}

@end

@implementation HUZGkInfoModel

@end

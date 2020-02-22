//
//  HUZMessageListModel.m
//  HuiZe
//
//  Created by caominglei on 2019/5/22.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZMessageListModel.h"

@implementation HUZMessageListModel

@end

@implementation HUZMessageListDataModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [HUZMessageModel class]};
}

@end

@implementation HUZMessageModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"};
}

@end

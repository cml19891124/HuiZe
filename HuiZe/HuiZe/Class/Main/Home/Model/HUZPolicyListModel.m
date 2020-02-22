//
//  HUZPolicyListModel.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/10.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZPolicyListModel.h"

@implementation HUZPolicylistdataListModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"};
}
@end

@implementation HUZPolicyListDataModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [HUZPolicylistdataListModel class]};
}

@end


@implementation HUZPolicyListModel

@end

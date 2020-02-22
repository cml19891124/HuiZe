//
//  HUZVolunteerModel.m
//  HuiZe
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZVolunteerModel.h"

@implementation HUZVolunteer
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"};
}
@end

@implementation HUZVolunteerListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [HUZVolunteer class]};
}
@end

@implementation HUZVolunteerModel

@end






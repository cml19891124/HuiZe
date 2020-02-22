//
//  HUZUniEnrollmentInfoModel.m
//  HuiZe
//
//  Created by tbb on 2019/9/6.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZUniEnrollmentInfoModel.h"

@implementation HUZUniEnrollmentInfoModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id",@"count":@"cost"};
}
@end

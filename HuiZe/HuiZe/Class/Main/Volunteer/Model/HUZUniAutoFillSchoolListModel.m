//
//  HUZUniAutoFillSchoolListModel.m
//  HuiZe
//
//  Created by tbb on 2019/11/21.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZUniAutoFillSchoolListModel.h"


@implementation HUZUniAutoFillSchoolListModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"majorList" : [HUZUniAutoFillSchoolMajorListModel class]};
}
@end

@implementation HUZUniAutoFillSchoolMajorListModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"};
}

@end



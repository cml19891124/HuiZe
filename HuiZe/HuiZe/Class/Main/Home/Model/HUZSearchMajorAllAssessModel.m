//
//  HUZSearchMajorAllAssessModel.m
//  HuiZe
//
//  Created by tbb on 2019/11/13.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZSearchMajorAllAssessModel.h"

@implementation HUZSearchMajorAllAssessModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"child":[HUZSearchMajorAllAssessChildModel class]};
}
@end

@implementation HUZSearchMajorAllAssessChildModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"};
}
@end



//
//  HUZIntelligenceDetailModel.m
//  HuiZe
//
//  Created by caominglei on 2019/5/22.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZIntelligenceDetailModel.h"

@implementation HUZIntelligenceDetailModel

@end

@implementation HUZIntelligenceDetailDataModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"volunteerSchoolEntity" : [HUZDetailDataVolunteerSchoolEntityModel class]};
}

@end

@implementation HUZDetailDataVolunteerSchoolEntityModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"majorAllEntities" : [HUZDetailDataVolunteerMajorAllEntitiesModel class]};
}
@end

@implementation HUZDetailDataVolunteerMajorAllEntitiesModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"};
}
@end

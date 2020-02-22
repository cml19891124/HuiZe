//
//  HUZVolunteerFillModel.m
//  HuiZe
//
//  Created by caominglei on 2019/5/22.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZVolunteerFillDataModel.h"

@implementation HUZVolunteerFillDataModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [HUZVolunteerFillModel class]};
}

@end

@implementation HUZVolunteerFillModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"subjectEntities" : [HUZSubjectEntitiesListModel class]};
}

@end

@implementation HUZSubjectEntitiesListModel



@end

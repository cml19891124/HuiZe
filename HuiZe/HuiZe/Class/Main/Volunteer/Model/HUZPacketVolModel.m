//
//  HUZPacketVolModel.m
//  HuiZe
//
//  Created by mac on 2019/5/13.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZPacketVolModel.h"

@implementation HUZMajorEntity

@end


@implementation HUZPacketVolListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"admissionMajorEntities" : [HUZMajorEntity class],
             @"subjectVoList" : [HUZSubjectVoListModel class]

             };
}
@end

@implementation HUZPacketVolModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [HUZPacketVolListModel class]             };
}
@end

@implementation HUZSubjectVoListModel


@end

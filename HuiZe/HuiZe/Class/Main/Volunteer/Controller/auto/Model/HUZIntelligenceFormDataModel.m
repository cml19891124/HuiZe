//
//  HUZIntelligenceFormDataModel.m
//  HuiZe
//
//  Created by caominglei on 2019/5/22.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZIntelligenceFormDataModel.h"

@implementation HUZIntelligenceFormDataModel

@end

@implementation HUZIntelligenceFormModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"completenessList" : [HUZCompletenessModel class],
             @"optimizationNumber" : [HUZOptimizationNumberModel class],
             @"rationalityNumber" : [HUZRationalityNumber class],
             @"major" : [HUZMajorModel class],
             @"rationalityList" : [HUZRationalityListModel class]
             };
}

@end

@implementation HUZRationalityNumber

@end

@implementation HUZCompletenessModel

@end


@implementation HUZOptimizationNumberModel

@end


@implementation HUZRationalityListModel

@end

@implementation HUZMajorModel

@end

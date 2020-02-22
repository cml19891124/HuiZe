//
//  HUZUniEnrollmentDataChartModel.m
//  HuiZe
//
//  Created by tbb on 2019/9/5.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZUniEnrollmentDataChartModel.h"

@implementation HUZUniEnrollmentDataChartModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"provinceScore":[HUZUniEnrollmentDataChartScoreModel class],@"admissionScore":[HUZUniEnrollmentDataChartScoreModel class]};
}
@end

@implementation HUZUniEnrollmentDataChartScoreModel


@end

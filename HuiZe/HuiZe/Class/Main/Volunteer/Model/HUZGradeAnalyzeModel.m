//
//  HUZGradeAnalyzeModel.m
//  HuiZe
//
//  Created by mac on 2019/5/23.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZGradeAnalyzeModel.h"

@implementation HUZGradeAnalyzeDetailsEntitiesCIty

@end

@implementation HUZGradeAnalyzeDetailsEntities
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"universityEntity" : [HUZVoluntary class]};
}

@end

@implementation HUZGradeAnalyzeMajorEntities

@end

@implementation HUZGradeAnalyzeListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"admissionMajorEntities" : [HUZGradeAnalyzeMajorEntities class],
             @"admissionDetailsEntities" : [HUZGradeAnalyzeDetailsEntities class],
             @"admissionDetailsEntitiesCIty" : [HUZGradeAnalyzeDetailsEntitiesCIty class],
             };
}
@end

@implementation HUZGradeAnalyzeModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [HUZGradeAnalyzeListModel class]};
}
@end

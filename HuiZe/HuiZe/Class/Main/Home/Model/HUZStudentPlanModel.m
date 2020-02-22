//
//  HUZStudentPlanModel.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/10.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZStudentPlanModel.h"

@implementation HUZStudentPlanDataListModel

@end

@implementation HUZStudentPlanDataModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [HUZStudentPlanDataListModel class]};
}
@end

@implementation HUZStudentPlanModel

@end

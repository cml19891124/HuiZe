//
//  HUZRecruitConstitutionListModel.m
//  HuiZe
//
//  Created by tbb on 2019/9/6.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZRecruitConstitutionListModel.h"

@implementation HUZRecruitConstitutionListModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id",@"count":@"cost"};
}
@end

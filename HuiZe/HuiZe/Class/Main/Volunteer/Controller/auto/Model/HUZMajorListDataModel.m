//
//  HUZMajorListDataModel.m
//  HuiZe
//
//  Created by caominglei on 2019/5/23.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZMajorListDataModel.h"

@implementation HUZMajorListDataModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [HUZMajorDataListModel class]};
}
@end

@implementation HUZMajorDataListModel


@end

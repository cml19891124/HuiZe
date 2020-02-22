//
//  HUZIndustyLeaModel.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/17.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZIndustyLeaModel.h"

@implementation HUZIndustyLeaDataListIndustyModel

@end

@implementation HUZIndustyLeaDataListLeaModel

@end

@implementation HUZIndustyLeaDataListModel

@end

@implementation HUZIndustyLeaDataNumberModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"num":@"count"};
}

@end

@implementation HUZIndustyLeaDataModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"number": [HUZIndustyLeaDataNumberModel class], @"list":[HUZIndustyLeaDataListModel class]};
}

@end

@implementation HUZIndustyLeaModel

@end

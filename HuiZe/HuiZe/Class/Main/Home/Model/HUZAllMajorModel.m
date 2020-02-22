//
//  HUZAllMajorModel.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/13.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZAllMajorModel.h"

@implementation HUZAllMajorDataThirdModel

@end

@implementation HUZAllMajorDataSecondModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"majorAllEntityList" : [HUZAllMajorDataThirdModel class]};
}


@end

@implementation HUZAllMajorDataFirstModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"majorAllEntityList" : [HUZAllMajorDataSecondModel class]};
}

@end

@implementation HUZAllMajorModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [HUZAllMajorDataFirstModel class]};
}

@end

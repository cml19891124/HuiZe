//
//  HUZRecommendUniModel.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/9.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZRecommendUniModel.h"

@implementation HUZRecommendUniDataModel

@end

@implementation HUZRecommendUniAdmModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"admissionDetailsEntityList" : [HUZRecommendUniDataModel class]};
}
@end

@implementation HUZRecommendUniModel



@end

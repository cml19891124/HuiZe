//
//  HUZKernalScoreLineModel.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/9.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZKernalScoreLineModel.h"

@implementation HUZKernalScoreLineDataModel

@end

@implementation HUZKernalScoreLineModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [HUZKernalScoreLineDataModel class]};
}
@end

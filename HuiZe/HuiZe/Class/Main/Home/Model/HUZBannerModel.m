//
//  HUZBannerModel.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/10.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZBannerModel.h"

@implementation HUZBannerDataModel

@end

@implementation HUZBannerModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [HUZBannerDataModel class]};
}
@end

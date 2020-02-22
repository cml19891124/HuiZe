//
//  HUZMyUser.m
//  HuiZe
//
//  Created by mac on 2019/5/15.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZMyUser.h"
#import "HUZUser.h"

@implementation HUZMyUser
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [HUZUser class]};
}

@end

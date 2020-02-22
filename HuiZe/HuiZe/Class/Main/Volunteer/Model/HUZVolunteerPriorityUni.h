//
//  HUZVolunteerPriorityUni.h
//  HuiZe
//
//  Created by mac on 2019/5/23.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZVolunteerPriority : NSObject
@property (nonatomic, copy) NSString * protect; // 保
@property (nonatomic, copy) NSString * punching; // 冲
@property (nonatomic, copy) NSString * stable; // 稳

@end

@interface HUZVolunteerPriorityUni : HUZModel
@property (nonatomic,strong) HUZVolunteerPriority *data;

@end

NS_ASSUME_NONNULL_END

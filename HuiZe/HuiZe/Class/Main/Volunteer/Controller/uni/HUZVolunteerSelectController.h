//
//  HUZVolunteerSelectController.h
//  HuiZe
//
//  Created by mac on 2019/4/27.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZTableViewController.h"

typedef enum : NSUInteger {
    VolunteerSelectTypeChong = 0,
    VolunteerSelectTypeWen,
    VolunteerSelectTypeBao,
} VolunteerSelectType;
NS_ASSUME_NONNULL_BEGIN

@interface HUZVolunteerSelectController : HUZTableViewController
@property (assign, nonatomic) NSInteger volType;

@property (copy, nonatomic) NSString *batchId;

/**
 专业优先
 */
@property (assign, nonatomic) BOOL isMajorPriority;

//@property (nonatomic, assign) NSInteger alternativeType;//// 来源：0智能填报，1院校优先填报，2专业优先填报，3手动填报
@property (nonatomic, copy) NSArray * majorAllIdsArr;
@end

NS_ASSUME_NONNULL_END

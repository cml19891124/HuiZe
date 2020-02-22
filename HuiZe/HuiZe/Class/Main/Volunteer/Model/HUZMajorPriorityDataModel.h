//
//  HUZMajorPriorityModel.h
//  HuiZe
//
//  Created by caominglei on 2019/6/4.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZModel.h"

@class HUZMajorPriorityModel;

NS_ASSUME_NONNULL_BEGIN

@interface HUZMajorPriorityDataModel : HUZModel

@property (strong, nonatomic) HUZMajorPriorityModel *data;

@end

@interface HUZMajorPriorityModel : HUZModel

@property (nonatomic, assign) NSInteger protect;

@property (nonatomic, assign) NSInteger punching;

@property (nonatomic, assign) NSInteger stable;

@end


NS_ASSUME_NONNULL_END

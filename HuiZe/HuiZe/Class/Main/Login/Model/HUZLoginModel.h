//
//  HUZLoginModel.h
//  HuiZe
//
//  Created by mac on 2019/5/7.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZModel.h"
@class HUZUser;
@class HUZLoginDataModel;

NS_ASSUME_NONNULL_BEGIN

@interface HUZLoginModel : HUZModel

@property (nonatomic,strong)HUZLoginDataModel *data;

@end

@interface HUZLoginDataModel : NSObject

@property (nonatomic,copy)NSString *expire;

@property (nonatomic,copy)NSString *token;

@property (nonatomic,strong)HUZUser *userEntity;

@end

NS_ASSUME_NONNULL_END

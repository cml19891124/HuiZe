//
//  HUZBatchModel.h
//  HuiZe
//
//  Created by mac on 2019/5/21.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZBatch : NSObject
@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *batchName;
@end

@interface HUZBatchModel : HUZModel
@property (nonatomic,strong) NSArray <HUZBatch*> *data;

@end

NS_ASSUME_NONNULL_END

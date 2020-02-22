//
//  HUZTargetBatchModel.h
//  HuiZe
//
//  Created by tbb on 2019/11/20.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HUZTargetBatchModel : NSObject
@property (nonatomic, copy) NSString * batchName;
@property (nonatomic, copy) NSString * batchType;
@property (nonatomic, copy) NSString * Id;
@end

@interface HUZTargetBatchDataModel : NSObject
@property (nonatomic, copy) NSString * lastYear;
@property (nonatomic, strong) HUZTargetBatchModel * targetBatch;
@property (nonatomic, strong) NSArray <HUZTargetBatchModel *> * suitableBatch;
@end

NS_ASSUME_NONNULL_END

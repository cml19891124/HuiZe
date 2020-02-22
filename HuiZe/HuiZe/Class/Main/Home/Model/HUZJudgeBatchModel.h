//
//  HUZJudgeBatchModel.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/23.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZModel.h"

@class HUZSchoolModel;

NS_ASSUME_NONNULL_BEGIN

@interface HUZJudgeBatchDataModel : NSObject

@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *batchName;


/**
 列表页的section是否展开
 */
@property (assign, nonatomic) BOOL isOpen;

@property (strong, nonatomic) NSArray *schoolArray;
@end

@interface HUZJudgeBatchModel : HUZModel

@property (nonatomic,strong) NSArray<HUZJudgeBatchDataModel *> *data;

@end

NS_ASSUME_NONNULL_END

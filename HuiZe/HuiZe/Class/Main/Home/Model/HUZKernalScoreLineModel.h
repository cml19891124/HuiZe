//
//  HUZKernalScoreLineModel.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/9.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZKernalScoreLineDataModel : NSObject

@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *batch;  /// 0本科批， 1本科一批，2本科二批，3本科三批，4专科批，5平行录取一段，6平行录取二段，7平行录取三段，8本科提前批 ，9国家专项计划本科批
@property (nonatomic,strong) NSString *score;  /// 分数

@end

@interface HUZKernalScoreLineModel : HUZModel

@property (nonatomic,strong) NSArray<HUZKernalScoreLineDataModel *> *data;
@end

NS_ASSUME_NONNULL_END

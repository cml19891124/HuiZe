//
//  HUZKernalScoreSectionModel.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/9.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZKernalScoreSectionDataModel : NSObject

@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *score;    /// 分数
@property (nonatomic,strong) NSString *scoreNum; /// 分段人数
@property (nonatomic,strong) NSString *cumulativeNum; /// 累计人数
@property (nonatomic,strong) NSString *province;
@property (nonatomic,strong) NSString *year;
@property (nonatomic,strong) NSString *grade;
@property (nonatomic,strong) NSString *provinceRanking;
@end

@interface HUZKernalScoreSectionModel : HUZModel

@property (nonatomic,strong) HUZKernalScoreSectionDataModel *data;

@end

NS_ASSUME_NONNULL_END

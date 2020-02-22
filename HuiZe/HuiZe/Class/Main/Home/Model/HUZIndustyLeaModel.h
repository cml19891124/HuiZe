//
//  HUZIndustyLeaModel.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/17.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZIndustyLeaDataListIndustyModel : NSObject
@property (nonatomic,strong) NSString *proportion;  ///行业占比


@end

@interface HUZIndustyLeaDataListLeaModel : NSObject

@property (nonatomic,strong) NSString *industryName;  /// 行业名称

@end

@interface HUZIndustyLeaDataListModel : NSObject

@property (nonatomic,strong) HUZIndustyLeaDataListLeaModel *industryEntity;
@property (nonatomic,strong) HUZIndustyLeaDataListIndustyModel *leaTowardsEntity;

@end

@interface HUZIndustyLeaDataNumberModel : NSObject

@property (nonatomic,strong) NSString *industry_name;  /// 行业
@property (nonatomic,strong) NSString *num;    /// 就业数量

@end

@interface HUZIndustyLeaDataModel : NSObject

@property (nonatomic,strong) NSArray<HUZIndustyLeaDataNumberModel *> *number;
@property (nonatomic,strong) NSArray<HUZIndustyLeaDataListModel *> *list;

@end

@interface HUZIndustyLeaModel : HUZModel

@property (nonatomic,strong) HUZIndustyLeaDataModel *data;

@end

NS_ASSUME_NONNULL_END

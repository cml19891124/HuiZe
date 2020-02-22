//
//  HUZKernalEnterlineModel.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/9.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZModel.h"
#import "HUZListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZKernalEnterlineDataListUniModel : NSObject

@property (nonatomic,strong) NSString *schoolName;  /// 大学名称
@property (nonatomic,strong) NSString *logoUrl;   /// 大学logo
@property (nonatomic,strong) NSString *province;   /// 省份id
@property (nonatomic,strong) NSString *provinceName;
@end

@interface HUZKernalEnterlineDataListModel : NSObject

@property (nonatomic,strong) NSString *minRanking;   /// 录取线最低位次
@property (nonatomic,strong) NSString *minScore;     /// 最低录取分
@property (nonatomic,strong) HUZKernalEnterlineDataListUniModel *universityEntity;  /// 大学实体对象
@property (nonatomic,strong) NSString *schoolId; /// 学校id
@end

@interface HUZKernalEnterlineDataModel : HUZListModel

@property (nonatomic,strong) NSArray<HUZKernalEnterlineDataListModel *> *list;

@end

@interface HUZKernalEnterlineModel : HUZModel

@property (nonatomic,strong) HUZKernalEnterlineDataModel *data;

@end

NS_ASSUME_NONNULL_END

//
//  HUZKernalDroplineModel.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/9.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZModel.h"
#import "HUZListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZKernalDroplineDataListUniModel : NSObject

@property (nonatomic,strong) NSString *schoolName;  /// 大学名称
@property (nonatomic,strong) NSString *logoUrl;   /// 大学logo
@property (nonatomic,strong) NSString *province;   /// 省份id
@property (nonatomic,strong) NSString *provinceName; 
@end

@interface HUZKernalDroplineDataListModel : NSObject

@property (nonatomic,strong) NSString *deliveryScore;   /// 投档最低分
@property (nonatomic,strong) NSString *minRanking;      /// 投档最低位次
@property (nonatomic,strong) HUZKernalDroplineDataListUniModel *universityEntity;  /// 大学实体对象
@property (nonatomic,strong) NSString *schoolId; /// 学校id
@property (nonatomic, copy) NSString * yuanxiaomingcheng;
@end

@interface HUZKernalDroplineDataModel : HUZListModel

@property (nonatomic,strong) NSArray<HUZKernalDroplineDataListModel *> *list;

@end

@interface HUZKernalDroplineModel : HUZModel

@property (nonatomic,strong) HUZKernalDroplineDataModel *data;

@end

NS_ASSUME_NONNULL_END

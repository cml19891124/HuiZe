//
//  HUZSearchKeywordModel.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/11.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZModel.h"

NS_ASSUME_NONNULL_BEGIN

//// 专业
@interface HUZSearchKeywordDataSubjectModel : NSObject

@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *majorId;
@property (nonatomic,strong) NSString *category;  /// 专业名称
@property (nonatomic,strong) NSString *schoolName; /// 学校名称

@end

@interface HUZSearchKeywordDataUniDetailModel : NSObject

@property (nonatomic,strong) NSString *deliveryScore; /// 投档最低分
@property (nonatomic,strong) NSString *minRanking;   /// 最多投档位次

@end

/// 大学
@interface HUZSearchKeywordDataUniModel : NSObject

@property (nonatomic,strong) NSString *schoolId;   /// 学校id
@property (nonatomic,strong) NSString *schoolName; /// 学校名称
@property (nonatomic,strong) NSString *address;    /// 城市id
@property (nonatomic,strong) NSString *logoUrl;    /// 学校logo
@property (nonatomic,strong) NSString *provinceName; /// 城市名称
@property (nonatomic,strong) HUZSearchKeywordDataUniDetailModel *deliveryDetailsEntity;

@end

@interface HUZSearchKeywordDataModel : NSObject

@property (nonatomic,strong) NSArray<HUZSearchKeywordDataUniModel *> *universityEntityList;   /// 大学列表
@property (nonatomic,strong) NSArray<HUZSearchKeywordDataSubjectModel *> *subjectEntities;    /// 专业列表

@end

@interface HUZSearchKeywordModel : HUZModel

@property (nonatomic,strong) HUZSearchKeywordDataModel *data;
@end

NS_ASSUME_NONNULL_END

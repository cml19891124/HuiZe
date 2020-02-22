//
//  HUZRecommendUniModel.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/9.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZRecommendUniDataModel : NSObject
 
@property (nonatomic, copy) NSString * uniCity;
@property (nonatomic, copy) NSString * planNum;

@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *schoolName;  /// 学校名称
@property (nonatomic,strong) NSString *logoUrl;     /// 学校logo
@property (nonatomic,strong) NSString *provinceName; /// 城市名称
@property (nonatomic,strong) NSString *minScore;  /// 最低分
@property (nonatomic,strong) NSString *admissionOdds;  /// 录取概率
@property (nonatomic,strong) NSString *minRanking;  /// 最低排名
@property (nonatomic,strong) NSString *admissionNum;  /// 招生人数
@property (nonatomic,strong) NSString *year; /// 年份
@property (nonatomic,strong) NSString *schoolId;  /// 学校id
@end

@interface HUZRecommendUniAdmModel : NSObject

@property (nonatomic,strong) NSArray<HUZRecommendUniDataModel *> *admissionDetailsEntityList;

@end

@interface HUZRecommendUniModel : HUZModel

@property (nonatomic,strong) HUZRecommendUniAdmModel *data;

@end

NS_ASSUME_NONNULL_END

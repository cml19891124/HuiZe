//
//  HUZStudentPlanModel.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/10.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZModel.h"
#import "HUZListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZStudentPlanDataListModel : NSObject

@property (nonatomic,strong) NSString *address;       /// 所在地
@property (nonatomic,strong) NSString *admissionNum;  /// 录取人数
@property (nonatomic,strong) NSString *average;       ///专业录取平均分
@property (nonatomic,strong) NSString *category;    ///专业名称
@property (nonatomic,strong) NSString *deliveryNum; ///投档人数
@property (nonatomic,strong) NSString *logoUrl;     /// 大学logo
@property (nonatomic,strong) NSString *minRanking;  /// 录取最低排名
@property (nonatomic,strong) NSString *minScore;    /// 最低分
@property (nonatomic,strong) NSString *probability;   /// 概率
@property (nonatomic,strong) NSString *provinceScore;  /// 省控线
@property (nonatomic,strong) NSString *schoolName;  /// 大学名称
@property (nonatomic,strong) NSString *year;
@property (nonatomic,strong) NSString *provinceName;
@property (nonatomic, copy) NSString * schoolId;
@end

@interface HUZStudentPlanDataModel : HUZListModel

@property (nonatomic,strong) NSArray<HUZStudentPlanDataListModel *> *list;

@end

@interface HUZStudentPlanModel : HUZModel

@property (nonatomic,strong) HUZStudentPlanDataModel *data;

@end

NS_ASSUME_NONNULL_END

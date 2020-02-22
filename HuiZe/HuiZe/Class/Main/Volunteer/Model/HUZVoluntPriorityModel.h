//
//  HUZVoluntPriorityModel.h
//  HuiZe
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZVoluntPriority : NSObject
@property (nonatomic, copy) NSString *universityRankingEntities; //
@property (nonatomic, copy) NSString * province; // 省
@property (nonatomic, copy) NSString *universityEntity; // 大学
@property (nonatomic, copy) NSString * yuanxiaomingcheng;
@property (nonatomic, copy) NSString * schoolId; // 学校ID
@property (nonatomic, copy) NSString * maxScore; // 最高分
@property (nonatomic, copy) NSString * average; //  平均分
@property (nonatomic, copy) NSString * minRanking; // 录取最低排名
@property (nonatomic, copy) NSString *schoolName; // 大学名称
@property (nonatomic, copy) NSString *subjectEntities; // 年份
@property (nonatomic, copy) NSString *logoUrl; // 大学图标
@property (nonatomic, copy) NSString * year; // 年份
@property (nonatomic, copy) NSString * batch; // 批次 ,
@property (nonatomic, copy) NSString * ID; //
@property (nonatomic, copy) NSString *provinceName; // 所在地
@property (nonatomic, copy) NSString *uniCity; // 所在地
@property (nonatomic, copy) NSString * admissionNum; // 录取人数
@property (nonatomic, strong) NSString * planNum;
@property (nonatomic, copy) NSString * grade; // 文理科：0文教，1理科
@property (nonatomic, assign) BOOL haveSchool; // 否添加该学校:0是 1否
@property (nonatomic, copy) NSString * minScore; // 最低分
@property (nonatomic, copy) NSString * deliveryNum; // 投档人数
@property (nonatomic, copy) NSString * provinceScore; // 省控线分
@property (nonatomic, copy) NSString *admissionOdds;
@property (nonatomic, copy) NSString *type;
@end

@interface HUZVoluntPriorityListModel : HUZListModel
@property (nonatomic,strong) NSArray<HUZVoluntPriority *> *admissionDetailsEntities; // 冲击的学校
@property (nonatomic,strong) NSArray<HUZVoluntPriority *> *admissionDetailsEntities1; // 推荐学校，稳妥的学校
@property (nonatomic,strong) NSArray<HUZVoluntPriority *> *admissionDetailsEntities2; // 保底的学校

@end

@interface HUZVoluntPriorityModel : HUZModel
@property (nonatomic,strong) HUZVoluntPriorityListModel *data;

@end

NS_ASSUME_NONNULL_END


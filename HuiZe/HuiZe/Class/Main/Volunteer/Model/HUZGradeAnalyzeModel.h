//
//  HUZGradeAnalyzeModel.h
//  HuiZe
//
//  Created by mac on 2019/5/23.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZModel.h"
#import "HUZVoluntaryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZGradeAnalyzeDetailsEntitiesCIty : NSObject
@property (nonatomic,strong) NSString *fraction; //
@property (nonatomic,strong) NSString *city; //
@end

@interface HUZGradeAnalyzeDetailsEntities : NSObject
@property (nonatomic,strong) NSString *id; //
@property (nonatomic,strong) NSString *batch; // 批次 ,
@property (nonatomic,strong) NSString *minRanking; // 最低排名
@property (nonatomic,strong) NSString *average; //  平均分
@property (nonatomic,strong) NSString *schoolId; // 大学id
@property (nonatomic,strong) NSString *admissionNum; // 录取人数
@property (nonatomic,strong) NSString *provinceScore; //
@property (nonatomic,strong) NSString *province; //
@property (nonatomic,strong) NSString *maxScore; //  最高分
@property (nonatomic,strong) NSString *minScore; /// 录取最低分 ,
@property (nonatomic,strong) NSString *admissionOdds; //
@property (nonatomic,strong) NSString *grade; // 文理科：0文教，1理科
@property (nonatomic,strong) NSString *type; //
@property (nonatomic,strong) NSString *deliveryNum; //
@property (nonatomic,strong) NSString *year; //
@property (nonatomic,strong) HUZVoluntary *universityEntity;
@end

@interface HUZGradeAnalyzeMajorEntities : NSObject
@property (nonatomic,strong) NSString *id; //
@property (nonatomic,strong) NSString *minScore; /// 录取最低分 ,
@property (nonatomic,strong) NSString *minRanking; // 最低排名
@property (nonatomic,strong) NSString *maxScore; //  最高分
@property (nonatomic,strong) NSString *admissionNum; // 录取人数
@property (nonatomic,strong) NSString *average; //  平均分
@property (nonatomic,strong) NSString *batch; // 批次 ,
@property (nonatomic,strong) NSString *category; // 专业名称
@property (nonatomic,strong) NSString *grade; // 文理科：0文教，1理科
@property (nonatomic,strong) NSString *majorAllEntity; //
@property (nonatomic,strong) NSString *majorAllId; // 专业id ,
@property (nonatomic,strong) NSString *recruitAddress; //
@property (nonatomic,strong) NSString *schoolId; // 大学id
@property (nonatomic,strong) NSString *schoolName; // 大学名称
@end

@interface HUZGradeAnalyzeListModel : NSObject
@property (nonatomic,strong) NSArray <HUZGradeAnalyzeMajorEntities*> *admissionMajorEntities;
@property (nonatomic,strong) NSArray <HUZGradeAnalyzeDetailsEntities*> *admissionDetailsEntities;
@property (nonatomic,strong) NSArray <HUZGradeAnalyzeDetailsEntitiesCIty*> *admissionDetailsEntitiesCIty;

@end

@interface HUZGradeAnalyzeModel : HUZModel
@property (nonatomic,strong) HUZGradeAnalyzeListModel *data;

@end

NS_ASSUME_NONNULL_END

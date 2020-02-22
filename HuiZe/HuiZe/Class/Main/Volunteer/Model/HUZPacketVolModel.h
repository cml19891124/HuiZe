//
//  HUZPacketVolModel.h
//  HuiZe
//
//  Created by mac on 2019/5/13.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZModel.h"

@class HUZSubjectVoListModel;
NS_ASSUME_NONNULL_BEGIN

@interface HUZMajorEntity : NSObject
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *admissionNum; //
@property (nonatomic,strong) NSString *average; /// 平均分
@property (nonatomic,strong) NSString *category; //
@property (nonatomic,strong) NSString *batch; //  批次
@property (nonatomic,strong) NSString *majorAllEntity; //
@property (nonatomic,strong) NSString *majorAllId; //
@property (nonatomic,strong) NSString *grade; //
@property (nonatomic,strong) NSString *maxScore; //
@property (nonatomic,strong) NSString *minRanking; //
@property (nonatomic,strong) NSString *minScore; //
@property (nonatomic,strong) NSString *recruitAddress; //
@property (nonatomic,strong) NSString *schoolId; //
@property (nonatomic,strong) NSString *schoolName; //
@property (nonatomic,strong) NSString *year; //
@property (nonatomic,assign) BOOL isSelected; // 是否被选择

@end

@interface HUZPacketVolListModel : NSObject
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *userId;          /// 用户ID
@property (nonatomic,strong) NSString *schoolId;     /// 学校ID
@property (nonatomic,strong) NSArray <HUZMajorEntity*> *admissionMajorEntities;     /// 专业对象
@property (nonatomic, assign) BOOL haveSchool; // 否添加该学校:0是 1否
@property (nonatomic,strong) NSString *createTime; //
@property (nonatomic,strong) NSString *batch; // 批次
@property (nonatomic,strong) NSString *admissionNum; //
@property (nonatomic,copy) NSString *admissionOdds; //(string, optional): 录取概率 ,
@property (nonatomic,strong) NSString *average; //
@property (nonatomic,strong) NSString *batchName; //
@property (nonatomic,strong) NSString *deliveryNum; //

@property (nonatomic,strong) NSString *grade; //
@property (nonatomic,strong) NSString *logoUrl; //
@property (nonatomic,strong) NSString *maxScore; //
@property (nonatomic,strong) NSString *minRanking; //
@property (nonatomic,strong) NSString *minScore; //
@property (nonatomic,strong) NSString *province; //
@property (nonatomic,strong) NSString *provinceName; //
@property (nonatomic,strong) NSString *provinceScore; //
@property (nonatomic,strong) NSString *schoolName; //
@property (nonatomic,strong) NSString *subjectEntities; //
@property (nonatomic,strong) NSString *universityEntity; //
@property (nonatomic,strong) NSString *universityRankingEntities; //
@property (nonatomic,strong) NSString *year; //
@property (nonatomic,assign) BOOL isSelected; // 是否被选择

@property (nonatomic,strong) NSString *alternativeFormId; //
@property (nonatomic,strong) NSArray <HUZSubjectVoListModel*> *subjectVoList; //

@property (nonatomic,strong) NSArray <HUZSubjectVoListModel*> *selectSubjectVoList; //

@property (nonatomic,strong) NSString *uniCity; //

@end

@interface HUZPacketVolModel : HUZModel
@property (nonatomic,strong) NSArray <HUZPacketVolListModel*> *data;

@end


@interface HUZSubjectVoListModel : HUZModel
@property (nonatomic, copy) NSString *alternativeMajorId;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *majorAllId;

@property (nonatomic, copy) NSString *admissionNum;
@property (nonatomic, copy) NSString *minRanking;
@property (nonatomic, copy) NSString *average;
@property (nonatomic, copy) NSString *minScore;
@property (nonatomic, copy) NSString *year;
@property (nonatomic,assign) BOOL isSelected; // 是否被选择

@end
NS_ASSUME_NONNULL_END

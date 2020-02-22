//
//  HUZVolunteerFillModel.h
//  HuiZe
//
//  Created by caominglei on 2019/5/22.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZModel.h"

@class HUZVolunteerFillModel,HUZSubjectEntitiesListModel;

NS_ASSUME_NONNULL_BEGIN

@interface HUZVolunteerFillDataModel : HUZModel

@property (nonatomic,strong) NSArray <HUZVolunteerFillModel*> *data;

@end

@interface HUZVolunteerFillModel : NSObject

@property (nonatomic,copy) NSString *admissionNum;

@property (nonatomic,copy) NSString *admissionOdds;

@property (nonatomic,copy) NSString *average;

@property (nonatomic,copy) NSString *batch;

@property (nonatomic,copy) NSString *deliveryNum;

@property (nonatomic,copy) NSString *grade;

@property (nonatomic,copy) NSString *logoUrl;

@property (nonatomic,copy) NSString *maxScore;

@property (nonatomic,copy) NSString *minRanking;

@property (nonatomic,copy) NSString *minScore;

@property (nonatomic,copy) NSString *province;

@property (nonatomic,copy) NSString *provinceName;

@property (nonatomic,copy) NSString *schoolId;

@property (nonatomic,copy) NSString *schoolName;

@property (nonatomic,strong) NSArray <HUZSubjectEntitiesListModel *>*subjectEntities;

@end

@interface HUZSubjectEntitiesListModel : NSObject

@property (nonatomic, copy) NSString *admissionMajorEntities;

@property (nonatomic, copy) NSString *allEntities;

@property (nonatomic, copy) NSString *category;

@property (nonatomic, copy) NSString *characteristic;

@property (nonatomic, copy) NSString *educationDepartment;

@property (nonatomic, copy) NSString *evaluate;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *keyOne;

@property (nonatomic, copy) NSString *keySubject;

@property (nonatomic, copy) NSString *keyTwo;

@property (nonatomic, copy) NSString *majorAllId;

@end

NS_ASSUME_NONNULL_END

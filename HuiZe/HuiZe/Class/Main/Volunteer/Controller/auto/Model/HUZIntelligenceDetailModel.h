//
//  HUZIntelligenceDetailModel.h
//  HuiZe
//
//  Created by caominglei on 2019/5/22.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZDetailDataVolunteerMajorAllEntitiesModel : NSObject
@property (nonatomic, copy) NSString * category;
@property (nonatomic, copy) NSString * majorAllId;
@end

@interface HUZDetailDataVolunteerSchoolEntityModel : NSObject
@property (nonatomic, assign) NSInteger batch;
@property (nonatomic, copy) NSString * Id;
@property (nonatomic, copy) NSString * logoUrl;
@property (nonatomic, copy) NSString * majorAllIds;
@property (nonatomic, copy) NSString * schoolId;
@property (nonatomic, copy) NSString * schoolName;
@property (nonatomic, copy) NSString * uniCity;
@property (nonatomic, copy) NSString * volunteerFormId;

@property (nonatomic, strong) NSArray <HUZDetailDataVolunteerMajorAllEntitiesModel *> * majorAllEntities;
@end

@interface HUZIntelligenceDetailDataModel : NSObject
@property (nonatomic, copy) NSString *  createTime;
@property (nonatomic, assign) long editTime;
@property (nonatomic, copy) NSString * Id;
@property (nonatomic, assign) NSInteger reasonable;
@property (nonatomic, copy) NSString * userId;
@property (nonatomic, copy) NSString * volunteerName;
@property (nonatomic, assign) NSInteger volunteerType;

@property (nonatomic, strong) NSArray <HUZDetailDataVolunteerSchoolEntityModel *> * volunteerSchoolEntity;
@end

@interface HUZIntelligenceDetailModel : HUZModel
@property (nonatomic, strong) HUZIntelligenceDetailDataModel  * data;
@end

NS_ASSUME_NONNULL_END

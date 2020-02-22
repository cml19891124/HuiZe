//
//  HUZVolunteerService.h
//  HuiZe
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HUZVolunteerModel.h"
#import "HUZVoluntPriorityModel.h"
#import "HUZVoluntaryModel.h"
#import "HUZPacketVolModel.h"
#import "HUZBatchModel.h"
#import "HUZVolunteerFillDataModel.h"
#import "HUZIntelligenceFormDataModel.h"
#import "HUZIntelligenceDetailModel.h"
#import "HUZVolunteerPriorityUni.h"
#import "HUZGradeAnalyzeModel.h"

#import "HUZMajorPriorityDataModel.h"

#import "HUZSchoolListDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZVolunteerService : NSObject

/**
 批次list
 */
+ (void)getBatchListSuccess:(void(^)(HUZBatchModel *batch))success
                                             failure:(void (^)(NSUInteger code,NSString *errorStr))failure;
/**
 我的成绩分析
 */
+ (void)getVolunteerScoreAnalysisWithParamters:(NSDictionary *)parameters
                                       success:(void (^)(HUZGradeAnalyzeModel *model))success
                                       failure:(void (^)(NSUInteger code,NSString *errorStr))failure;
/**
 智能筛选
 */
+ (void)getVolunteerIntelligenceScreenWithParamters:(NSDictionary *)parameters
                           success:(void (^)(HUZVolunteerFillDataModel *volunteerFill))success
                           failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 智能生成志愿表
 */
+ (void)getVolunteerIntelligenceTestFormWithParamters:(NSDictionary *)parameters
                                            success:(void (^)(HUZIntelligenceFormDataModel *formModel))success
                                            failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 志愿表详情
 */
+ (void)getVolunteerIntelligenceTestFormDetailWithParamters:(NSDictionary *)parameters
                                                    success:(void (^)(HUZIntelligenceDetailModel *detailModel))success
                                                    failure:(void (^)(NSUInteger code,NSString *errorStr))failure;
/**
 院校优先报名
 */
+ (void)getVolunteerPriorityApplicationWithParamters:(NSDictionary *)parameters
                                             success:(void(^)(HUZVolunteerPriorityUni *volunteerPriorityUni))success
                              failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 院校优先报名---学校页面
 */
+ (void)getVolunteerSchoolsIsMajor:(BOOL)isMajor WithParamters:(NSDictionary *)parameters
                                 success:(void(^)(HUZVoluntPriorityModel *priorityModel))success
                                 failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 根据学校获取专业
 */
+ (void)getVoluntaryAccordingSchoolWithID:(NSString *)ID
                                  success:(void(^)(HUZVoluntaryModel *voluntaryModel))success
                                  failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 添加到备选志愿
 */
+ (void)saveAlternativeWithParamters:(NSDictionary *)parameters
                                   success:(void (^)(NSString *success))success
                                   failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 添加到我的志愿
 */
+ (void)saveVolunteerWithParamters:(NSDictionary *)parameters
                             success:(void (^)(NSString *success))success
                             failure:(void (^)(NSUInteger code,NSString *errorStr))failure;
/**
 我的备选志愿

 */
+ (void)getVolunteerVoluntaryWithParamters:(NSDictionary *)parameters
                                   success:(void(^)(HUZPacketVolModel *packVolModel))success
                                   failure:(void (^)(NSUInteger code,NSString *errorStr))failure;
/**
 志愿表列表
 */
+ (void)getVolunteerListWithParamters:(NSDictionary *)parameters
                     success:(void(^)(HUZVolunteerModel *volunteerModel))success
                     failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 删除志愿表
 */
+ (void)delVolunteerWithParamters:(NSDictionary *)parameters
                          success:(void (^)(NSString *success))success
                          failure:(void (^)(NSUInteger code,NSString *errorStr))failure;
/**
 根据专业获取大学信息
 */
+ (void)getMajorUniversityWithParamters:(NSDictionary *)parameters
                                success:(void (^)(HUZMajorPriorityDataModel * _Nonnull dataModel))success
                                failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/// 根据专业筛选大学信息
+ (void)getUniversityWithMajorParamters:(NSDictionary *)parameters
                                success:(void (^)(HUZMajorPriorityDataModel * _Nonnull dataModel))success
                                failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/// 大学列表
+ (void)getUniversitiesWithParamters:(NSDictionary *)parameters
                             success:(void (^)(HUZSchoolListDataModel * _Nonnull dataModel))success
                             failure:(void (^)(NSUInteger code,NSString *errorStr))failure;
@end

NS_ASSUME_NONNULL_END

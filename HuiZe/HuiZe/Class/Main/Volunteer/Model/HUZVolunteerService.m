//
//  HUZVolunteerService.m
//  HuiZe
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZVolunteerService.h"

@implementation HUZVolunteerService
//暂不调用
/**
 批次list
 */
+ (void)getBatchListSuccess:(void(^)(HUZBatchModel *batch))success
                    failure:(void (^)(NSUInteger code,NSString *errorStr))failure {
    [HUZNetWorkTool huz_POSTWithForm:kUrl_volunteerBatchList parameters:@{} success:^(id  _Nonnull responseObject) {
        HUZLOG(@"批次list %@", responseObject);
        HUZBatchModel *model = [HUZBatchModel modelWithJSON:responseObject];
        if ([model isSuccess]) {
            success(model);
        }else{
            failure(model.code,model.msg);
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        failure(statusCode,NETERROR);
    }];
}

/**
 我的成绩分析
 */
+ (void)getVolunteerScoreAnalysisWithParamters:(NSDictionary *)parameters
                                       success:(void (^)(HUZGradeAnalyzeModel *model))success
                                       failure:(void (^)(NSUInteger code,NSString *errorStr))failure {
    [HUZNetWorkTool huz_POST:kUrl_volunteerScoreAnalysis parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZLOG(@"我的成绩分析 %@", responseObject);
        HUZGradeAnalyzeModel *gaModel = [HUZGradeAnalyzeModel modelWithJSON:responseObject];
        if ([gaModel isSuccess]) {
            success(gaModel);
        }else{
            failure(gaModel.code,gaModel.msg);
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        failure(statusCode,NETERROR);
    }];
}

/**
 智能筛选
 */
+ (void)getVolunteerIntelligenceScreenWithParamters:(NSDictionary *)parameters
                                            success:(void (^)(HUZVolunteerFillDataModel *volunteerFill))success
                                            failure:(void (^)(NSUInteger code,NSString *errorStr))failure {
    [HUZNetWorkTool huz_POST:kUrl_volunteerIntelligenceScreen parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZLOG(@"智能筛选 %@", responseObject);
        HUZVolunteerFillDataModel *model = [HUZVolunteerFillDataModel modelWithJSON:responseObject];
        if ([model isSuccess]) {
            success(model);
        }else{
            failure(model.code,model.msg);
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        failure(statusCode,NETERROR);
    }];
}

/**
 智能生成志愿表
 */
+ (void)getVolunteerIntelligenceTestFormWithParamters:(NSDictionary *)parameters
                                              success:(void (^)(HUZIntelligenceFormDataModel *formModel))success
                                              failure:(void (^)(NSUInteger code,NSString *errorStr))failure
{
    [HUZNetWorkTool huz_POST:kUrl_volunteerIntelligenceTest parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZLOG(@"生成志愿表: %@", responseObject);
        HUZIntelligenceFormDataModel *model = [HUZIntelligenceFormDataModel modelWithJSON:responseObject];
        if ([model isSuccess]) {
            success(model);
        }else{
            failure(model.code,model.msg);
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        failure(statusCode,NETERROR);
    }];
}

/**
 志愿表详情
 */
+ (void)getVolunteerIntelligenceTestFormDetailWithParamters:(NSDictionary *)parameters
                                              success:(void (^)(HUZIntelligenceDetailModel *detailModel))success
                                              failure:(void (^)(NSUInteger code,NSString *errorStr))failure
{
//    [HUZNetWorkTool huz_POST:kUrl_volunteerVolunteerDetailInfo parameters:parameters success:^(id  _Nonnull responseObject) {
//        HUZLOG(@"志愿表详情: %@", responseObject);
//        HUZIntelligenceDetailModel *model = [HUZIntelligenceDetailModel modelWithJSON:responseObject];
//        if ([model isSuccess]) {
//            success(model);
//        }else{
//            failure(model.code,model.msg);
//        }
//    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
//
//    }];
    [HUZNetWorkTool huz_POSTWithForm:kUrl_volunteerVolunteerDetailInfo parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZLOG(@"志愿表详情: %@", responseObject);
        HUZIntelligenceDetailModel *model = [HUZIntelligenceDetailModel modelWithJSON:responseObject];
        if ([model isSuccess]) {
            success(model);
        }else{
            failure(model.code,model.msg);
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        failure(statusCode,NETERROR);
    }];
    
}
/**
 院校优先报名
 */
+ (void)getVolunteerPriorityApplicationWithParamters:(NSDictionary *)parameters
                                             success:(void(^)(HUZVolunteerPriorityUni *volunteerPriorityUni))success
                                             failure:(void (^)(NSUInteger code,NSString *errorStr))failure {

    [HUZNetWorkTool huz_POST:kUrl_volunteerPriorityApplication parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZLOG(@"院校优先报名: %@", responseObject);
        HUZVolunteerPriorityUni *model = [HUZVolunteerPriorityUni modelWithJSON:responseObject];
        if ([model isSuccess]) {
            success(model);
        }else{
            failure(model.code,model.msg);
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        failure(statusCode,NETERROR);
    }];
}

/**
 院校优先报名---学校页面
 */
+ (void)getVolunteerSchoolsIsMajor:(BOOL)isMajor WithParamters:(NSDictionary *)parameters
                                             success:(void(^)(HUZVoluntPriorityModel *_Nonnull priorityModel))success
                                             failure:(void (^)(NSUInteger code,NSString *errorStr))failure {
    NSString *url;
    if (isMajor) {
        url = KUrl_volunteerMajorUniversitySelect;
    }else{
        url = kUrl_volunteerSchoolApplicationTest;//@"/api/volunteer/SchoolApplication";//

    }
    
    [HUZNetWorkTool huz_POST:url parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZLOG(@"院校优先报名---学校: %@", responseObject);
        HUZVoluntPriorityModel *model = [HUZVoluntPriorityModel modelWithJSON:responseObject];
        if ([model isSuccess]) {
            success(model);
        }else{
            failure(model.code,model.msg);
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        failure(statusCode,NETERROR);
    }];
}

// 根据学校获取专业
+ (void)getVoluntaryAccordingSchoolWithID:(NSString *)ID
                                         success:(void(^)(HUZVoluntaryModel *voluntaryModel))success
                                         failure:(void (^)(NSUInteger code,NSString *errorStr))failure {
    NSString *url = [NSString stringWithFormat:@"%@%@",kUrl_volunteerVoluntaryID, ID];
    [HUZNetWorkTool huz_GET:url parameters:@{} success:^(id  _Nonnull responseObject) {
        HUZLOG(@"根据学校获取专业 %@", responseObject);
        HUZVoluntaryModel *model = [HUZVoluntaryModel modelWithJSON:responseObject];
        if ([model isSuccess]) {
            success(model);
        }else{
            failure(model.code,model.msg);
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        failure(statusCode,NETERROR);
    }];
}

/**
 添加到备选志愿
 */
+ (void)saveAlternativeWithParamters:(NSDictionary *)parameters
                             success:(void (^)(NSString *success))success
                             failure:(void (^)(NSUInteger code,NSString *errorStr))failure {
    [HUZNetWorkTool huz_POST:kUrl_volunteer_saveAlternative parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZLOG(@"添加到备选志愿 %@", responseObject);
        HUZVolunteerModel *model = [HUZVolunteerModel modelWithJSON:responseObject];
        if ([model isSuccess]) {
            success(model.msg);
        }else{
            failure(model.code,model.msg);
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        failure(statusCode,NETERROR);
    }];
}

// 添加到我的志愿

+ (void)saveVolunteerWithParamters:(NSDictionary *)parameters
                           success:(void (^)(NSString *success))success
                           failure:(void (^)(NSUInteger code,NSString *errorStr))failure {
    [HUZNetWorkTool huz_POST:kUrl_volunteer_saveVolunteer parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZLOG(@"添加到备选志愿 %@", responseObject);
        HUZModel *model = [HUZModel modelWithJSON:responseObject];
        if ([model isSuccess]) {
            success(model.msg);
        }else{
            failure(model.code,model.msg);
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        failure(statusCode,NETERROR);
    }];
}

// 我的备选志愿
+ (void)getVolunteerVoluntaryWithParamters:(NSDictionary *)parameters
                                   success:(void(^)(HUZPacketVolModel *packVolModel))success
                                   failure:(void (^)(NSUInteger code,NSString *errorStr))failure {
    /*
    [HUZNetWorkTool huz_POST:kUrl_volunteerVoluntary parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZLOG(@"我的备选志愿 %@", responseObject);
        HUZPacketVolModel *model = [HUZPacketVolModel modelWithJSON:responseObject];
        if ([model isSuccess]) {
            success(model);
        }else{
            failure(model.code,model.msg);
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        failure(statusCode,NETERROR);
    }];
    */
    [HUZNetWorkTool huz_POSTWithForm:kUrl_volunteerVoluntary parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZLOG(@"我的备选志愿 %@", responseObject);
        HUZPacketVolModel *model = [HUZPacketVolModel modelWithJSON:responseObject];
        if ([model isSuccess]) {
            success(model);
        }else{
            failure(model.code,model.msg);
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        failure(statusCode,NETERROR);
    }];
    
}

/// 志愿表列表
+ (void)getVolunteerListWithParamters:(NSDictionary *)parameters
                              success:(void(^)(HUZVolunteerModel *volunteerModel))success
                              failure:(void (^)(NSUInteger code,NSString *errorStr))failure {
    [HUZNetWorkTool huz_POST:kUrl_volunteerList parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZVolunteerModel *model = [HUZVolunteerModel modelWithJSON:responseObject];
        if ([model isSuccess]) {
            success(model);
        }else{
            failure(model.code,model.msg);
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        failure(statusCode,NETERROR);
    }];
}

/// 删除志愿表
+ (void)delVolunteerWithParamters:(NSDictionary *)parameters
                          success:(void (^)(NSString *success))success
                          failure:(void (^)(NSUInteger code,NSString *errorStr))failure {
    [HUZNetWorkTool huz_GET:kUrl_volunteerDel parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZModel *model = [HUZModel modelWithJSON:responseObject];
        if ([model isSuccess]) {
            success(model.msg);
        }else{
            failure(model.code,model.msg);
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        failure(statusCode,NETERROR);
    }];
}

/// 根据专业获取大学信息
+ (void)getMajorUniversityWithParamters:(NSDictionary *)parameters
                                success:(void (^)(HUZMajorPriorityDataModel * _Nonnull dataModel))success
                                failure:(void (^)(NSUInteger code,NSString *errorStr))failure {
    [HUZNetWorkTool huz_POST:kUrl_volunteerMajorUniversity parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZMajorPriorityDataModel *model = [HUZMajorPriorityDataModel modelWithJSON:responseObject];
        if ([model isSuccess]) {
            success(model);
        }else{
            failure(model.code,model.msg);
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        failure(statusCode,NETERROR);
    }];
}

/// 根据专业筛选大学信息
+ (void)getUniversityWithMajorParamters:(NSDictionary *)parameters
                                success:(void (^)(HUZMajorPriorityDataModel * _Nonnull dataModel))success
                                failure:(void (^)(NSUInteger code,NSString *errorStr))failure {
    [HUZNetWorkTool huz_POST:KUrl_volunteerMajorUniversitySelect parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZMajorPriorityDataModel *model = [HUZMajorPriorityDataModel modelWithJSON:responseObject];
        if ([model isSuccess]) {
            success(model);
        }else{
            failure(model.code,model.msg);
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        failure(statusCode,NETERROR);
    }];
}

/// 大学列表
+ (void)getUniversitiesWithParamters:(NSDictionary *)parameters
                                success:(void (^)(HUZSchoolListDataModel * _Nonnull dataModel))success
                                failure:(void (^)(NSUInteger code,NSString *errorStr))failure {
    [HUZNetWorkTool huz_POST:kUrl_volunteerSelectSchoolAll parameters:parameters success:^(id  _Nonnull responseObject) {
        NSLog(@"大学列表信息：%@",responseObject);
        HUZSchoolListDataModel *model = [HUZSchoolListDataModel modelWithJSON:responseObject];
        if ([model isSuccess]) {
            success(model);
        }else{
            failure(model.code,model.msg);
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        failure(statusCode,NETERROR);
    }];
}
@end

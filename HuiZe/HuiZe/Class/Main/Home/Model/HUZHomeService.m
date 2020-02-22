//
//  HUZHomeService.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/9.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZHomeService.h"

/// 大学概况
NSString * const KUrl_UniInfoGeneralize= @"/api/searchUniversity/getSchoolGeneralize";
/// 填报判断批次
NSString * const KUrl_JudgeBatch = @"/api/volunteer/judge/batch";

@implementation HUZHomeService

/**
 关键字搜索
 */
+ (void)getSearchKeyword:(NSDictionary *)parameters
                 success:(void(^)(HUZSearchKeywordModel *))success
                 failure:(void (^)(NSUInteger code,NSString *errorStr))failure{
    [HUZNetWorkTool huz_POST:KUrl_SearchKeyword parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZSearchKeywordModel *model = [HUZSearchKeywordModel modelWithJSON:responseObject];
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
 搜索大学
 */
+ (void)getSearchUniList:(NSDictionary *)parameters
                 success:(void(^)(HUZSearchUniModel *))success
                 failure:(void (^)(NSUInteger code,NSString *errorStr))failure{
    [HUZNetWorkTool huz_POST:KUrl_searchUniList parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZSearchUniModel *model = [HUZSearchUniModel modelWithJSON:responseObject];
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
 搜索专业
 */
+ (void)getSearchMajorList:(NSDictionary *)parameters
                   success:(void(^)(HUZSearchMajorModel *))success
                   failure:(void (^)(NSUInteger code,NSString *errorStr))failure{
    [HUZNetWorkTool huz_POST:KUrl_searchMajorList parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZSearchMajorModel *model = [HUZSearchMajorModel modelWithJSON:responseObject];
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
 banner图
 */
+ (void)getBanner:(NSDictionary *)parameters
          success:(void(^)(HUZBannerModel *))success
          failure:(void (^)(NSUInteger code,NSString *errorStr))failure{
    [HUZNetWorkTool huz_GET:KUrl_Banner parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZBannerModel *model = [HUZBannerModel modelWithJSON:responseObject];
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
 高考资讯列表
 */

+ (void)getGkInfoList:(NSDictionary *)parameters
              success:(void (^)(HUZGkInfoModel * _Nonnull))success
              failure:(void (^)(NSUInteger, NSString * _Nonnull))failure{
    [HUZNetWorkTool huz_POST:KUrl_GkInfoList parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZGkInfoModel *model = [HUZGkInfoModel modelWithDictionary:responseObject];
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
 一分一段
 */
+ (void)getScoreSection:(NSDictionary *)parameters
                success:(void(^)(HUZKernalScoreSectionModel *))success
                failure:(void (^)(NSUInteger code,NSString *errorStr))failure{
    [HUZNetWorkTool huz_GET:KUrl_ScoreSection parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZKernalScoreSectionModel *model = [HUZKernalScoreSectionModel modelWithJSON:responseObject];
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
 分数线
 */
+ (void)getScoreLine:(NSDictionary *)parameters
             success:(void(^)(HUZKernalScoreLineModel *))success
             failure:(void (^)(NSUInteger code,NSString *errorStr))failure{
    [HUZNetWorkTool huz_GET:KUrl_Scoreline parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZKernalScoreLineModel *model = [HUZKernalScoreLineModel modelWithJSON:responseObject];
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
 投档线列表
 */
+ (void)getDroplineList:(NSDictionary *)parameters
                success:(void(^)(HUZKernalDroplineModel *))success
                failure:(void (^)(NSUInteger code,NSString *errorStr))failure{
    [HUZNetWorkTool huz_POST:KUrl_DroplineList parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZKernalDroplineModel *model = [HUZKernalDroplineModel modelWithJSON:responseObject];
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
 录取线列表
 */
+ (void)getEnterlineList:(NSDictionary *)parameters
                 success:(void(^)(HUZKernalEnterlineModel *))success
                 failure:(void (^)(NSUInteger code,NSString *errorStr))failure{
    [HUZNetWorkTool huz_POST:KUrl_EnterlineList parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZKernalEnterlineModel *model = [HUZKernalEnterlineModel modelWithJSON:responseObject];
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
 报考指南信息
 */
+ (void)getRegisterGuideList:(NSDictionary *)parameters
                     success:(void(^)(HUZRegisterGuideModel *))success
                     failure:(void (^)(NSUInteger code,NSString *errorStr))failure{
    [HUZNetWorkTool huz_POST:KUrl_RegisterGude parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZRegisterGuideModel *model = [HUZRegisterGuideModel modelWithJSON:responseObject];
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
 常识百科
 */
+ (void)getCommonSense:(NSDictionary *)parameters
               success:(void(^)(HUZCommonSenseModel *))success
               failure:(void (^)(NSUInteger code,NSString *errorStr))failure{
    [HUZNetWorkTool huz_POST:KUrl_CommonSense parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZCommonSenseModel *model = [HUZCommonSenseModel modelWithJSON:responseObject];
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
 招生计划---历年招录数据
 */
+ (void)getStudentPlanData:(NSDictionary *)parameters
                   success:(void(^)(HUZStudentPlanModel *))success
                   failure:(void (^)(NSUInteger code,NSString *errorStr))failure{
    [HUZNetWorkTool huz_POST:KUrl_studentPlan parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZStudentPlanModel *model = [HUZStudentPlanModel modelWithJSON:responseObject];
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
 高考动态
 */
+ (void)getGkDynamicList:(NSDictionary *)parameters
                 success:(void(^)(HUZGkInfoModel *))success
                 failure:(void (^)(NSUInteger code,NSString *errorStr))failure{
    [HUZNetWorkTool huz_POST:KUrl_GkDynamicList parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZGkInfoModel *model = [HUZGkInfoModel modelWithJSON:responseObject];
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
 政策解读
 */
+ (void)getPolicyList:(NSDictionary *)parameters
              success:(void(^)(HUZPolicyListModel *))success
              failure:(void (^)(NSUInteger code,NSString *errorStr))failure{
    [HUZNetWorkTool huz_POST:KUrl_PolicyList parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZPolicyListModel *model = [HUZPolicyListModel modelWithJSON:responseObject];
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
 推荐院校
 */
+ (void)getRecommendUni:(NSDictionary *)parameters
                success:(void(^)(HUZRecommendUniModel *))success
                failure:(void (^)(NSUInteger code,NSString *errorStr))failure{
    [HUZNetWorkTool huz_POST:KUrl_RecommendUni parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZRecommendUniModel *model = [HUZRecommendUniModel modelWithJSON:responseObject];
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
 推荐院校集合
*/
+ (void)getRecommendUniList:(NSDictionary *)parameters
                    success:(void(^)(HUZRecommendUniListModel *))success
                    failure:(void (^)(NSUInteger code,NSString *errorStr))failure{
    [HUZNetWorkTool huz_POST:KUrl_RecommendUniList parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZRecommendUniListModel *model = [HUZRecommendUniListModel modelWithJSON:responseObject];
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
 推荐专业
 */
+ (void)getRecommendMajor:(NSDictionary *)parameters
                  success:(void(^)(HUZRecommendMajorModel *))success
                  failure:(void (^)(NSUInteger code,NSString *errorStr))failure{
    [HUZNetWorkTool huz_POST:KUrl_New_RecommendMajor parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZRecommendMajorModel *model = [HUZRecommendMajorModel modelWithJSON:responseObject];
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
 推荐专业集合
 */
+ (void)getRecommendMajorList:(NSDictionary *)parameters
                      success:(void(^)(HUZUlikeMajorModel *))success
                      failure:(void (^)(NSUInteger code,NSString *errorStr))failure{
    [HUZNetWorkTool huz_POST:KUrl_RecommendMajorList parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZUlikeMajorModel *model = [HUZUlikeMajorModel modelWithJSON:responseObject];
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
 查专业---带你喜欢
 */
+ (void)getULikeList:(NSDictionary *)parameters
             success:(void(^)(HUZUlikeMajorModel *))success
             failure:(void (^)(NSUInteger code,NSString *errorStr))failure{
    [HUZNetWorkTool huz_POST:KUrl_uLikeList parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZUlikeMajorModel *model = [HUZUlikeMajorModel modelWithJSON:responseObject];
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
 查专业---名企热招
 */
+ (void)getHotList:(NSDictionary *)parameters
           success:(void(^)(HUZUlikeMajorModel *))success
           failure:(void (^)(NSUInteger code,NSString *errorStr))failure{
    [HUZNetWorkTool huz_POST:KUrl_hotList parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZUlikeMajorModel *model = [HUZUlikeMajorModel modelWithJSON:responseObject];
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
 查询专业目录 type:专科为1，本科为2
 */
+ (void)getAllMajorCategory:(NSString *)type
                    success:(void (^)(HUZAllMajorModel * _Nonnull))success
                    failure:(void (^)(NSUInteger, NSString * _Nonnull))failure{
    [HUZNetWorkTool huz_GET:[NSString stringWithFormat:@"%@/%@",KUrl_allMajorCategory,type] parameters:@{} success:^(id  _Nonnull responseObject) {
        HUZAllMajorModel *model = [HUZAllMajorModel modelWithJSON:responseObject];
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
 查专业搜索 type:专科为1，本科为2
 */
+ (void)getSearchMajorByKey:(NSDictionary *)parameters
                    success:(void(^)(HUZSearchAllMajorModel *))success
                    failure:(void (^)(NSUInteger code,NSString *errorStr))failure{
    [HUZNetWorkTool huz_POST:KUrl_seachMajorByKey parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZSearchAllMajorModel *model = [HUZSearchAllMajorModel modelWithJSON:responseObject];
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
 查大学--猜你喜欢
 */
+ (void)getSearchUniUlike:(NSDictionary *)parameters
                  success:(void(^)(HUZSearchUlikeUniModel *))success
                  failure:(void (^)(NSUInteger code,NSString *errorStr))failure{
    [HUZNetWorkTool huz_POST:KUrl_searchUniUlike parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZSearchUlikeUniModel *model = [HUZSearchUlikeUniModel modelWithJSON:responseObject];
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
 查大学--名企热招
 */
+ (void)getSearchUniHot:(NSDictionary *)parameters
                success:(void(^)(HUZSearchUlikeUniModel *))success
                failure:(void (^)(NSUInteger code,NSString *errorStr))failure{
    [HUZNetWorkTool huz_POST:KUrl_searchUniHot parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZSearchUlikeUniModel *model = [HUZSearchUlikeUniModel modelWithJSON:responseObject];
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
 查大学---全部高校，本省高校
 */
+ (void)getSearchAllUniList:(NSDictionary *)parameters
                    success:(void(^)(HUZSearchUlikeUniModel *))success
                    failure:(void (^)(NSUInteger code,NSString *errorStr))failure{
    [HUZNetWorkTool huz_POST:KUrl_searchAllUniList parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZSearchUlikeUniModel *model = [HUZSearchUlikeUniModel modelWithJSON:responseObject];
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
 大学详情--毕业去向--前景概况
 */
+ (void)getGeneralize:(NSDictionary *)parameters
              success:(void(^)(HUZGeneralizeModel *))success
              failure:(void (^)(NSUInteger code,NSString *errorStr))failure{
    [HUZNetWorkTool huz_POST:KUrl_Generalize parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZGeneralizeModel *model = [HUZGeneralizeModel modelWithJSON:responseObject];
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
 大学详情--毕业去向--行业去向
 */
+ (void)getIndustyLea:(NSDictionary *)parameters
              success:(void(^)(HUZIndustyLeaModel *))success
              failure:(void (^)(NSUInteger code,NSString *errorStr))failure{
    [HUZNetWorkTool huz_POSTWithForm:KUrl_IndustryLea parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZIndustyLeaModel *model = [HUZIndustyLeaModel modelWithJSON:responseObject];
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
 大学详情--毕业去向--地区去向
 */
+ (void)getRegionLea:(NSDictionary *)parameters
             success:(void(^)(HUZAreaLeaModel *))success
             failure:(void (^)(NSUInteger code,NSString *errorStr))failure{
    [HUZNetWorkTool huz_POST:KUrl_RegionLea parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZAreaLeaModel *model = [HUZAreaLeaModel modelWithJSON:responseObject];
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
 大学详情头部信息
 */
+ (void)getUniHeaderInfo:(NSString *)schoolId
                 success:(void(^)(HUZUniInfoModel *))success
                 failure:(void (^)(NSUInteger code,NSString *errorStr))failure{
    [HUZNetWorkTool huz_GET:[NSString stringWithFormat:@"%@/%@",KUrl_UniInfo,schoolId] parameters:@{} success:^(id  _Nonnull responseObject) {
        HUZUniInfoModel *model = [HUZUniInfoModel modelWithJSON:responseObject];
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
 根据id查大学概括
 */
+ (void)getUniInfoGeneralize:(NSString *)schoolId
                     success:(void (^)(HUZUniInfoGeneralizeModel *))success
                     failure:(void (^)(NSUInteger code,NSString *errorStr))failure{
    [HUZNetWorkTool huz_GET:[NSString stringWithFormat:@"%@/%@",KUrl_UniInfoGeneralize,schoolId] parameters:@{} success:^(id  _Nonnull responseObject) {
        HUZUniInfoGeneralizeModel *model = [HUZUniInfoGeneralizeModel modelWithJSON:responseObject];
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
 填报判断批次(获取批次)
 */
 + (void)getBatch:(NSDictionary *)parameters
           success:(void(^)(HUZJudgeBatchModel * model))success
           failure:(void (^)(NSUInteger code,NSString *errorStr))failure{
    [HUZNetWorkTool huz_POST:KUrl_JudgeBatch parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZJudgeBatchModel *model = [HUZJudgeBatchModel modelWithJSON:responseObject];
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

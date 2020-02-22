//
//  HUZHomeService.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/9.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HUZBannerModel.h"
#import "HUZGkInfoModel.h"
#import "HUZKernalScoreSectionModel.h"
#import "HUZKernalScoreLineModel.h"
#import "HUZKernalDroplineModel.h"
#import "HUZKernalEnterlineModel.h"
#import "HUZRegisterGuideModel.h"
#import "HUZCommonSenseModel.h"
#import "HUZStudentPlanModel.h"
#import "HUZPolicyListModel.h"
#import "HUZRecommendUniModel.h"
#import "HUZRecommendMajorModel.h"
#import "HUZSearchKeywordModel.h"
#import "HUZSearchUniModel.h"
#import "HUZSearchMajorModel.h"
#import "HUZUlikeMajorModel.h"
#import "HUZAllMajorModel.h"
#import "HUZSearchAllMajorModel.h"
#import "HUZSearchUlikeUniModel.h"
#import "HUZRecommendUniListModel.h"
#import "HUZGeneralizeModel.h"
#import "HUZIndustyLeaModel.h"
#import "HUZAreaLeaModel.h"
#import "HUZUniInfoModel.h"
#import "HUZUniInfoGeneralizeModel.h"
#import "HUZJudgeBatchModel.h"

NS_ASSUME_NONNULL_BEGIN

/// 大学概况
extern NSString * const KUrl_UniInfoGeneralize;
/// 填报判断批次(获取批次)
extern NSString * const KUrl_JudgeBatch;

@interface HUZHomeService : NSObject

/**
 关键字搜索
 */
+ (void)getSearchKeyword:(NSDictionary *)parameters
                 success:(void(^)(HUZSearchKeywordModel *))success
                 failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 搜索大学
 */
+ (void)getSearchUniList:(NSDictionary *)parameters
                 success:(void(^)(HUZSearchUniModel *))success
                 failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 搜索专业
 */
+ (void)getSearchMajorList:(NSDictionary *)parameters
                   success:(void(^)(HUZSearchMajorModel *))success
                   failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 banner图
 */
+ (void)getBanner:(NSDictionary *)parameters
          success:(void(^)(HUZBannerModel *))success
          failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 高考资讯列表
 */
+ (void)getGkInfoList:(NSDictionary *)parameters
              success:(void(^)(HUZGkInfoModel *))success
              failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 一分一段
 */
+ (void)getScoreSection:(NSDictionary *)parameters
                success:(void(^)(HUZKernalScoreSectionModel *))success
                failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 分数线
 */
+ (void)getScoreLine:(NSDictionary *)parameters
                success:(void(^)(HUZKernalScoreLineModel *))success
                failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 投档线列表
 */
+ (void)getDroplineList:(NSDictionary *)parameters
             success:(void(^)(HUZKernalDroplineModel *))success
             failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 录取线列表
 */
+ (void)getEnterlineList:(NSDictionary *)parameters
                 success:(void(^)(HUZKernalEnterlineModel *))success
                 failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 报考指南信息
 */
+ (void)getRegisterGuideList:(NSDictionary *)parameters
                 success:(void(^)(HUZRegisterGuideModel *))success
                 failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 常识百科
 */
+ (void)getCommonSense:(NSDictionary *)parameters
               success:(void(^)(HUZCommonSenseModel *))success
               failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 招生计划---历年招录数据
 */
+ (void)getStudentPlanData:(NSDictionary *)parameters
                   success:(void(^)(HUZStudentPlanModel *))success
                   failure:(void (^)(NSUInteger code,NSString *errorStr))failure;
/**
 高考动态
 */
+ (void)getGkDynamicList:(NSDictionary *)parameters
                 success:(void(^)(HUZGkInfoModel *))success
                 failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 政策解读
 */
+ (void)getPolicyList:(NSDictionary *)parameters
              success:(void(^)(HUZPolicyListModel *))success
              failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 推荐院校
 */
+ (void)getRecommendUni:(NSDictionary *)parameters
                success:(void(^)(HUZRecommendUniModel *))success
                failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 推荐院校集合
 */
+ (void)getRecommendUniList:(NSDictionary *)parameters
                    success:(void(^)(HUZRecommendUniListModel *))success
                    failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 推荐专业
 */
+ (void)getRecommendMajor:(NSDictionary *)parameters
                  success:(void(^)(HUZRecommendMajorModel *))success
                  failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 推荐专业集合
 */
+ (void)getRecommendMajorList:(NSDictionary *)parameters
                      success:(void(^)(HUZUlikeMajorModel *))success
                      failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 查专业---带你喜欢
 */
+ (void)getULikeList:(NSDictionary *)parameters
             success:(void(^)(HUZUlikeMajorModel *))success
             failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 查专业---名企热招
 */
+ (void)getHotList:(NSDictionary *)parameters
           success:(void(^)(HUZUlikeMajorModel *))success
           failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 查询专业目录 type:专科为1，本科为2
 */
+ (void)getAllMajorCategory:(NSString *)type
                    success:(void(^)(HUZAllMajorModel *))success
                    failure:(void (^)(NSUInteger code,NSString *errorStr))failure;


/**
  查专业搜索 type:专科为1，本科为2
 */
+ (void)getSearchMajorByKey:(NSDictionary *)parameters
                    success:(void(^)(HUZSearchAllMajorModel *))success
                    failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 查大学--猜你喜欢
 */
+ (void)getSearchUniUlike:(NSDictionary *)parameters
                  success:(void(^)(HUZSearchUlikeUniModel *))success
                  failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 查大学--名企热招
 */
+ (void)getSearchUniHot:(NSDictionary *)parameters
                  success:(void(^)(HUZSearchUlikeUniModel *))success
                  failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 查大学---全部高校，本省高校
 */
+ (void)getSearchAllUniList:(NSDictionary *)parameters
                    success:(void(^)(HUZSearchUlikeUniModel *))success
                    failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 大学详情--毕业去向--前景概况
 */
+ (void)getGeneralize:(NSDictionary *)parameters
              success:(void(^)(HUZGeneralizeModel *))success
              failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 大学详情--毕业去向--行业去向
 */
+ (void)getIndustyLea:(NSDictionary *)parameters
              success:(void(^)(HUZIndustyLeaModel *))success
              failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 大学详情--毕业去向--地区去向
 */
+ (void)getRegionLea:(NSDictionary *)parameters
             success:(void(^)(HUZAreaLeaModel *))success
             failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 大学详情头部信息
 */
+ (void)getUniHeaderInfo:(NSString *)schoolId
                 success:(void(^)(HUZUniInfoModel *))success
                 failure:(void (^)(NSUInteger code,NSString *errorStr))failure;


/**
 根据id查大学概括
 */
+ (void)getUniInfoGeneralize:(NSString *)schoolId
                     success:(void (^)(HUZUniInfoGeneralizeModel *))success
                     failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 填报判断批次(获取批次)
 */
+ (void)getBatch:(NSDictionary *)parameters
         success:(void(^)(HUZJudgeBatchModel *model))success
         failure:(void (^)(NSUInteger code,NSString *errorStr))failure;
@end

NS_ASSUME_NONNULL_END

//
//  HUZFriendService.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/7.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZFriendService.h"

@implementation HUZFriendService

/**
 朋友圈-获取分类列表
 */
+ (void)getFriendReleaseType:(NSDictionary *)parameters
                     success:(void (^)(HUZFriendReleaseTypeModel * _Nonnull))success
                     failure:(void (^)(NSUInteger, NSString * _Nonnull))failure{
    [HUZNetWorkTool huz_GET:KUrl_friendReleaseType parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZFriendReleaseTypeModel *model = [HUZFriendReleaseTypeModel modelWithJSON:responseObject];
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
 根据类型查询普通帖子
 */
+ (void)getFriendList:(NSDictionary *)parameters
              success:(void (^)(HUZFriendListModel * _Nonnull))success
              failure:(void (^)(NSUInteger, NSString * _Nonnull))failure{
    [HUZNetWorkTool huz_POST:KUrl_friendList parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZFriendListModel *model = [HUZFriendListModel modelWithJSON:responseObject];
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
 根据类型查询加精帖子
 */
+ (void)getFriendRefinementList:(NSDictionary *)parameters
                        success:(void(^)(HUZFriendListModel *))success
                        failure:(void(^)(NSUInteger code, NSString *errorStr))failure{
    [HUZNetWorkTool huz_POST:KUrl_friendRefinementList parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZFriendListModel *model = [HUZFriendListModel modelWithJSON:responseObject];
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
 帖子详情
 */
+ (void)getFriendReleaseData:(NSDictionary *)parameters
                     success:(void(^)(HUZFriendReleaseDataModel *))success
                     failure:(void(^)(NSUInteger code, NSString *errorStr))failure{
    [HUZNetWorkTool huz_GET:KUrl_friendReleaseData parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZFriendReleaseDataModel *model = [HUZFriendReleaseDataModel modelWithJSON:responseObject];
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
 发布新帖
 */
+ (void)getFriendSave:(NSDictionary *)parameters
              success:(void (^)(HUZModel * _Nonnull))success
              failure:(void (^)(NSUInteger, NSString * _Nonnull))failure{
//    [HUZNetWorkTool huz_POSTWithForm:KUrl_friendSave parameters:parameters success:^(id  _Nonnull responseObject) {
//        HUZModel *model = [HUZModel modelWithJSON:responseObject];
//        if ([model isSuccess]) {
//            success(model);
//        }else{
//            failure(model.code,model.msg);
//        }
//    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
//        failure(statusCode,NETERROR);
//    }];
//
    [HUZNetWorkTool huz_POST:KUrl_friendSave parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZModel *model = [HUZModel modelWithJSON:responseObject];
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
 根据帖子id查询评论内容
 */
+ (void)getFriendCommentList:(NSDictionary *)parameters
                     success:(void(^)(HUZFriendCommentModel *))success
                     failure:(void(^)(NSUInteger code, NSString *errorStr))failure{
    [HUZNetWorkTool huz_POST:KUrl_friendCommentList parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZFriendCommentModel *model = [HUZFriendCommentModel modelWithJSON:responseObject];
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
 点赞
 */
+ (void)getPostLike:(NSDictionary *)parameters
            success:(void(^)(HUZModel *))success
            failure:(void(^)(NSUInteger code, NSString *errorStr))failure{
    [HUZNetWorkTool huz_POSTWithForm:KUrl_like parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZModel *model = [HUZModel modelWithJSON:responseObject];
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
 评论
 */
+ (void)getCommitComment:(NSDictionary *)parameters
                 success:(void(^)(HUZModel *))success
                 failure:(void(^)(NSUInteger code, NSString *errorStr))failure{
//    [HUZNetWorkTool huz_POSTWithForm:KUrl_comment parameters:parameters success:^(id  _Nonnull responseObject) {
//        HUZModel *model = [HUZModel modelWithJSON:responseObject];
//        if ([model isSuccess]) {
//            success(model);
//        }else{
//            failure(model.code,model.msg);
//        }
//    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
//        failure(statusCode,NETERROR);
//    }];
    
    [HUZNetWorkTool huz_POST:KUrl_comment parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZModel *model = [HUZModel modelWithJSON:responseObject];
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

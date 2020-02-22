//
//  HUZMineService.m
//  HuiZe
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZMineService.h"
#import "HUZUser.h"

@implementation HUZMineService

/**
 查询用户是否有设置密码
 */
+ (void)getUserMsgInfoWithSuccess:(void (^)(HUZMyUser *object))success
                          failure:(void (^)(NSUInteger code,NSString *errorStr))failure {
    [HUZNetWorkTool huz_POST:kUrl_userInfo parameters:@{} success:^(id  _Nonnull responseObject) {
        HUZLOG(@"个人中心 - 用户信息 %@", responseObject);
        HUZMyUser *model = [HUZMyUser modelWithJSON:responseObject];
        if ([model isSuccess]) {
            if (success) {
                success(model);
            }
        } else {
            if (failure) {
                failure(model.code,model.msg);
            }
        }
    } failure:^(NSUInteger statusCode, NSString *error) {
        if (failure) {
            failure(statusCode,NETERROR);
        }
    }];
}

/// 设置密码
+ (void)getUpdatePasswordWithParameters:(NSDictionary *)parameters
                                success:(void (^)(NSString *success))success
                                failure:(void (^)(NSUInteger code,NSString *errorStr))failure {
    [HUZNetWorkTool huz_POST:kUrl_updatePassword parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZModel *model = [HUZModel modelWithJSON:responseObject];
        if ([model isSuccess]) {
            if (success) {
                success(model.msg);
            }
        } else {
            if (failure) {
                failure(model.code,model.msg);
            }
        }
    } failure:^(NSUInteger statusCode, NSString *error) {
        if (failure) {
            failure(statusCode,NETERROR);
        }
    }];
}

/// 修改个人信息
+ (void)getUpdateDetailsWithParameters:(NSDictionary *)parameters
                               success:(void (^)(NSString *success))success
                               failure:(void (^)(NSUInteger code,NSString *errorStr))failure {
    [HUZNetWorkTool huz_POST:kUrl_updatedetails parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZModel *model = [HUZModel modelWithJSON:responseObject];
        if ([model isSuccess]) {
            if (success) {
                success(model.msg);
            }
        } else {
            if (failure) {
                failure(model.code,model.msg);
            }
        }
    } failure:^(NSUInteger statusCode, NSString *error) {
        if (failure) {
            failure(statusCode,NETERROR);
        }
    }];
}
/// 用户关注列表
+ (void)getFollowListWithParameters:(NSDictionary *)parameters
                            success:(void (^)(id model))success
                            failure:(void (^)(NSUInteger code,NSString *errorStr))failure {
    [HUZNetWorkTool huz_POST:kUrl_followlist parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZLOG(@"用户关注列表 %@", responseObject);
        HUZModel *model = [HUZModel modelWithJSON:responseObject];
        if ([model isSuccess]) {
            if (success) {
                success(responseObject);
            }
        } else {
            if (failure) {
                failure(model.code,model.msg);
            }
        }
    } failure:^(NSUInteger statusCode, NSString *error) {
        if (failure) {
            failure(statusCode,NETERROR);
        }
    }];
}

/// 取消关注
+ (void)getFollowDeleteWithFollowId:(NSString *)followId
                              success:(void (^)(NSString *success))success
                              failure:(void (^)(NSUInteger code,NSString *errorStr))failure {
    NSString *url = [NSString stringWithFormat:@"%@/%@",kUrl_followdelete,followId];
    [HUZNetWorkTool huz_GET:url parameters:@{@"followId": followId} success:^(id  _Nonnull responseObject) {
        HUZModel *model = [HUZModel modelWithJSON:responseObject];
        if ([model isSuccess]) {
            if (success) {
                success(model.msg);
            }
        } else {
            if (failure) {
                failure(model.code,model.msg);
            }
        }
    } failure:^(NSUInteger statusCode, NSString *error) {
        if (failure) {
            failure(statusCode,NETERROR);
        }
    }];
}

/// 根据类型关注
+ (void)getSaveFollowWithParameters:(NSDictionary *)parameters
                            success:(void (^)(NSString *success))success
                            failure:(void (^)(NSUInteger code,NSString *errorStr))failure {
    [HUZNetWorkTool huz_POSTWithForm:kUrl_followsave parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZModel *model = [HUZModel modelWithJSON:responseObject];
        if ([model isSuccess]) {
            if (success) {
                success(model.msg);
            }
        } else {
            if (failure) {
                failure(model.code,model.msg);
            }
        }
    } failure:^(NSUInteger statusCode, NSString *error) {
        if (failure) {
            failure(statusCode,NETERROR);
        }
    }];
}

/**
 反馈
 */
+ (void)getFeedBackWithParameters:(NSDictionary *)parameters
                          success:(void(^)(HUZModel *))success
                          failure:(void(^)(NSUInteger code, NSString *errorStr))failure{
    [HUZNetWorkTool huz_POST:KUrl_Feedback parameters:parameters success:^(id  _Nonnull responseObject) {
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
 消息列表
 */
+ (void)getMessageListWithParameters:(NSDictionary *)parameters
                          success:(void(^)(HUZMessageListModel *))success
                          failure:(void(^)(NSUInteger code, NSString *errorStr))failure{
    [HUZNetWorkTool huz_POST:KUrl_UsermessageList parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZMessageListModel *model = [HUZMessageListModel modelWithJSON:responseObject];
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

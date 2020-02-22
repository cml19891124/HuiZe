//
//  HUZMineService.h
//  HuiZe
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HUZMyUser.h"

#import "HUZMessageListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZMineService : NSObject
/**
 查询用户信息
 */
+ (void)getUserMsgInfoWithSuccess:(void (^)(HUZMyUser *object))success
                          failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 设置密码
 */
+ (void)getUpdatePasswordWithParameters:(NSDictionary *)parameters
                                        success:(void (^)(NSString *success))success
                                        failure:(void (^)(NSUInteger code,NSString *errorStr))failure;
/**
 修改个人信息
 */
+ (void)getUpdateDetailsWithParameters:(NSDictionary *)parameters
                                success:(void (^)(NSString *success))success
                                failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 用户关注列表
 */
+ (void)getFollowListWithParameters:(NSDictionary *)parameters
                               success:(void (^)(id model))success
                               failure:(void (^)(NSUInteger code,NSString *errorStr))failure;
/**
 取消关注
 */
+ (void)getFollowDeleteWithFollowId:(NSString *)followId
                            success:(void (^)(NSString *success))success
                            failure:(void (^)(NSUInteger code,NSString *errorStr))failure;
/**
 根据类型关注
 */
+ (void)getSaveFollowWithParameters:(NSDictionary *)parameters
                            success:(void (^)(NSString *success))success
                            failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 反馈
 */
+ (void)getFeedBackWithParameters:(NSDictionary *)parameters
                 success:(void(^)(HUZModel *))success
                 failure:(void(^)(NSUInteger code, NSString *errorStr))failure;

/**
 消息列表
 */
+ (void)getMessageListWithParameters:(NSDictionary *)parameters
                          success:(void(^)(HUZMessageListModel *))success
                          failure:(void(^)(NSUInteger code, NSString *errorStr))failure;
@end

NS_ASSUME_NONNULL_END

//
//  HUZFriendService.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/7.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HUZFriendReleaseTypeModel.h"
#import "HUZFriendListModel.h"
#import "HUZFriendReleaseDataModel.h"
#import "HUZFriendCommentModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface HUZFriendService : NSObject


/**
 朋友圈-获取分类列表
 */
+ (void)getFriendReleaseType:(NSDictionary *)parameters
                     success:(void(^)(HUZFriendReleaseTypeModel *))success
                     failure:(void (^)(NSUInteger code,NSString *errorStr))failure;


/**
 根据类型查询普通帖子
 */
+ (void)getFriendList:(NSDictionary *)parameters
              success:(void(^)(HUZFriendListModel *))success
              failure:(void(^)(NSUInteger code, NSString *errorStr))failure;

/**
 根据类型查询加精帖子
 */
+ (void)getFriendRefinementList:(NSDictionary *)parameters
              success:(void(^)(HUZFriendListModel *))success
              failure:(void(^)(NSUInteger code, NSString *errorStr))failure;

/**
 帖子详情
 */
+ (void)getFriendReleaseData:(NSDictionary *)parameters
                     success:(void(^)(HUZFriendReleaseDataModel *))success
                     failure:(void(^)(NSUInteger code, NSString *errorStr))failure;

/**
 发布新帖
 */
+ (void)getFriendSave:(NSDictionary *)parameters
              success:(void(^)(HUZModel *))success
              failure:(void(^)(NSUInteger code, NSString *errorStr))failure;

/**
 根据帖子id查询评论内容
 */
+ (void)getFriendCommentList:(NSDictionary *)parameters
                     success:(void(^)(HUZFriendCommentModel *))success
                     failure:(void(^)(NSUInteger code, NSString *errorStr))failure;

/**
 点赞
 */
+ (void)getPostLike:(NSDictionary *)parameters
            success:(void(^)(HUZModel *))success
            failure:(void(^)(NSUInteger code, NSString *errorStr))failure;

/**
 评论
 */
+ (void)getCommitComment:(NSDictionary *)parameters
                 success:(void(^)(HUZModel *))success
                 failure:(void(^)(NSUInteger code, NSString *errorStr))failure;

@end

NS_ASSUME_NONNULL_END

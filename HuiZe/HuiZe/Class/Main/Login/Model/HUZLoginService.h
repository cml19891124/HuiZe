//
//  HUZLoginService.h
//  HuiZe
//
//  Created by mac on 2019/5/7.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HUZLoginModel.h"
#import "HUZProvinceModel.h"
#import "HUZMajorListDataModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HUZLoginService : NSObject

/**
 注册
 */
+ (void)getRegisterWithParameters:(NSDictionary *)parameters
                          success:(void (^)(HUZLoginModel *object))success
                          failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 登录
 */
+ (void)getLoginWithParameters:(NSDictionary *)parameters
                       success:(void (^)(HUZLoginModel *object))success
                       failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 发送验证码
 */
+ (void)getSendCodeWithParameters:(NSDictionary *)parameters
                          success:(void (^)(NSString *success))success
                          failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 修改手机发送验证码
 */
+ (void)getFixPhoneSendCodeWithParameters:(NSDictionary *)parameters
                                  success:(void (^)(NSString *success))success
                                  failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 忘记密码发送验证码
 */
+ (void)getForgetPasswordSendCodeWithParameters:(NSDictionary *)parameters
                                        success:(void (^)(NSString *success))success
                                        failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 忘记密码核实验证码
 */
+ (void)getModifyResetPasswordWithParameters:(NSDictionary *)parameters
                                     success:(void (^)(NSString *success))success
                                     failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 重置密码
 */
+ (void)getResetPasswordWithParameters:(NSDictionary *)parameters
                               success:(void (^)(NSString *success))success
                               failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 更换手机
 */
+ (void)getModifyPhoneWithParameters:(NSDictionary *)parameters
                             success:(void (^)(NSString *success))success
                             failure:(void (^)(NSUInteger code,NSString *errorStr))failure;
/**
 第三方登录
 */
+ (void)getThirdLoginWithParameters:(NSDictionary *)parameters url:(NSString *)url
                            success:(void (^)(HUZLoginModel *object))success
                            failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 修改个人信息
 */
+ (void)getUpdateDetailWithParameters:(NSDictionary *)parameters
                                success:(void (^)(NSString *success))success
                                failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 退出
 */
+ (void)getLogoutWithParameters:(NSDictionary *)parameters
                           success:(void (^)(NSString *success))success
                           failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 所有省份
 */
+ (void)getProvinceSuccess:(void (^)(HUZProvinceModel *object))success

                        failure:(void (^)(NSUInteger code,NSString *errorStr))failure;

/**
 所有专业
 */
+ (void)getMajorEntitiesSuccess:(void (^)(HUZMajorListDataModel *dataModel))success
                        failure:(void (^)(NSUInteger code,NSString *errorStr))failure;
@end

NS_ASSUME_NONNULL_END

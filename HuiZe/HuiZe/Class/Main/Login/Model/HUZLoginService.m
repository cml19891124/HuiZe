//
//  HUZLoginService.m
//  HuiZe
//
//  Created by mac on 2019/5/7.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZLoginService.h"
#import "HUZLoginModel.h"
@implementation HUZLoginService

/**
 注册
 */
+ (void)getRegisterWithParameters:(NSDictionary *)parameters
                          success:(void (^)(HUZLoginModel *object))success
                          failure:(void (^)(NSUInteger code,NSString *errorStr))failure {
    [HUZNetWorkTool huz_POST:kUrl_loginOrRegist parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZLoginModel *model = [HUZLoginModel modelWithJSON:responseObject];
        if ([model isSuccess]) {
            model.data.userEntity.token = model.data.token;
            HUZUserCenterManager.userModel = model.data.userEntity;
            [HUZUserCenterManager saveToCache];
            if (success) {
                success(model);
            }
        } else {
            if (failure) {
                failure(model.code,model.msg);
            }
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        if (failure) {
            failure(statusCode,NETERROR);
        }
    }];
}


/**
 登录
 */
+ (void)getLoginWithParameters:(NSDictionary *)parameters
                       success:(void (^)(HUZLoginModel *object))success
                       failure:(void (^)(NSUInteger code,NSString *errorStr))failure {
    [HUZNetWorkTool huz_POST:kUrl_login parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZLoginModel *model = [HUZLoginModel modelWithJSON:responseObject];
        if ([model isSuccess]) {
            model.data.userEntity.token = model.data.token;
            HUZUserCenterManager.userModel = model.data.userEntity;
            [HUZUserCenterManager saveToCache];
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

/**
 发送验证码
 */
+ (void)getSendCodeWithParameters:(NSDictionary *)parameters
                          success:(void (^)(NSString *success))success
                          failure:(void (^)(NSUInteger code,NSString *errorStr))failure {
    [HUZNetWorkTool huz_GET:kUrl_sms parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZLOG(@"%@", responseObject);
        HUZLoginModel *model = [HUZLoginModel modelWithJSON:responseObject];
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
修改手机发送验证码
 */
+ (void)getFixPhoneSendCodeWithParameters:(NSDictionary *)parameters
                                        success:(void (^)(NSString *success))success
                                        failure:(void (^)(NSUInteger code,NSString *errorStr))failure {
    [HUZNetWorkTool huz_POST:kUrl_messagephone parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZLoginModel *model = [HUZLoginModel modelWithJSON:responseObject];
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
 忘记密码发送验证码
 */
+ (void)getForgetPasswordSendCodeWithParameters:(NSDictionary *)parameters
                          success:(void (^)(NSString *success))success
                          failure:(void (^)(NSUInteger code,NSString *errorStr))failure {
    [HUZNetWorkTool huz_POST:kUrl_msgResetphone parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZLoginModel *model = [HUZLoginModel modelWithJSON:responseObject];
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
 忘记密码核实验证码
 */
+ (void)getModifyResetPasswordWithParameters:(NSDictionary *)parameters
                                        success:(void (^)(NSString *success))success
                                        failure:(void (^)(NSUInteger code,NSString *errorStr))failure {
    [HUZNetWorkTool huz_POST:kUrl_msgResetPassword parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZLoginModel *model = [HUZLoginModel modelWithJSON:responseObject];
        if ([model isSuccess]) {
            model.data.userEntity.token = model.data.token;
            HUZUserCenterManager.userModel = model.data.userEntity;
            [HUZUserCenterManager saveToCache];
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
 重置密码
 */
+ (void)getResetPasswordWithParameters:(NSDictionary *)parameters
                               success:(void (^)(NSString *success))success
                               failure:(void (^)(NSUInteger code,NSString *errorStr))failure {
    [HUZNetWorkTool huz_POST:kUrl_resetPassword parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZLoginModel *model = [HUZLoginModel modelWithJSON:responseObject];
        if ([model isSuccess]) {
            model.data.userEntity.token = model.data.token;
            HUZUserCenterManager.userModel = model.data.userEntity;
            [HUZUserCenterManager saveToCache];
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
 更换手机
 */
+ (void)getModifyPhoneWithParameters:(NSDictionary *)parameters
                             success:(void (^)(NSString *success))success
                             failure:(void (^)(NSUInteger code,NSString *errorStr))failure {
    [HUZNetWorkTool huz_POST:kUrl_updatephone parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZLoginModel *model = [HUZLoginModel modelWithJSON:responseObject];
        if ([model isSuccess]) {
            HUZLoginModel *model = [HUZLoginModel modelWithJSON:responseObject];
            model.data.userEntity.token = model.data.token;
            HUZUserCenterManager.userModel = model.data.userEntity;
            [HUZUserCenterManager saveToCache];
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
 第三方登录
 */
+ (void)getThirdLoginWithParameters:(NSDictionary *)parameters url:(NSString *)url
                            success:(void (^)(HUZLoginModel *object))success
                            failure:(void (^)(NSUInteger code,NSString *errorStr))failure {
    [HUZNetWorkTool huz_POST:url parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZLOG(@"第三方登录 - 用户信息 %@", responseObject);
        HUZLoginModel *model = [HUZLoginModel modelWithJSON:responseObject];
        if ([model isSuccess]) {
            model.data.userEntity.token = model.data.token;
            HUZUserCenterManager.userModel = model.data.userEntity;
            [HUZUserCenterManager saveToCache];
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

/**
 修改个人信息
 */
+ (void)getUpdateDetailWithParameters:(NSDictionary *)parameters
                              success:(void (^)(NSString *success))success
                              failure:(void (^)(NSUInteger code,NSString *errorStr))failure {
    [HUZNetWorkTool huz_POST:kUrl_updatedetails parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZLoginModel *model = [HUZLoginModel modelWithJSON:responseObject];
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
 退出
 */
+ (void)getLogoutWithParameters:(NSDictionary *)parameters
                        success:(void (^)(NSString *success))success
                        failure:(void (^)(NSUInteger code,NSString *errorStr))failure {
    [HUZNetWorkTool huz_POST:kUrl_logout parameters:parameters success:^(id  _Nonnull responseObject) {
        HUZLoginModel *model = [HUZLoginModel modelWithJSON:responseObject];
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
 所有省份
 */
+ (void)getProvinceSuccess:(void (^)(HUZProvinceModel *object))success
                   failure:(void (^)(NSUInteger code,NSString *errorStr))failure {
    [HUZNetWorkTool huz_GET:kUrl_allprovince parameters:@{} success:^(id  _Nonnull responseObject) {
        HUZLOG(@"所有省份：%@", responseObject);
        HUZProvinceModel *model = [HUZProvinceModel modelWithJSON:responseObject];
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

/**
 所有专业
 */
+ (void)getMajorEntitiesSuccess:(void (^)(HUZMajorListDataModel *dataModel))success
                   failure:(void (^)(NSUInteger code,NSString *errorStr))failure {
    [HUZNetWorkTool huz_POST:kUrl_allmajorEntities parameters:@{} success:^(id  _Nonnull responseObject) {
        HUZLOG(@"所有专业：%@", responseObject);
        HUZMajorListDataModel *model = [HUZMajorListDataModel modelWithJSON:responseObject];
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
@end

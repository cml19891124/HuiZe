//
//  HUZPayManager.h
//  HuiZe
//
//  Created by mac on 2019/5/7.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WXApi.h>

NS_ASSUME_NONNULL_BEGIN

@interface HUZPayManager : NSObject<WXApiDelegate>
typedef NS_ENUM(NSInteger, PayErrorCode) {
    
    WXERROR_PAYPARAM            = 1002,   //支付参数解析错误
    WXERROR_NOTINSTALL          = 1003,   //未安装微信
    WXERROR_PAY                 = 1004,   //支付失败
    WXCANCEL_PAY                = 1005,   //支付取消
    
    ALIPAYERROR_SCHEME          = 1101,     //scheme错误
    ALIPAYERROR_PAY             = 1102,     //支付错误
    ALIPAYCANCEL_PAY            = 1103      //支付取消
};

/**
 *  获取单例
 */
+ (instancetype)sharedManager;

/**
 *  发起支付宝支付请求
 *
 *  @param pay_param    支付
 *  @param successBlock 成功
 *  @param failBlock    失败
 */
- (void)alipayWithPayParam:(NSString *)pay_param
                   success:(void (^)(void))successBlock
                   failure:(void (^)(NSInteger))failBlock;

/**
 *  发起微信支付请求
 *
 *  @param pay_param    支付参数
 *  @param successBlock 成功
 *  @param failBlock    失败
 */
- (void)wxPayWithPayParam:(NSString *)pay_param
                  success:(void (^)(void))successBlock
                  failure:(void (^)(NSInteger))failBlock;
//微信支付
- (void)wxPayWithPayDict:(NSDictionary *)dic
                 success:(void (^)(void))successBlock
                 failure:(void (^)(NSInteger))failBlock;
/**
 *  回调入口
 *
 *  @param url url
 *
 *  @return BOOL
 */
- (BOOL) handleOpenURL:(NSURL *) url;

@end

NS_ASSUME_NONNULL_END

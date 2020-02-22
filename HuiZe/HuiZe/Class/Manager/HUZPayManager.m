//
//  HUZPayManager.m
//  HuiZe
//
//  Created by mac on 2019/5/7.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZPayManager.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>

@interface HUZPayManager ()<WXApiDelegate>

@property (nonatomic, copy) void(^WXPaySuccess)();
@property (nonatomic, copy) void(^WXPayError)(NSInteger err_code);
@property (nonatomic, copy) void(^AliPaySuccess)();
@property (nonatomic, copy) void(^AliPayError)(NSInteger err_code);

@end

@implementation HUZPayManager

SINGLETON_FOR_CLASS(HUZPayManager);

+ (instancetype)sharedManager {
    static HUZPayManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HUZPayManager alloc] init];
    });
    
    return instance;
}

//回调处理
- (BOOL) handleOpenURL:(NSURL *) url{
    
    //如果极简开发包不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给开发包
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            NSLog(@"resultwwwwwww = %@",resultDic);
            NSInteger resultCode = [resultDic[@"resultStatus"] integerValue];
            switch (resultCode) {
                case 9000:     //支付成功
                    self.AliPaySuccess();
                    break;
                    
                case 6001:     //支付取消
                    self.AliPayError(ALIPAYCANCEL_PAY);
                    break;
                    
                default:        //支付失败
                    self.AliPayError(ALIPAYERROR_PAY);
                    break;
            }
            
        }];
    }
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回authCode
        
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            NSLog(@"result99999 = %@",resultDic);
            NSInteger resultCode = [resultDic[@"resultStatus"] integerValue];
            switch (resultCode) {
                case 9000:     //支付成功
                    self.AliPaySuccess();
                    break;
                    
                case 6001:     //支付取消
                    self.AliPayError(ALIPAYCANCEL_PAY);
                    break;
                    
                default:        //支付失败
                    self.AliPayError(ALIPAYERROR_PAY);
                    break;
            }
        }];
    }
    
    return [WXApi handleOpenURL:url delegate:self];
}

//支付宝支付
- (void)alipayWithPayParam:(NSString *)pay_param
                   success:(void (^)(void))successBlock
                   failure:(void (^)(NSInteger))failBlock {
    
    self.AliPaySuccess = successBlock;
    self.AliPayError = failBlock;
    
    //获取App Scheme
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Info.plist" ofType:nil];
    NSDictionary *infoData = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *array = [infoData objectForKey:@"CFBundleURLTypes"];
    
    NSMutableString *appScheme = [NSMutableString string];
    for (NSDictionary *dict in array) {
        if ([dict[@"CFBundleURLName"] isEqualToString:@"alipay"]) {
            
            NSString * appSchemeStr = dict[@"CFBundleURLSchemes"];
            NSLog(@"====%@",appSchemeStr);
            for (NSString *str in appSchemeStr) {
                NSLog(@"%@",str);
                appScheme = str;
            }
        }
    }
    
    if (appScheme == nil) {
        failBlock(ALIPAYERROR_SCHEME);
        return;
    }
    NSString *url = [[NSBundle mainBundle]bundleIdentifier];
    [[AlipaySDK defaultService] payOrder:pay_param fromScheme:url callback:^(NSDictionary *resultDic) {
        NSLog(@"支付结果:%@",resultDic);
        NSInteger resultCode = [resultDic[@"resultStatus"] integerValue];
        switch (resultCode) {
            case 9000:     //支付成功
                successBlock();
                break;
                
            case 6001:     //支付取消
                failBlock(ALIPAYCANCEL_PAY);
                break;
                
            default:        //支付失败
                failBlock(ALIPAYERROR_PAY);
                break;
        }
    }];
}

//微信支付
- (void)wxPayWithPayParam:(NSString *)pay_param
                  success:(void (^)(void))successBlock
                  failure:(void (^)(NSInteger))failBlock {
    self.WXPaySuccess = successBlock;
    self.WXPayError = failBlock;
    
    //解析结果
    NSData *data = [pay_param dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    NSString *appid = dic[@"appid"];
    NSString *partnerid = dic[@"partnerid"];
    NSString *prepayid = dic[@"prepayid"];
    NSString *package = dic[@"package"];
    NSString *noncestr = dic[@"noncestr"];
    NSString *timestamp = dic[@"timestamp"];
    NSString *sign = dic[@"sign"];
    
    if(error != nil) {
        failBlock(WXERROR_PAYPARAM);
        return ;
    }
    
    [WXApi registerApp:appid];
    
    if(![WXApi isWXAppInstalled]) {
        failBlock(WXERROR_NOTINSTALL);
        return ;
    }
    
    //发起微信支付
    PayReq* req   = [[PayReq alloc] init];
    req.partnerId = partnerid;
    req.prepayId  = prepayid;
    req.nonceStr  = noncestr;
    req.timeStamp = timestamp.intValue;
    req.package   = package;
    req.sign      = sign;
    [WXApi sendReq:req];
}

//微信支付
- (void)wxPayWithPayDict:(NSDictionary *)dic
                  success:(void (^)(void))successBlock
                  failure:(void (^)(NSInteger))failBlock {
    self.WXPaySuccess = successBlock;
    self.WXPayError = failBlock;
    
    NSString *appid = dic[@"appid"];
    NSString *partnerid = dic[@"partnerid"];
    NSString *prepayid = dic[@"prepayid"];
    NSString *package = dic[@"package"];
    NSString *noncestr = dic[@"noncestr"];
    NSString *timestamp = dic[@"timestamp"];
    NSString *sign = dic[@"sign"];
    
    [WXApi registerApp:appid];
    
    if(![WXApi isWXAppInstalled]) {
        failBlock(WXERROR_NOTINSTALL);
        return ;
    }
    
    //发起微信支付
    PayReq* req   = [[PayReq alloc] init];
    req.partnerId = partnerid;
    req.prepayId  = prepayid;
    req.nonceStr  = noncestr;
    req.timeStamp = timestamp.intValue;
    req.package   = package;
    req.sign      = sign;
    [WXApi sendReq:req];
}
#pragma mark - 微信回调
- (void)onResp:(BaseResp *)resp{
    NSLog(@"onResp");
    if ([resp isKindOfClass:[PayResp class]]) {
        PayResp*response=(PayResp*)resp;  // 微信终端返回给第三方的关于支付结果的结构体
        
        switch (response.errCode) {
            case WXSuccess:
                self.WXPaySuccess();
                break;
                
            case WXErrCodeUserCancel:   //用户点击取消并返回
                self.WXPayError(WXCANCEL_PAY);
                break;
                
            default:        //剩余都是支付失败
                self.WXPayError(WXERROR_PAY);
                break;
        }
    }
}
@end

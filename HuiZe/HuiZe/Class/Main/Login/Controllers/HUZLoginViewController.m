//
//  HUZLoginViewController.m
//  HuiZe
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZLoginViewController.h"
#import "HUZCodeLoginView.h"
#import "HUZThirdLoginView.h"
#import "HUZPsdLoginViewController.h"
#import "HUZBindPhoneViewController.h"
#import "HUZModifyPhoneViewController.h"
#import "HUZLoginService.h"
#import <UMShare/UMShare.h>
#import "HUZThirdModel.h"
#import "HUZAgreementViewController.h"
#import "HUZWriteInfoViewController.h"
#import "HUZLoginModel.h"
#import "HUZUser.h"
@interface HUZLoginViewController ()<TTTAttributedLabelDelegate>
@property (nonatomic,strong) UIImageView *ivBg;
@property (nonatomic,strong) HUZCodeLoginView *codeLoginView;
@property (nonatomic,strong) HUZThirdLoginView *thirdLoginView;

@end

@implementation HUZLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)configComponents{
    self.ivBg = [[UIImageView alloc] initWithImage:ImageNamed(@"bg／bgr")];
    [self.view addSubview:self.ivBg];
    [self.ivBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    [super configComponents];

    [self.view addSubview:self.codeLoginView];
    [self.codeLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(AutoDistance(470));
    }];
    
    [self.view addSubview:self.thirdLoginView];
    [self.thirdLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeLoginView.mas_bottom).offset(AutoDistance(HUZIPHONESE ? AutoDistance(30) : AutoDistance(50)));
        make.left.bottom.right.equalTo(self.view);
    }];
    [self.codeLoginView.btnForget addTarget:self action:@selector(forgetPsdClick) forControlEvents:UIControlEventTouchUpInside];
    [self.codeLoginView.btnSmsLogin addTarget:self action:@selector(accountLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.thirdLoginView.btnQQ addTarget:self action:@selector(qqLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.thirdLoginView.btnWechat addTarget:self action:@selector(wechatLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.thirdLoginView.btnWb addTarget:self action:@selector(wbLogin) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

- (void)forgetPsdClick{
    HUZModifyPhoneViewController *modifyPhoneVC = [HUZModifyPhoneViewController new];
    [self.navigationController pushViewController:modifyPhoneVC animated:YES];
}

- (void)accountLogin{
    HUZPsdLoginViewController *psdLoginVC = [HUZPsdLoginViewController new];
    [self.navigationController pushViewController:psdLoginVC animated:YES];
}

- (void)qqLogin{
    [self getUserInfoForPlatform:UMSocialPlatformType_QQ];
}

- (void)wechatLogin{
    [self getUserInfoForPlatform:UMSocialPlatformType_WechatSession];
}

- (void)wbLogin{
}

- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:nil completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *resp = result;
        if (!error) {
            // 第三方登录数据(为空表示平台未提供)
            // 授权数据
            NSLog(@" uid: %@", resp.uid);
            NSLog(@" openid: %@", resp.openid);
            NSLog(@" accessToken: %@", resp.accessToken);
            NSLog(@" refreshToken: %@", resp.refreshToken);
            NSLog(@" expiration: %@", resp.expiration);
            // 用户数据
            NSLog(@" name: %@", resp.name);
            NSLog(@" iconurl: %@", resp.iconurl);
            NSLog(@" gender: %@", resp.unionGender);
            // 第三方平台SDK原始数据
#warning mrak --第方登陆
            NSLog(@" originalResponse: %@\n  ErrOr:%@", resp.originalResponse,error);
            if (platformType == UMSocialPlatformType_WechatSession) {
                [self readyToCallTheLogin:resp type:UMSocialPlatformType_WechatSession];
            }else{
                [self readyToCallTheLogin:resp type:UMSocialPlatformType_QQ];
            }
        }
        
    }];
}

- (void)extracted:(NSMutableDictionary *)par url:(NSString *)url weakSelf:(HUZLoginViewController *const __weak)weakSelf {
    [HUZLoginService getThirdLoginWithParameters:par url:url success:^(HUZLoginModel * _Nonnull object) {
        [weakSelf removeOverFlowActivityView];
        [weakSelf presentSuccessSheet:@"登录成功"];
        if ([object.data.userEntity.haveMobile integerValue] != 0) {
            HUZBindPhoneViewController *bindPhone = [[HUZBindPhoneViewController alloc] init];
            bindPhone.wechatDic = par;
            [weakSelf.navigationController pushViewController:bindPhone animated:YES];
        }else if([object.data.userEntity.haveUserInfo integerValue] == 0){
            HUZWriteInfoViewController *writeInfoVC = [HUZWriteInfoViewController new];
            writeInfoVC.isLoginTo = YES;
            [weakSelf.navigationController pushViewController:writeInfoVC animated:YES];
        }else{
            [weakSelf performBlock:^{
                [HUZTools gotohell];
            } afterDelay:1.0];
        }
    } failure:^(NSUInteger code, NSString *errorStr) {
        [weakSelf removeOverFlowActivityView];
        [weakSelf presentErrorSheet:errorStr];
    }];
}


- (void)readyToCallTheLogin:(UMSocialUserInfoResponse *)resp type:(UMSocialPlatformType)type
{
    
    NSString *url = @"";
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    par[@"headUrl"] =  resp.iconurl;
    if (type == UMSocialPlatformType_QQ) {
        url = kQQLogin;
        par[@"access_token"] =  resp.accessToken;
        par[@"openid"] =  resp.openid;
        par[@"qqname"] =  resp.name;
    }else if(type == UMSocialPlatformType_WechatSession){
        url = kWechalogin;
        par[@"openid"] =  resp.openid;
        par[@"wechaName"] =  resp.name;
    }
    
    HUZWEAK_SELF;
    [self displayOverFlowActivityView];
    [self extracted:par url:url weakSelf:weakSelf];
/*
    if (code == 205) { // 未绑定手机号
        [weakSelf performBlock:^{
            HUZBindPhoneViewController *bindPhone = [[HUZBindPhoneViewController alloc] init];
            bindPhone.wechatDic = par;
            [weakSelf.navigationController pushViewController:bindPhone animated:YES];
        } afterDelay:1.5];
    }
*/
//    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
//        HUZSTRONG_SELF;
//        if (error) {
//        } else {
//            UMSocialUserInfoResponse *resp = result;
//            HUZThirdModel *third = [HUZThirdModel new];
//            third.wxResp = resp;
//            // 授权信息
//            NSLog(@"Wechat openid: %@", third.wxResp.openid);
//            NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
//            [postDic setValue:third.wxResp.openid forKey:@"openid"];//第三方授权id
//            //            [postDic setValue:HUZUserCenterManager.userModel.registrationID forKey:@"registrationId"];//极光推送id
//            [postDic setValue:third.wxResp.name forKey:@"wechaName"];
//            [postDic setValue:third.wxResp.iconurl forKey:@"headUrl"];
//
//            NSLog(@"微信登录POSTDIC = %@",postDic);
//
//        }
//    }];
}


#pragma mark - Lazy
- (HUZCodeLoginView *)codeLoginView{
    HUZWEAK_SELF;
    if (!_codeLoginView) {
        _codeLoginView = [HUZCodeLoginView new];
        
        _codeLoginView.codeBlock = ^(NSString * _Nonnull phone) {
            HUZSTRONG_SELF;
            NSString *checkResult = [HUZTools isCheckPhone:phone];
            if (![checkResult isEqualToString:@""]) {
                [strongSelf presentErrorSheet:checkResult];
                return;
            }
            NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
            [postDic setValue:phone forKey:@"phone"];
            
            [strongSelf displayOverFlowActivityView];
            [HUZLoginService getSendCodeWithParameters:postDic success:^(NSString *success) {
                [strongSelf removeOverFlowActivityView];
                [strongSelf presentSuccessSheet:@"发送验证码成功"];
                [strongSelf.codeLoginView.codeTimer start];
            } failure:^(NSUInteger code, NSString *errorStr) {
                [strongSelf removeOverFlowActivityView];
                [strongSelf presentErrorSheet:errorStr];
            }];
        };
        
        _codeLoginView.loginBlock = ^(NSString * _Nonnull phone, NSString * _Nonnull code) {
            HUZSTRONG_SELF;
            NSString *checkResult = [HUZTools isCheckPhone:phone];
            if (![checkResult isEqualToString:@""]) {
                [strongSelf presentErrorSheet:checkResult];
                return;
            }
            if (DRStringIsEmpty(code)) {
                [strongSelf presentErrorSheet:@"请输入验证码"];
                return;
            }
            
            if (code.length > 6) {
                [strongSelf presentErrorSheet:@"验证码不能大于6位"];
                return;
            }

            NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
            [postDic setValue:phone forKey:@"mobile"];
            [postDic setValue:code forKey:@"code"];
            [postDic setValue:@"" forKey:@"openid"];
            
            NSLog(@"登录/注册postDic = %@",postDic);
            
            [strongSelf displayOverFlowActivityView];
            [HUZLoginService getRegisterWithParameters:postDic success:^(HUZLoginModel * _Nonnull object) {
                [strongSelf removeOverFlowActivityView];
                [strongSelf presentSuccessSheet:@"登录成功"];
                HUZUserCenterManager.mobile = phone;
                if ([object.data.userEntity.haveUserInfo integerValue] == 0) {
                    HUZWriteInfoViewController *writeInfoVC = [HUZWriteInfoViewController new];
                    writeInfoVC.isLoginTo = YES;
                    [strongSelf.navigationController pushViewController:writeInfoVC animated:YES];
                }else{
                    [strongSelf performBlock:^{
                        [HUZTools gotohell];
                    } afterDelay:1.f];
                }

            } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
                [strongSelf removeOverFlowActivityView];
                [strongSelf presentErrorSheet:errorStr];
            }];
        };
      
    }
    return _codeLoginView;
}

- (HUZThirdLoginView *)thirdLoginView{
    if (!_thirdLoginView) {
        _thirdLoginView = [HUZThirdLoginView new];
        _thirdLoginView.aLable.delegate = self;
    }
    return _thirdLoginView;
}

#pragma mark - TTTAttributedLabelDelegate
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url {
    HUZAgreementViewController *agreementVC = [[HUZAgreementViewController alloc] init];
    agreementVC.navTitle = @"用户协议";
//    agreementVC.shouldDisableWebViewTitle = NO;
    agreementVC.url = @"http://m.hz985211.com/Privacyprotocol.html";
    [self.navigationController pushViewController:agreementVC animated:true];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

@end

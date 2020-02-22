//
//  HUZModifyPhoneViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/20.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZModifyPhoneViewController.h"
#import "HUZModifyPhoneView.h"
#import "HUZForgetPsdViewController.h"
#import "HUZLoginService.h"

@interface HUZModifyPhoneViewController ()

@property (nonatomic,strong) HUZModifyPhoneView *modifyPhoneView;
@end

@implementation HUZModifyPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)configComponents{
    [super configComponents];
    
    [self.view addSubview:self.modifyPhoneView];
    [self.modifyPhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
}

- (void)nextClick{
    HUZForgetPsdViewController *forgetPsdVC = [HUZForgetPsdViewController new];
    [self.navigationController pushViewController:forgetPsdVC animated:YES];
}


#pragma mark - Lazy
- (HUZModifyPhoneView *)modifyPhoneView{
    HUZWEAK_SELF;
    if (!_modifyPhoneView) {
        _modifyPhoneView = [HUZModifyPhoneView new];
        _modifyPhoneView.codeBlock = ^(NSString * _Nonnull phone) {
            HUZSTRONG_SELF;
            NSString *checkResult = [HUZTools isCheckPhone:phone];
            if (![checkResult isEqualToString:@""]) {
                [strongSelf presentErrorSheet:checkResult];
                return;
            }
            NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
            [postDic setValue:phone forKey:@"phone"];
            
            [strongSelf displayOverFlowActivityView];
            [HUZLoginService getForgetPasswordSendCodeWithParameters:postDic success:^(NSString *success) {
                [strongSelf removeOverFlowActivityView];
                [strongSelf presentSuccessSheet:@"发送验证码成功"];
                [strongSelf.modifyPhoneView.codeTimer start];
            } failure:^(NSUInteger code, NSString *errorStr) {
                [strongSelf removeOverFlowActivityView];
                [strongSelf presentErrorSheet:errorStr];
            }];
        };
        
        _modifyPhoneView.loginBlock = ^(NSString * _Nonnull phone, NSString * _Nonnull code) {
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
            
            NSLog(@"忘记密码核实验证码 postDic = %@",postDic);
            
            [strongSelf displayOverFlowActivityView];
            [HUZLoginService getModifyResetPasswordWithParameters:postDic success:^(NSString *success) {
                [strongSelf removeOverFlowActivityView];
                [strongSelf presentSuccessSheet:success];
                [strongSelf performBlock:^{
                    [strongSelf nextClick];
                } afterDelay:1.5f];
            } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
                [strongSelf removeOverFlowActivityView];
                [strongSelf presentErrorSheet:errorStr];

            }];
        };
    }
    return _modifyPhoneView;
}

@end

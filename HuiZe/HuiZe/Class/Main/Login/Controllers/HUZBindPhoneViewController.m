//
//  HUZBindPhoneViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/20.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZBindPhoneViewController.h"
#import "HUZBindPhoneView.h"
#import "HUZWriteInfoViewController.h"
#import "HUZLoginService.h"

@interface HUZBindPhoneViewController ()

@property (nonatomic,strong) HUZBindPhoneView *bindPhoneView;

@end

@implementation HUZBindPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)configComponents{
    [super configComponents];
    
    [self.view addSubview:self.bindPhoneView];
    [self.bindPhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
}

- (void)nextClick{
    HUZWriteInfoViewController *writeInfoVC = [HUZWriteInfoViewController new];
    writeInfoVC.isLoginTo = YES;
    [self.navigationController pushViewController:writeInfoVC animated:YES];
}

#pragma mark - Lazy
- (HUZBindPhoneView *)bindPhoneView{
    HUZWEAK_SELF;
    if (!_bindPhoneView) {
        _bindPhoneView = [HUZBindPhoneView new];
        _bindPhoneView.codeBlock = ^(NSString * _Nonnull phone) {
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
                [strongSelf.bindPhoneView.codeTimer start];
            } failure:^(NSUInteger code, NSString *errorStr) {
                [strongSelf removeOverFlowActivityView];
                [strongSelf presentErrorSheet:errorStr];
            }];
        };
        
        _bindPhoneView.loginBlock = ^(NSString * _Nonnull phone, NSString * _Nonnull code) {
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
            [postDic setObject:strongSelf.wechatDic forKey:@"weChatForm"];

            NSLog(@"更换手机 postDic = %@",postDic);
            
            [strongSelf displayOverFlowActivityView];
            [HUZLoginService getModifyPhoneWithParameters:postDic success:^(NSString *success) {
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
    return _bindPhoneView;
}

- (void)setWechatDic:(NSDictionary *)wechatDic {
    _wechatDic = wechatDic;
}

@end

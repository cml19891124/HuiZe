//
//  HUZPsdLoginViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/20.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZPsdLoginViewController.h"
#import "HUZPsdLoginView.h"
#import "HUZModifyPhoneViewController.h"
#import "HUZLoginService.h"
#import "HUZWriteInfoViewController.h"
@interface HUZPsdLoginViewController ()

@property (nonatomic,strong) HUZPsdLoginView *psdLoginView;

@end

@implementation HUZPsdLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)configComponents{
    [super configComponents];
    
    [self.view addSubview:self.psdLoginView];
    [self.psdLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    [self.psdLoginView.btnForget addTarget:self action:@selector(forgetPsdClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)forgetPsdClick{
    HUZModifyPhoneViewController *modifyPhoneVC = [HUZModifyPhoneViewController new];
    [self.navigationController pushViewController:modifyPhoneVC animated:YES];
}

#pragma mark - Lazy
- (HUZPsdLoginView *)psdLoginView{
    HUZWEAK_SELF;
    if (!_psdLoginView) {
        _psdLoginView = [HUZPsdLoginView new];
        _psdLoginView.loginBlock = ^(NSString * _Nonnull phone, NSString * _Nonnull password) {
            HUZSTRONG_SELF;
            NSString *checkResult = [HUZTools isCheckPhone:phone];
            if (![checkResult isEqualToString:@""]) {
                [strongSelf presentErrorSheet:checkResult];
                return;
            }
            NSString *checkPass = [HUZTools isCheckPassword:password];
            if (![checkPass isEqualToString:@""]) {
                [strongSelf presentErrorSheet:checkPass];
                return;
            }
            
            NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
            [postDic setValue:phone forKey:@"mobile"];
            [postDic setValue:password forKey:@"password"];
            
            NSLog(@"登录postDic = %@",postDic);
            /*
             Printing description of postDic:
             {
                 mobile = 15506876503;
                 password = asdf1234;
             }

             */
            [strongSelf displayOverFlowActivityView];
            [HUZLoginService getLoginWithParameters:postDic success:^(HUZLoginModel * _Nonnull object) {
                [strongSelf removeOverFlowActivityView];
                [strongSelf presentSuccessSheet:@"登录成功"];
                HUZUserCenterManager.mobile = phone;
                
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
    return _psdLoginView;
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

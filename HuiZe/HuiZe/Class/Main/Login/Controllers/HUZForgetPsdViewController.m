//
//  HUZForgetPsdViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/20.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZForgetPsdViewController.h"
#import "HUZForgetPsdView.h"
#import "HUZLoginService.h"

@interface HUZForgetPsdViewController ()

@property (nonatomic,strong) HUZForgetPsdView *forgetPsdView;

@end

@implementation HUZForgetPsdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)configComponents{
    [super configComponents];
    
    [self.view addSubview:self.forgetPsdView];
    [self.forgetPsdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
}

#pragma mark - Lazy
- (HUZForgetPsdView *)forgetPsdView{
    HUZWEAK_SELF;
    if (!_forgetPsdView) {
        _forgetPsdView = [HUZForgetPsdView new];
        _forgetPsdView.completeBlock = ^(NSString * _Nonnull password) {
            HUZSTRONG_SELF;
            NSString *checkPass = [HUZTools isCheckPassword:password];
            if (![checkPass isEqualToString:@""]) {
                [strongSelf presentErrorSheet:checkPass];
                return;
            }
    
            NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
            [postDic setValue:password forKey:@"password"];
            NSString *token = HUZUserCenterManager.userModel.token;
            [postDic setValue:!DRStringIsEmpty(token) ? token : @""  forKey:@"token"];

            NSLog(@"忘记密码设置密码 postDic = %@",postDic);
            
            [strongSelf displayOverFlowActivityView];
            [HUZLoginService getResetPasswordWithParameters:postDic success:^(NSString *success) {
                [strongSelf removeOverFlowActivityView];
                [strongSelf presentSuccessSheet:success];
                [strongSelf performBlock:^{
                    [HUZTools gotohell];
                } afterDelay:1.5f];
            } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
                [strongSelf removeOverFlowActivityView];
                [strongSelf presentErrorSheet:errorStr];

            }];
        };
    }
    return _forgetPsdView;
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

//
//  HUZMyModifyPhoneController.m
//  HuiZe
//
//  Created by mac on 2019/5/6.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZMyModifyPhoneController.h"
#import "HUZMyModifyPhoneHeaderView.h"
#import "HUZMineService.h"
#import "HUZLoginService.h"

@interface HUZMyModifyPhoneController ()
@property (nonatomic,strong) HUZMyModifyPhoneHeaderView *headerView;

@end

@implementation HUZMyModifyPhoneController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"更换手机号";
    self.view.backgroundColor = ColorS(COLOR_BG_F6F6F6);
}

- (void)configComponents{
    [super configComponents];
    
    self.dataSource = @[@"1"].mutableCopy;
    self.cellHeight = AutoDistance(0);
    self.tableView.tableFooterView = self.headerView;
}

- (HUZMyModifyPhoneHeaderView *)headerView {
    HUZWEAK_SELF;
    if (!_headerView) {
        _headerView = [[HUZMyModifyPhoneHeaderView alloc]initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT - HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT)];
        _headerView.codeBlock = ^(NSString * _Nonnull phone) {
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
                [strongSelf.headerView.codeTimer start];
            } failure:^(NSUInteger code, NSString *errorStr) {
                [strongSelf removeOverFlowActivityView];
                [strongSelf presentErrorSheet:errorStr];
            }];
        };
        
        _headerView.loginBlock = ^(NSString * _Nonnull phone, NSString * _Nonnull code) {
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
            NSString *openId = (!DRStringIsEmpty(HUZUserCenterManager.userModel.openId)) ? HUZUserCenterManager.userModel.openId : @"";
            [postDic setValue:openId forKey:@"openid"];
            
            NSLog(@"更换手机 postDic = %@",postDic);
            
            [strongSelf displayOverFlowActivityView];
            [HUZLoginService getModifyPhoneWithParameters:postDic success:^(NSString *success) {
                [strongSelf removeOverFlowActivityView];
                [strongSelf presentSuccessSheet:success];
                HUZUserCenterManager.userModel.mobile = phone;
                [HUZUserCenterManager saveToCache];
                [strongSelf performBlock:^{
                    for (HUZViewController *vc in strongSelf.navigationController.viewControllers) {
                        if ([vc isKindOfClass:NSClassFromString(@"HUZAcountManageController")]) {
                            [strongSelf.navigationController popToViewController:vc animated:YES];
                        }
                    }
                } afterDelay:1.5f];
            } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
                [strongSelf removeOverFlowActivityView];
                [strongSelf presentErrorSheet:errorStr];
                
            }];
        };
    }
    return _headerView;
}


@end

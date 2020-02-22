//
//  HUZMyResetPasswordController.m
//  HuiZe
//
//  Created by mac on 2019/5/14.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZMyResetPasswordController.h"
#import "HUZModifyPhoneViewController.h"
#import "HUZMySetPassHeaderView.h"
#import "HUZMyResetPassHeaderView.h"
#import "HUZMineService.h"

@interface HUZMyResetPasswordController ()
@property (nonatomic,strong) HUZMySetPassHeaderView *setHeaderView;
@property (nonatomic,strong) HUZMyResetPassHeaderView *resetHeaderView;

@end

@implementation HUZMyResetPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置密码";
    self.view.backgroundColor = ColorS(COLOR_BG_F6F6F6);
}


- (void)configComponents{
    [super configComponents];
    
    self.dataSource = @[@"1"].mutableCopy;
    self.cellHeight = AutoDistance(0);
    self.tableView.tableFooterView =  [HUZUserCenterManager.userModel.havePassword isEqualToString:@"1"] ? self.resetHeaderView : self.setHeaderView;
}

- (HUZMySetPassHeaderView *)setHeaderView {
    HUZWEAK_SELF;
    if (!_setHeaderView) {
        _setHeaderView = [[HUZMySetPassHeaderView alloc]initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT - HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT)];
        _setHeaderView.passBlock = ^(NSString * _Nonnull code) {
            [weakSelf setPass];
        };
    }
    return _setHeaderView;
}

- (HUZMyResetPassHeaderView *)resetHeaderView {
    HUZWEAK_SELF;
    if (!_resetHeaderView) {
        _resetHeaderView = [[HUZMyResetPassHeaderView alloc]initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT - HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT)];
        _resetHeaderView.passBlock = ^(NSString * _Nonnull oldPass, NSString * _Nonnull newPass) {
            [weakSelf resetPassWithOld:oldPass new:newPass];
        };
        [_resetHeaderView.btnForget addTarget:self action:@selector(forgetPass) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetHeaderView;
}

- (void)setPass {
    
    NSString *pass = [NSString stringWithFormat:@"%@",self.setHeaderView.tfPass.text];
    NSString *checkPass = [HUZTools isCheckPassword:pass];
    if (![checkPass isEqualToString:@""]) {
        [self presentErrorSheet:checkPass];
        return;
    }
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setValue:pass forKey:@"newpassword"];
    [postDic setValue:pass forKey:@"oldpassword"];
    NSLog(@"设置密码postDic = %@",postDic);
    
    [self displayOverFlowActivityView];
    [HUZMineService getUpdatePasswordWithParameters:postDic success:^(NSString * _Nonnull success) {
        [self removeOverFlowActivityView];
        [self presentSuccessSheet:@"设置成功"];
        if (self.callBackBlock) {
            self.callBackBlock();
        }
        [self performBlock:^{
            [self.navigationController popViewControllerAnimated:YES];
        } afterDelay:1.f];
        
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        [self removeOverFlowActivityView];
        [self presentErrorSheet:errorStr];
        
    }];
}

- (void)resetPassWithOld:(NSString*)old new:(NSString*)new {
    NSString *checkOldPass = [HUZTools isCheckPassword:old];
    if (![checkOldPass isEqualToString:@""]) {
        [self presentErrorSheet:[NSString stringWithFormat:@"旧密码%@", checkOldPass]];
        return;
    }
    NSString *checkNewPass = [HUZTools isCheckPassword:new];
    if (![checkNewPass isEqualToString:@""]) {
        [self presentErrorSheet:[NSString stringWithFormat:@"新密码%@", checkNewPass]];
        return;
    }
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setValue:old forKey:@"oldpassword"];
    [postDic setValue:new forKey:@"newpassword"];
    NSLog(@"重设密码postDic = %@",postDic);
    
    [self displayOverFlowActivityView];
    [HUZMineService getUpdatePasswordWithParameters:postDic success:^(NSString * _Nonnull success) {
        [self removeOverFlowActivityView];
        [self presentSuccessSheet:@"重设密码成功"];
        if (self.callBackBlock) {
            self.callBackBlock();
        }
        [self performBlock:^{
            [self.navigationController popViewControllerAnimated:YES];
        } afterDelay:1.f];
        
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        [self removeOverFlowActivityView];
        [self presentErrorSheet:errorStr];
        
    }];
}

- (void)forgetPass {
    HUZModifyPhoneViewController *modifyPhoneVC = [HUZModifyPhoneViewController new];
    [self.navigationController pushViewController:modifyPhoneVC animated:YES];
}
@end

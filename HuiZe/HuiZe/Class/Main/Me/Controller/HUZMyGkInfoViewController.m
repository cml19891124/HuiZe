//
//  HUZMyGkInfoViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/5.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZMyGkInfoViewController.h"
#import "HUZMyGkInfoView.h"
#import "HUZMineService.h"
#import "HUZLoginService.h"
@interface HUZMyGkInfoViewController ()

@property (nonatomic,strong) HUZMyGkInfoView *myGkInfoView;

@end

@implementation HUZMyGkInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)configComponents{
    [super configComponents];
    
    [self.view addSubview:self.myGkInfoView];
}

- (HUZMyGkInfoView *)myGkInfoView{
    HUZWEAK_SELF;
    if (!_myGkInfoView) {
        _myGkInfoView = [[HUZMyGkInfoView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT)];
        _myGkInfoView.callBackBlock = ^(NSMutableDictionary * _Nonnull postDic) {
            
            postDic[@"examinationProvince"] = HUZUserCenterManager.userModel.examinationProvince;
            postDic[@"examinationYear"] = HUZUserCenterManager.userModel.examinationYear;
            postDic[@"grade"] = HUZUserCenterManager.userModel.grade;
            postDic[@"userRole"] = HUZUserCenterManager.userModel.userRole;
            
            [weakSelf displayOverFlowActivityView];
            [HUZMineService getUpdateDetailsWithParameters:postDic success:^(NSString * _Nonnull success) {
                HUZUserCenterManager.userModel.estimateScore = postDic[@"estimateScore"];
                HUZUserCenterManager.userModel.estimateRanking = postDic[@"estimateRanking"];
                
               NSString *gradeStr = [HUZUserCenterManager.userModel.grade isEqualToString:@"0"] ? @"文科":@"理科";
                NSString *proviceName = DRStringIsNotEmpty(HUZUserCenterManager.userModel.provinceName)?[NSString stringWithFormat:@"%@",HUZUserCenterManager.userModel.provinceName]:@"";
                NSString *estimateScore = DRStringIsNotEmpty(HUZUserCenterManager.userModel.estimateScore)?HUZUserCenterManager.userModel.estimateScore:@"";
                HUZUserCenterManager.gkInfo = [NSString stringWithFormat:@"%@、%@、%@分", proviceName, gradeStr, estimateScore];
                
                if (weakSelf.updateBlock) {
                    weakSelf.updateBlock();
                }
                [weakSelf removeOverFlowActivityView];
                [weakSelf performBlock:^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                } afterDelay:1.f];
            } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
                [weakSelf removeOverFlowActivityView];
                [weakSelf presentErrorSheet:errorStr];
            }];
        };
    }
    return _myGkInfoView;
}

@end

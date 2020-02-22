//
//  HUZUniInfoViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/24.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniInfoViewController.h"
#import "HUZUniInfoHeaderView.h"
#import "HUZUniInfoTableView.h"
#import "HUZUniEnrollmentDataTableView.h"
#import "HUZUniEnrollmentInfoTableView.h"
#import "HUZUniGradutionDesTableView.h"
#import "HUZUniInfoBottomView.h"
#import "HUZUniInfoTableViewAssessMoreFooter.h"
#import "HUZMineService.h"
#import "HUZHomeService.h"
@interface HUZUniInfoViewController ()

@property (nonatomic,strong) HUZUniInfoHeaderView *uniInfoHeaderView;
@property (nonatomic,strong) HUZUniInfoTableView *uniInfoTableView;
@property (nonatomic,strong) HUZUniEnrollmentDataTableView *uniEnrollmentDataTableView;
@property (nonatomic,strong) HUZUniEnrollmentInfoTableView *uniEnrollmentInfoTableView;
@property (nonatomic,strong) HUZUniGradutionDesTableView *uniGradutionDesTableView;
@property (nonatomic,strong) HUZUniInfoBottomView *uniInfoBottomView;
@end

@implementation HUZUniInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self showBarButton:NAV_RIGHT title:@"加入PK" fontColor:ColorS(COLOR_2E86FF)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateStateAction:) name:HUZVIPUpdate_State_Noti_Key object:nil];
}

-(void)updateStateAction:(NSNotification *)noti {
    NSInteger vipState = [HUZUserCenterManager.userModel.vip integerValue];
    self.uniEnrollmentDataTableView.vipState = vipState;
    self.uniEnrollmentInfoTableView.vipState = vipState;
    self.uniGradutionDesTableView.vipState = vipState;
}

#pragma mark - Override
- (void)rightButtonTouch{
    if (!self.schoolId || self.schoolId.length == 0) {
        return;
    }
    if (self.uniInfoHeaderView.model.data.pkSchool) {
        [self presentErrorSheet:@"已添加"];
        return;
    }
    [self displayOverFlowActivityView];
    HUZWEAK_SELF
    [HUZNetWorkTool huz_GET:kUrl_joinpk_shoolpk parameters:@{@"shoolId":self.schoolId} success:^(id  _Nonnull responseObject) {
        NSString *code = responseObject[@"code"];
        if ([code integerValue] == 0) {
            [self showBarButton:NAV_RIGHT title:@"已添加" fontColor:ColorS(COLOR_2E86FF)];
            [weakSelf presentSuccessSheet:[NSString stringWithFormat:@"%@",@"添加成功"]];
        }else{
            [weakSelf presentErrorSheet:responseObject[@"msg"]];
        }
        [weakSelf removeOverFlowActivityView];
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        [weakSelf removeOverFlowActivityView];
        [weakSelf presentErrorSheet:error];
    }];
    
}

- (void)configComponents{
    [super configComponents];
    NSInteger vipState = [HUZUserCenterManager.userModel.vip integerValue];
    self.progressW = HUZSCREEN_WIDTH/4.0;
    self.dataSegment = @[@"学校概况",@"招录数据",@"招生信息"];//,@"毕业去向"
    
    /// 学校概况
    self.uniInfoTableView = [[HUZUniInfoTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.uniInfoTableView.schoolId = self.schoolId;
    
    /// 招录信息
    self.uniEnrollmentDataTableView = [[HUZUniEnrollmentDataTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.uniEnrollmentDataTableView.vipState = vipState;
    self.uniEnrollmentDataTableView.schoolId = self.schoolId;
    
    /// 招生信息
    self.uniEnrollmentInfoTableView = [[HUZUniEnrollmentInfoTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.uniEnrollmentInfoTableView.vipState = vipState;
    self.uniEnrollmentInfoTableView.schoolId = self.schoolId;
    
    /// 毕业去向
    self.uniGradutionDesTableView = [[HUZUniGradutionDesTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.uniGradutionDesTableView.vipState = vipState;
    self.uniGradutionDesTableView.schoolId = self.schoolId;
    
    [self.segTableView setTableViews:@[self.uniInfoTableView,self.uniEnrollmentDataTableView,self.uniEnrollmentInfoTableView]];//,self.uniGradutionDesTableView
    [self.view addSubview:self.segTableView];
    [self.segTableView setTopView:self.uniInfoHeaderView];
    
    [self.view addSubview:self.uniInfoBottomView];
    [self.uniInfoBottomView.btnShare addTarget:self action:@selector(clickShare) forControlEvents:UIControlEventTouchUpInside];
    
    /// 加载头部信息
    [self loadHeaderInfo];
    [self loadMajorList];
}

/// 查询专业列表
- (void)loadMajorList{
    HUZWEAK_SELF
    [self displayOverFlowActivityView];
    [HUZHomeService getAllMajorCategory:@"0" success:^(HUZAllMajorModel * _Nonnull model) {
        HUZSTRONG_SELF
        strongSelf.uniEnrollmentDataTableView.majorModel = model;
        self.uniEnrollmentInfoTableView.majorModel = model;
        [strongSelf removeOverFlowActivityView];
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        [strongSelf presentErrorSheet:errorStr];
    }];
}

- (void)clickShare{
    HUZShareView *shareView = [HUZShareView new];
    [shareView show];
    shareView.block = ^(NSString * _Nonnull platform) {
        
    };
}

#pragma mark NETWork
- (void)focusUni{
    HUZWEAK_SELF
    [self displayOverFlowActivityView];
    [HUZMineService getSaveFollowWithParameters:@{@"type":@"0",@"id":self.schoolId} success:^(NSString * _Nonnull success) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        if (self.uniInfoHeaderView.model.data.attention) {
            self.uniInfoHeaderView.model.data.attention = NO;
            strongSelf.uniInfoBottomView.btnCollect.selected = NO;
            [strongSelf presentSuccessSheet:@"取消关注"];
        }else{
            strongSelf.uniInfoBottomView.btnCollect.selected = YES;
            self.uniInfoHeaderView.model.data.attention = YES;
            [strongSelf presentSuccessSheet:@"关注成功"];
        }

    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        [strongSelf presentErrorSheet:errorStr];
    }];
}

- (void)loadHeaderInfo{
    HUZWEAK_SELF
    [self displayOverFlowActivityView];
    [HUZHomeService getUniHeaderInfo:self.schoolId success:^(HUZUniInfoModel * _Nonnull model) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        strongSelf.uniInfoHeaderView.model = model;
        strongSelf.uniInfoBottomView.btnCollect.selected = model.data.attention;
//        [strongSelf showBarButton:NAV_RIGHT title:model.data.pkSchool ? @"已添加" : @"加入PK" fontColor:ColorS(COLOR_2E86FF)];
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        [strongSelf presentErrorSheet:errorStr];
    }];
}

#pragma mark - Lazy
- (HUZUniInfoHeaderView *)uniInfoHeaderView{
    CGFloat H = HUZSCREEN_WIDTH >= 414 ? 180 : 156;
    if (!_uniInfoHeaderView) {
        _uniInfoHeaderView = [[HUZUniInfoHeaderView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, H-40)];
    }
    return _uniInfoHeaderView;
}

- (HUZUniInfoBottomView *)uniInfoBottomView{
    if (!_uniInfoBottomView) {
        _uniInfoBottomView = [[HUZUniInfoBottomView alloc] initWithFrame:CGRectMake(0, HUZSCREEN_HEIGHT - AutoDistance(49) - HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT, HUZSCREEN_WIDTH, AutoDistance(49))];
        [_uniInfoBottomView.btnCollect addTarget:self action:@selector(focusUni) forControlEvents:UIControlEventTouchUpInside];
    }
    return _uniInfoBottomView;
}

@end

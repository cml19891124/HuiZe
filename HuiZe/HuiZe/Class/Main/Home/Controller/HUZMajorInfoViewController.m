//
//  HUZMajorInfoViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/28.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZMajorInfoViewController.h"
#import "HUZMajorInfoHeaderView.h"
#import "HUZMajorBasicInfoTableView.h"
#import "HUZUniGradutionDesTableView.h"
#import "HUZMajorOpenUniTableView.h"
#import "HUZUniInfoBottomView.h"

#import "HUZMineService.h"
#import "HUZMajorInfoModel.h"
@interface HUZMajorInfoViewController ()

@property (nonatomic,strong) HUZMajorInfoHeaderView *majorInfoHeaderView;
@property (nonatomic,strong) HUZMajorBasicInfoTableView *majorBasicInfoTableView;
@property (nonatomic,strong) HUZMajorOpenUniTableView *majorOpenUniTableView;
@property (nonatomic,strong) HUZUniGradutionDesTableView *uniGradutionDesTableView;
@property (nonatomic,strong) HUZUniInfoBottomView *uniInfoBottomView;

@property (nonatomic, strong) HUZMajorInfoModel * majorInfoModel;
@end

@implementation HUZMajorInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"专业详情";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateStateAction:) name:HUZVIPUpdate_State_Noti_Key object:nil];
}

-(void)updateStateAction:(NSNotification *)noti {
    NSInteger vipState = [HUZUserCenterManager.userModel.vip integerValue];
    self.majorOpenUniTableView.vipState = vipState;
    self.uniGradutionDesTableView.vipState = vipState;
}

- (void)configComponents{
    [super configComponents];
    NSInteger vipState = [HUZUserCenterManager.userModel.vip integerValue];
    self.dataSegment = @[@"基本信息",@"开设院校"];//,@"毕业去向"
    
    self.progressW = HUZSCREEN_WIDTH/3.0;
    
    /// 基本信息
    self.majorBasicInfoTableView = [[HUZMajorBasicInfoTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.majorBasicInfoTableView.majorId = self.majorId;
    /// 开设院校
    self.majorOpenUniTableView = [[HUZMajorOpenUniTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.majorOpenUniTableView.vipState = vipState;
    self.majorOpenUniTableView.majorId = self.majorId;
    /// 毕业去向
    self.uniGradutionDesTableView = [[HUZUniGradutionDesTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.uniGradutionDesTableView.vipState = vipState;
    [self.segTableView setTableViews:@[self.majorBasicInfoTableView,self.majorOpenUniTableView]];//,self.uniGradutionDesTableView
    [self.view addSubview:self.segTableView];
    [self.segTableView setTopView:self.majorInfoHeaderView];
    
    [self.view addSubview:self.uniInfoBottomView];
    [self.uniInfoBottomView.btnShare addTarget:self action:@selector(clickShare) forControlEvents:UIControlEventTouchUpInside];
    [self majorInfoData];
}
//获取专业详情 majorInfoModel
- (void)majorInfoData {
    [self displayOverFlowActivityView];
    HUZWEAK_SELF
    NSString *rul = [NSString stringWithFormat:@"%@/%@",kUrl_major_guess_data,self.majorId];
    [HUZNetWorkTool huz_GET:rul parameters:@{} success:^(id  _Nonnull responseObject) {
        NSString *code = responseObject[@"code"];
        if ([code integerValue] == 0) {
            weakSelf.majorInfoModel = [HUZMajorInfoModel modelWithJSON:responseObject[@"data"]];
            weakSelf.majorInfoHeaderView.infoModel = weakSelf.majorInfoModel;
            self.majorBasicInfoTableView.infoModel = weakSelf.majorInfoModel;
            weakSelf.uniInfoBottomView.btnCollect.selected = weakSelf.majorInfoModel.attention;
        }else{
            [weakSelf presentErrorSheet:responseObject[@"msg"]];
        }
        [weakSelf removeOverFlowActivityView];
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        [weakSelf removeOverFlowActivityView];
        [weakSelf presentErrorSheet:error];
    }];
}

- (void)clickShare{
    HUZShareView *shareView = [HUZShareView new];
    [shareView show];
    shareView.block = ^(NSString * _Nonnull platform) {
        
    };
}

#pragma mark NETWork
- (void)focusMajor:(UIButton *) sender {
    HUZWEAK_SELF
    [self displayOverFlowActivityView];
    [HUZMineService getSaveFollowWithParameters:@{@"type":@"1",@"id":self.majorId} success:^(NSString * _Nonnull success) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        if (strongSelf.majorInfoModel.attention) {
            strongSelf.majorInfoModel.attention = NO;
            [strongSelf presentSuccessSheet:@"取消关注"];
            sender.selected = NO;
        }else{
            [strongSelf presentSuccessSheet:@"关注成功"];
            strongSelf.majorInfoModel.attention = YES;
            sender.selected = YES;
        }

    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        [strongSelf presentErrorSheet:errorStr];
    }];
}


#pragma mark - Lazy
- (HUZMajorInfoHeaderView *)majorInfoHeaderView{
    CGFloat H = HUZSCREEN_WIDTH >= 414 ? 126 : 116;
    if (!_majorInfoHeaderView) {
        _majorInfoHeaderView = [[HUZMajorInfoHeaderView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, H)];
    }
    return _majorInfoHeaderView;
}

- (HUZUniInfoBottomView *)uniInfoBottomView{
    if (!_uniInfoBottomView) {
        _uniInfoBottomView = [[HUZUniInfoBottomView alloc] initWithFrame:CGRectMake(0, HUZSCREEN_HEIGHT - AutoDistance(49) - HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT, HUZSCREEN_WIDTH, AutoDistance(49))];
        [_uniInfoBottomView.btnCollect addTarget:self action:@selector(focusMajor:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _uniInfoBottomView;
}
@end


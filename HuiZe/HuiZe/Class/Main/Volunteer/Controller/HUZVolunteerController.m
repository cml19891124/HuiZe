//
//  HUZVolunteerController.m
//  HuiZe
//
//  Created by ZXS Coder on 2019/3/27.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZVolunteerController.h"
#import "HUZVolunteerListCell.h"
#import "HUZVolunteerHeadView.h"
#import "HUZGradeAnalyzeController.h"
#import "HUZUniPriorityFillController.h"
#import "HUZUniAutoFillController.h"
#import "HUZMajorPriorityController.h"

#import "HUZVolunteerPacketController.h"
#import "HUZMineVolunteerListController.h"
#import "HUZHomeBannerView.h"
#import "HUZAgreementViewController.h"
#import "HUZVolunteerShowCountCell.h"
#import "HUZUniAutoFillController.h"
#import "HUZMyVipCardViewController.h"
#import "HUZFillVolunteerController.h"
@interface HUZVolunteerController ()<SDCycleScrollViewDelegate>
@property (strong, nonatomic)HUZVolunteerHeadView *headView;
@property (nonatomic,strong) HUZHomeBannerView *bannerView;
@end

@implementation HUZVolunteerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"填志愿";
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getUserInfoData];
}
//更新本地缓存
-(void)getUserInfoData {
    [HUZNetWorkTool huz_POST:kUrl_query_userInfo parameters:nil success:^(id  _Nonnull responseObject) {
        HUZWEAK_SELF;
        NSString *code = responseObject[@"code"];
        if ([code integerValue] == 0) {
            HUZUser *model = [HUZUser modelWithJSON:responseObject[@"data"]];
            HUZUserCenterManager.userModel = model;
            [HUZUserCenterManager saveToCache];
            [weakSelf.tableView reloadData];
        } else {
        }
    } failure:^(NSUInteger statusCode, NSString *error) {
        
    }];
}

- (void)configComponents{
    [super configComponents];
    
    NSMutableArray *array = [NSMutableArray array];
    NSArray *imageArray = @[@"",@"ic_vol_auto",@"ic_vol_school",@"ic_vol_profess",@"ic_vol_hand"];
    NSArray *titleArray = @[@"",@"智能填报志愿",@"院校优先填报",@"专业优先填报",@"手动填报志愿"];
    NSArray *subtitleArray = @[@"",@"智能生成最佳志愿表",@"先选大学、再选专业",@"先选择专业、再看大学",@"手动填写志愿报"];

    for (int i = 0; i < imageArray.count; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:imageArray[i] forKey:@"image"];
        [dic setValue:titleArray[i] forKey:@"title"];
        [dic setValue:subtitleArray[i] forKey:@"subtitle"];
        [array addObject:dic];
    }
    
    [self.tableView dz_registerNibCell:[HUZVolunteerShowCountCell class]];
    
    self.dataSource = [array mutableCopy];
    self.cellHeight = AutoDistance(77);
    self.tableView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView dz_registerCell:[HUZVolunteerListCell class]];
    self.tableView.tableHeaderView = self.bannerView;
    
    [self loadBanner];
}

/// banner图
- (void)loadBanner{
    HUZWEAK_SELF
    [HUZHomeService getBanner:@{@"type":@"5"} success:^(HUZBannerModel * model) {
        HUZSTRONG_SELF
        strongSelf.bannerView.banners = model.data;
        [strongSelf.tableView.mj_header endRefreshing];
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf presentErrorSheet:errorStr];
        [strongSelf.tableView.mj_header endRefreshing];
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HUZVolunteerShowCountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HUZVolunteerShowCountCell"];
        cell.userModel = HUZUserCenterManager.userModel;
        HUZWEAK_SELF;
        [cell.leftBgView addTapAction:^(id  _Nonnull sender) {
            HUZVolunteerPacketController *volPack = [HUZVolunteerPacketController new];
            [weakSelf.navigationController pushViewController:volPack animated:YES];
        }];
        
        [cell.rightBgView addTapAction:^(id  _Nonnull sender) {
            HUZMineVolunteerListController *volList = [HUZMineVolunteerListController new];
            [weakSelf.navigationController pushViewController:volList animated:YES];

        }];
        
        return cell;
    }
    HUZVolunteerListCell *cell = [HUZVolunteerListCell cellWithTableView:tableView];
    [cell setDic:self.dataSource[indexPath.section]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger vipState = [HUZUserCenterManager.userModel.vip integerValue];
    if (indexPath.section == 0) {
        return;
    }
    if (indexPath.section == 1) {
        HUZUniAutoFillController *autoFill = [HUZUniAutoFillController new];
        [self.navigationController pushViewController:autoFill animated:YES];
    }
    else if (indexPath.section == 2) {
        HUZUniPriorityFillController *uni = [HUZUniPriorityFillController new];
        [self.navigationController pushViewController:uni animated:YES];
    }
    else if (indexPath.section == 3) {
        HUZMajorPriorityController *major = [HUZMajorPriorityController new];
        [self.navigationController pushViewController:major animated:YES];

    }
    else if (indexPath.section == 4) {
        HUZFillVolunteerController *packet = [HUZFillVolunteerController new];
        [self.navigationController pushViewController:packet animated:YES];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return AutoDistance(12.0);
    }
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = self.tableView.backgroundColor;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return AutoDistance(4);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = self.tableView.backgroundColor;
    return view;
}

- (HUZVolunteerHeadView *)headView {
    __weak typeof(self)weakSelf = self;
    if (!_headView) {
        _headView = [[HUZVolunteerHeadView alloc]initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(280))];
        _headView.reportBlock = ^{
            HUZGradeAnalyzeController *gradeAnalyze = [HUZGradeAnalyzeController new];
            [weakSelf.navigationController pushViewController:gradeAnalyze animated:YES];
        };
        _headView.leftView.tapClick = ^{ // 我的备选
            HUZVolunteerPacketController *volPack = [HUZVolunteerPacketController new];
            [weakSelf.navigationController pushViewController:volPack animated:YES];
        };
        _headView.rightView.tapClick = ^{ // 我的志愿表
            HUZMineVolunteerListController *volList = [HUZMineVolunteerListController new];
            [weakSelf.navigationController pushViewController:volList animated:YES];
        };
    }
    return _headView;
}
#pragma mark -- SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    HUZBannerDataModel *model = nil;
    if (self.bannerView.banners.count > index) {
        model = self.bannerView.banners[index];
    }
    
    HUZAgreementViewController *agreementVC = [[HUZAgreementViewController alloc] init];
    agreementVC.url = model.jumpUrl;
    [self.navigationController pushViewController:agreementVC animated:true];
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{}
#pragma mark -- SDCycleScrollViewDelegate end
#pragma mark -- lazy
- (HUZHomeBannerView *)bannerView{
    if (!_bannerView) {
        _bannerView = [[HUZHomeBannerView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, (HUZSCREEN_WIDTH - 30) * 0.412 + 20)];
        _bannerView.backgroundColor = UIColor.whiteColor;
        _bannerView.cycleScrollView.delegate = self;
    }
    return _bannerView;
}
#pragma mark -- lazy end
@end

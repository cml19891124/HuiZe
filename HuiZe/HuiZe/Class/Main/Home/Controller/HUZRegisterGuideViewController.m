//
//  HUZRegisterGuideViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/27.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZRegisterGuideViewController.h"
#import "HUZRegisterGuideHeaderView.h"
#import "HUZRegisterGuideCell.h"
#import "HUZCommonSenseViewController.h"
#import "HUZCommonSenseInfoViewController.h"
#import "HUZAgreementViewController.h"
#import "HUZRegisterGuideNewListVC.h"
@interface HUZRegisterGuideViewController ()

@property (nonatomic,strong) HUZRegisterGuideHeaderView *headerView;

@end

@implementation HUZRegisterGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"报考指南";
    self.view.backgroundColor = ColorS(COLOR_BG_F6F6F6);
}

- (void)configComponents{
    [super configComponents];
    
    self.cellHeight = AutoDistance(58);
    
    self.cellHeight = AutoDistance(60);
    [self.tableView dz_registerCell:[HUZRegisterGuideCell class]];
    self.headerView = [[HUZRegisterGuideHeaderView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(237)-AutoDistance(47))];
    self.tableView.tableHeaderView = self.headerView;
//    [self.headerView.btnBd addTarget:self action:@selector(clickCommonSense) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self loadRegisterData];
}

- (void)clickCommonSense{
    HUZCommonSenseViewController *commonSenseVC = [HUZCommonSenseViewController new];
    [self.navigationController pushViewController:commonSenseVC animated:YES];
}

#pragma mark NETWork
- (void)loadRegisterData{
    [self displayOverFlowActivityView];
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    HUZWEAK_SELF
    [HUZHomeService getBanner:@{@"type":@"3"} success:^(HUZBannerModel * model) {
        HUZSTRONG_SELF
        strongSelf.headerView.bannerView.banners = model.data;
        dispatch_group_leave(group);
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [HUZHomeService getRegisterGuideList:@{} success:^(HUZRegisterGuideModel * model) {
        HUZSTRONG_SELF
        [strongSelf.dataSource addObjectsFromArray:model.data];
        dispatch_group_leave(group);
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf presentErrorSheet:errorStr];
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        [strongSelf.tableView reloadData];
    });
}

#pragma mark - tableView
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    return [HUZRegisterGuideCell cellWithTableView:tableView];
}

- (void)configureCell:(HUZRegisterGuideCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    [cell reloadData:object indexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HUZRegisterGuideDataModel *model = self.dataSource[indexPath.row];
    HUZRegisterGuideNewListVC *listVC = [HUZRegisterGuideNewListVC new];
    listVC.guideId = model.Id;
    [self.navigationController pushViewController:listVC animated:true];
//    HUZCommonSenseInfoViewController *commonSenseInfoVC = [HUZCommonSenseInfoViewController new];
//    [self.navigationController pushViewController:commonSenseInfoVC animated:YES];
//    HUZRegisterGuideDataModel *model = self.dataSource[indexPath.row];
//    NSString *jumpUrl = [NSString stringWithFormat:@"http://47.107.101.26/huize/index.html#/examination/examination?id=%@",model.Id];
//    HUZAgreementViewController *agreementVC = [[HUZAgreementViewController alloc] init];
//    [self.navigationController pushViewController:agreementVC animated:true];
}
@end


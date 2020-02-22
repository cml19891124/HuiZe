//
//  HUZRegisterGuideNewListVC.m
//  HuiZe
//
//  Created by tbb on 2019/11/8.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZRegisterGuideNewListVC.h"
#import "HUZRegisterGuideNewListModel.h"
#import "HUZRegisterGuideCell.h"
#import "HUZAgreementViewController.h"
@interface HUZRegisterGuideNewListVC ()

@end

@implementation HUZRegisterGuideNewListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[HUZRegisterGuideCell class] forCellReuseIdentifier:@"HUZRegisterGuideCell"];
    [self setupRefresh:self.tableView];
    [self onStartRefresh];
}

-(void)onStartRefresh {
    self.page = 1;
    [self getGuideIdList];
}

-(void)onStartLoadMore {
    self.page ++;
    [self getGuideIdList];
}

-(void)getGuideIdList {
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    par[@"guideId"] = self.guideId;
    par[@"pageSize"] = @"20";
    par[@"pageNow"] = @(self.page);
    
    [self displayOverFlowActivityView];
    [HUZNetWorkTool huz_POST:kUrl_Guide_Encyclopedias_List parameters:par success:^(id  _Nonnull responseObject) {
        [self removeOverFlowActivityView];
        [self stopRefresh:self.tableView];
        NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([code integerValue] == 0) {
            if (self.page == 1) {
                [self.dataSource removeAllObjects];
            }
            NSArray *arr = [NSArray modelArrayWithClass:[HUZRegisterGuideNewListModel class] json:responseObject[@"data"][@"list"]];
            [self.dataSource addObjectsFromArray:arr];
            [self.tableView reloadData];
            
            if (arr.count == 0) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
        }else{
            [self presentErrorSheet:responseObject[@"msg"]];
        }
    
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        [self stopRefresh:self.tableView];
        [self removeOverFlowActivityView];
        [self presentErrorSheet:error];
    }];
    
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    HUZRegisterGuideNewListModel *listModel = nil;
    if (indexPath.row < self.dataSource.count) {
        listModel = self.dataSource[indexPath.row];
    }
    
    HUZRegisterGuideCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HUZRegisterGuideCell"];
    cell.labContent.text = listModel.title;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HUZRegisterGuideNewListModel *listModel = nil;
    if (indexPath.row < self.dataSource.count) {
        listModel = self.dataSource[indexPath.row];
    }
    return [tableView fd_heightForCellWithIdentifier:@"HUZRegisterGuideCell" configuration:^(HUZRegisterGuideCell *cell) {
        cell.labContent.text = listModel.title;
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HUZRegisterGuideNewListModel *listModel = nil;
    if (indexPath.row < self.dataSource.count) {
        listModel = self.dataSource[indexPath.row];
    }
    
    HUZAgreementViewController *agreementVC = [[HUZAgreementViewController alloc] init];
    agreementVC.navTitle = listModel.title;
    agreementVC.url = [NSString stringWithFormat:@"http://m.hz985211.com/m/news/encyclopedia/%@",listModel.Id];
    [self.navigationController pushViewController:agreementVC animated:true];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}
#pragma mark - UITableViewDelegate, UITableViewDataSource end

@end

//
//  HUZDynamicListViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/26.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZDynamicListViewController.h"
#import "HUZGkInfoListCell.h"
#import "HUZAgreementViewController.h"
@interface HUZDynamicListViewController ()

@end

@implementation HUZDynamicListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.navTitle;
    self.view.backgroundColor = ColorS(COLOR_BG_F6F6F6);

}

- (void)configComponents{
    [super configComponents];
    
    self.cellHeight = AutoDistance(110);
    self.shouldMultiSections = YES;
    [self.tableView dz_registerCell:[HUZGkInfoListCell class]];
    
    HUZWEAK_SELF
    self.tableView.mj_header = [HUZRefreshHeader headerWithRefreshingBlock:^{
        HUZSTRONG_SELF
        strongSelf.page = 1;
        [strongSelf loadGkDynamicList];
    }];
    self.tableView.mj_footer = [HUZRefreshFooter footerWithRefreshingBlock:^{
       HUZSTRONG_SELF
        strongSelf.page ++;
        [strongSelf loadGkDynamicList];
    }];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark NETWork
- (void)loadGkDynamicList{
    HUZWEAK_SELF
    [HUZHomeService getGkDynamicList:@{@"pageNow":@(self.page),@"pageSize":@(self.size),@"type":@(self.type)} success:^(HUZGkInfoModel * _Nonnull model) {
       HUZSTRONG_SELF
        if (strongSelf.page == 1) {
            [strongSelf.dataSource removeAllObjects];
        }
        [strongSelf.dataSource addObjectsFromArray:model.data.list];
        [strongSelf configEmptyViewWithError:EMPTYDATA];
        [strongSelf.tableView reloadData];
        [strongSelf.tableView.mj_header endRefreshing];
        [strongSelf.tableView.mj_footer endRefreshing];
        if (strongSelf.page >= model.data.totalPage) {
            [strongSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf configEmptyViewWithError:errorStr];
        [strongSelf.tableView reloadData];
        [strongSelf.tableView.mj_header endRefreshing];
        [strongSelf.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HUZGkInfoListCell *cell = [HUZGkInfoListCell cellWithTableView:tableView];
    [cell reloadData:self.dataSource[indexPath.section]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AutoDistance(8);
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HUZGkInfoDataListModel *model = nil;
    if (indexPath.section < self.dataSource.count) {
        model = self.dataSource[indexPath.section];
    }
//    if (model.jumpUrl.length == 0) {
//        [self presentErrorSheet:@"跳转连接为空"];
//        return;
//    }
    HUZAgreementViewController *agreementVC = [[HUZAgreementViewController alloc] init];
    agreementVC.navTitle = model.title;
    agreementVC.url = [NSString stringWithFormat:@"%@%@",@"http://m.hz985211.com/m/news/policy/",model.Id];
    [self.navigationController pushViewController:agreementVC animated:true];
}

@end


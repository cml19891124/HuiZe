//
//  HUZCommonSenseViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/28.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZCommonSenseViewController.h"
#import "HUZRegisterGuideCell.h"
#import "HUZCommonSenseInfoViewController.h"
#import "HUZCommonSenseInfoViewController.h"
#import "HUZAgreementViewController.h"
@interface HUZCommonSenseViewController ()

@end

@implementation HUZCommonSenseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"常识百科";
    self.view.backgroundColor = ColorS(COLOR_BG_F6F6F6);

}

- (void)configComponents{
    [super configComponents];
    
    self.cellHeight = AutoDistance(60);
    [self.tableView dz_registerCell:[HUZRegisterGuideCell class]];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(8));
        make.left.bottom.right.equalTo(self.view);
    }];
    
    HUZWEAK_SELF
    self.tableView.mj_header = [HUZRefreshHeader headerWithRefreshingBlock:^{
        HUZSTRONG_SELF
        strongSelf.page = 1;
        [strongSelf loadCommonList];
    }];
    self.tableView.mj_footer = [HUZRefreshFooter footerWithRefreshingBlock:^{
        HUZSTRONG_SELF
        strongSelf.page ++;
        [strongSelf loadCommonList];
    }];
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadCommonList{
    HUZWEAK_SELF
    [HUZHomeService getCommonSense:@{} success:^(HUZCommonSenseModel * model) {
        HUZSTRONG_SELF
        if (strongSelf.page == 1) {
            [strongSelf.dataSource removeAllObjects];
        }
        [strongSelf.dataSource addObjectsFromArray:model.data.list];
        [strongSelf configEmptyViewWithError:EMPTYDATA];
        [strongSelf.tableView.mj_header endRefreshing];
        [strongSelf.tableView.mj_footer endRefreshing];
        [strongSelf.tableView reloadData];
        if (strongSelf.page >= model.data.totalPage) {
            [strongSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf presentErrorSheet:errorStr];
        [strongSelf configEmptyViewWithError:EMPTYDATA];
        [strongSelf.tableView.mj_header endRefreshing];
        [strongSelf.tableView.mj_footer endRefreshing];
        [strongSelf.tableView reloadData];
    }];
}

#pragma mark - tableView
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    return [HUZRegisterGuideCell cellWithTableView:tableView];
}

- (void)configureCell:(HUZRegisterGuideCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    [cell reloadData:object indexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    HUZCommonSenseInfoViewController *commonSenseInfoVC = [HUZCommonSenseInfoViewController new];
//    [self.navigationController pushViewController:commonSenseInfoVC animated:YES];
    HUZCommonSenseDataListModel *model = self.dataSource[indexPath.row];
    NSString *jumpUrl = [NSString stringWithFormat:@"http://47.107.101.26/huize/index.html#/examination/examination?id=%@",model.Id];
    HUZAgreementViewController *agreementVC = [[HUZAgreementViewController alloc] init];
    agreementVC.url = jumpUrl;
    [self.navigationController pushViewController:agreementVC animated:true];
}
@end

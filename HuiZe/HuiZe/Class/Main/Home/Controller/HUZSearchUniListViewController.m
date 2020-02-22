//
//  HUZSearchUniListViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/24.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZSearchUniListViewController.h"
#import "HUZHistoryStudentsPlanCell.h"
#import "HUZSearchUlikeUniModel.h"
#import "HUZUniInfoViewController.h"
@interface HUZSearchUniListViewController ()

@end

@implementation HUZSearchUniListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ColorS(COLOR_BG_F6F6F6);
}

- (void)configComponents{
    [super configComponents];
    
    self.cellHeight = AutoDistance(110);
    [self.tableView dz_registerCell:[HUZHistoryStudentsPlanCell class]];
    
    HUZWEAK_SELF
    self.tableView.mj_header = [HUZRefreshHeader headerWithRefreshingBlock:^{
        HUZSTRONG_SELF
        strongSelf.page = 1;
        [strongSelf loadUniList];
    }];
    self.tableView.mj_footer = [HUZRefreshFooter footerWithRefreshingBlock:^{
       HUZSTRONG_SELF
        strongSelf.page ++;
        [strongSelf loadUniList];
    }];
    [self.tableView.mj_header beginRefreshing];
}

- (void)reloadDataWithCategory:(int)category address:(int)address keyOne:(int)keyOnde schoolPrivate:(int)schoolPrivate schoolType:(int)schoolType{
    _category = category;
    _address = address;
    _keyOne = keyOnde;
    _schoolPrivate = schoolPrivate;
    _schoolType = schoolType;
    self.page = 1;
    [self.tableView.mj_header beginRefreshing];
}
// api/searchUniversity/listAllUniversity
#pragma mark NETWork
- (void)loadUniList{
//    if (self.schoolType < 0) {
//        self.schoolType = 0;
//    }

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"currPage"] = @(self.page);
    params[@"pageSize"] = @(self.size);
    if (self.category >= 0) {
        params[@"category"] = @(self.category);
    }
    if (self.address > 0) {
        params[@"address"] = @(self.address);
    }
    if (self.keyOne > 0) {
        params[@"keyOne"] = @(self.keyOne);
    }
    if (self.schoolPrivate >= 0) {
        params[@"schoolPrivate"] = @(self.schoolPrivate);
    }
    if (self.schoolType>=0) {
        params[@"schoolType"] = @(self.schoolType);
    }
    if (self.type >= 0) {
        params[@"type"] = @(self.type);
    }

//    if (self.schoolType < 0) {
//        params = @{@"currPage":@(self.page),@"pageSize":@(self.size),@"category":@(self.category),@"type":@(self.type)};
//    }
    
    HUZWEAK_SELF
    [HUZHomeService getSearchAllUniList:params success:^(HUZSearchUlikeUniModel * _Nonnull model) {
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
        [strongSelf configEmptyViewWithError:errorStr];
        [strongSelf.tableView.mj_header endRefreshing];
        [strongSelf.tableView.mj_footer endRefreshing];
        [strongSelf.tableView reloadData];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    return [HUZHistoryStudentsPlanCell cellWithTableView:tableView];
}

- (void)configureCell:(HUZHistoryStudentsPlanCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    [cell reloadData:object];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HUZSearchUlikeUniDataListModel *listModel = self.dataSource[indexPath.row];
    HUZUniInfoViewController *uniInfoVC = [HUZUniInfoViewController new];
    uniInfoVC.schoolId = listModel.schoolId;
    [self.navigationController pushViewController:uniInfoVC animated:true];
}
@end

//
//  HUZUlikeUniViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/14.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUlikeUniViewController.h"
#import "HUZHistoryStudentsPlanCell.h"
#import "HUZUniInfoViewController.h"
@interface HUZUlikeUniViewController ()

@end

@implementation HUZUlikeUniViewController

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
    self.tableView.mj_footer = [HUZRefreshFooter footerWithRefreshingBlock:^{
       HUZSTRONG_SELF
        strongSelf.page ++;
        if (strongSelf.type == 1) {
            [strongSelf loadUlikeUniList];
        }else{
            [strongSelf loadHotList];
        }
    }];
    if (self.type == 1) {
        [self loadUlikeUniList];
    }else{
        [self loadHotList];
    }
}

#pragma mark NETWork
/// 刷新猜你喜欢模块
- (void)reloadUlikeListWithCategory:(int)category address:(int)address keyOne:(int)keyOne schoolPrivate:(int)schoolPrivate schoolType:(int)schoolType{
    _category = category;
    _address = address;
    _keyOne = keyOne;
    _schoolPrivate = schoolPrivate;
    _schoolType = schoolType;
    self.page = 1;
    [self loadUlikeUniList];
}

/// 查大学---猜你喜欢
- (void)loadUlikeUniList{
    NSDictionary *params = @{@"currPage":@(self.page),@"pageSize":@(self.size),@"category":@(self.category),@"address":@(self.address),@"keyOne":@(self.keyOne),@"schoolPrivate":@(self.schoolPrivate),@"schoolType":@(self.schoolType)};
    HUZWEAK_SELF
    [self displayOverFlowActivityView];
    [HUZHomeService getSearchUniUlike:params success:^(HUZSearchUlikeUniModel * _Nonnull model) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        if (strongSelf.page == 1) {
            [strongSelf.dataSource removeAllObjects];
        }
        [strongSelf.dataSource addObjectsFromArray:model.data.list];
        [strongSelf configEmptyViewWithError:EMPTYDATA];
        [strongSelf.tableView.mj_footer endRefreshing];
        [strongSelf.tableView reloadData];
        if (strongSelf.page >= model.data.totalPage) {
            [strongSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        [strongSelf configEmptyViewWithError:errorStr];
        [strongSelf.tableView.mj_footer endRefreshing];
        [strongSelf.tableView reloadData];
    }];
}

/// 名企热招
- (void)loadHotList{
    NSDictionary *params = @{@"currPage":@(self.page),@"pageSize":@(self.size),@"enterpriseId":@"0"};
    HUZWEAK_SELF
    [self displayOverFlowActivityView];
    [HUZHomeService getSearchUniHot:params success:^(HUZSearchUlikeUniModel * _Nonnull model) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        if (strongSelf.page == 1) {
            [strongSelf.dataSource removeAllObjects];
        }
        [strongSelf.dataSource addObjectsFromArray:model.data.list];
        [strongSelf.tableView.mj_footer endRefreshing];
        [strongSelf.tableView reloadData];
        if (strongSelf.page >= model.data.totalPage) {
            [strongSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        [strongSelf presentErrorSheet:errorStr];
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

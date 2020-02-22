//
//  HUZSearchSchoolResultViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/26.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZSearchSchoolResultViewController.h"
#import "HUZSearchSchoolCell.h"
#import "HUZUniInfoViewController.h"
@interface HUZSearchSchoolResultViewController ()

@property (nonatomic,strong) NSString *keyword;

@end

@implementation HUZSearchSchoolResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
}

- (void)configComponents{
    [super configComponents];
    
    self.cellHeight = AutoDistance(81);
    
    [self.tableView dz_registerCell:[HUZSearchSchoolCell class]];
    
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
}

/// 搜索大学
- (void)searchUniWithKeyword:(NSString *)keyword{
    self.keyword = keyword;
    self.page = 1;
    [self loadUniList];
}

- (void)loadUniList{
    HUZWEAK_SELF
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    par[@"keyWord"] = self.keyword;
    par[@"pageNow"] = @(self.page);
    par[@"pageSize"] = @"20";
    //@{@"keyWord":self.keyword,@"pageNow":@(self.page),@"pageSize":@(self.size)}
    [HUZHomeService getSearchUniList:par success:^(HUZSearchUniModel * _Nonnull model) {
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
    return [HUZSearchSchoolCell cellWithTableView:tableView];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HUZSearchUniDataListModel *model = nil;
    if (self.dataSource.count > indexPath.row) {
        model = self.dataSource[indexPath.row];
    }
    HUZUniInfoViewController *uniInfoVC = [HUZUniInfoViewController new];
    uniInfoVC.schoolId = model.schoolId;
    [self.navigationController pushViewController:uniInfoVC animated:true];
}

- (void)configureCell:(HUZSearchSchoolCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    [cell reloadData:object];
}

@end

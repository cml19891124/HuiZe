//
//  HUZGkInfoListViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/19.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZGkInfoListViewController.h"
#import "HUZGkInfoListCell.h"
#import "HUZGkInfoListViewController.h"
#import "HUZGkInfoModel.h"
#import "HUZAgreementViewController.h"
@interface HUZGkInfoListViewController ()
@property (nonatomic, assign) BOOL fingerIsTouch;

@end

@implementation HUZGkInfoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

#pragma mark Overwrite
- (void)configComponents{
    [super configComponents];
    
    self.cellHeight = 110+8;
    [self.tableView dz_registerCell:[HUZGkInfoListCell class]];
    
    /// 加载数据
    HUZWEAK_SELF
    self.tableView.mj_footer = [HUZRefreshFooter footerWithRefreshingBlock:^{
        HUZSTRONG_SELF
        strongSelf.page++;
        [strongSelf loadGkInfoList];
    }];
    [self loadGkInfoList];
}

- (void)reloadDataAgain{
    self.page = 1;
    [self loadGkInfoList];
}

#pragma mark Setter
- (void)setIsRefresh:(BOOL)isRefresh{
    _isRefresh = isRefresh;
}

#pragma mark - tableView
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [HUZGkInfoListCell cellWithTableView:tableView];
}

- (void)configureCell:(HUZGkInfoListCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    [cell reloadData:object];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HUZGkInfoDataListModel *model = nil;
    if (indexPath.row < self.dataSource.count) {
        model = self.dataSource[indexPath.row];
    }
    HUZAgreementViewController *agreementVC = [[HUZAgreementViewController alloc] init];
    agreementVC.navTitle = model.title;
    agreementVC.url = [NSString stringWithFormat:@"%@%@",@"http://m.hz985211.com/m/news/",model.Id];
    [self.navigationController pushViewController:agreementVC animated:true];
}

#pragma mark UIScrollView
//判断屏幕触碰状态
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.fingerIsTouch = YES;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    self.fingerIsTouch = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!self.vcCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    if (scrollView.contentOffset.y <= 0) {
        //        if (!self.fingerIsTouch) {//这里的作用是在手指离开屏幕后也不让显示主视图，具体可以自己看看效果
        //            return;
        //        }
        self.vcCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTop" object:nil];//到顶通知父视图改变状态
    }
    self.tableView.showsVerticalScrollIndicator = _vcCanScroll?YES:NO;
}

#pragma mark NETWork
- (void)loadGkInfoList{
    HUZWEAK_SELF
    [HUZHomeService getGkInfoList:@{@"pageNow":@(self.page),@"pageSize":@(self.size),@"type":@(self.listId)} success:^(HUZGkInfoModel * model) {
        HUZSTRONG_SELF
        [strongSelf.dataSource addObjectsFromArray:model.data.list];
        [strongSelf configEmptyViewWithErrorRequest:EMPTYDATA];
        [strongSelf.tableView.mj_footer endRefreshing];
        [strongSelf.tableView reloadData];
        if (strongSelf.page >= model.data.totalPage) {
            [strongSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf configEmptyViewWithErrorRequest:errorStr];
        [strongSelf.tableView.mj_footer endRefreshing];
        [strongSelf.tableView reloadData];
    }];
}

@end

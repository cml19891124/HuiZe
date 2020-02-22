//
//  HUZFriendController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/18.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZFriendController.h"
#import "HUZPostInfoViewController.h"
#import "HUZFriendPostHeaderView.h"
#import "HUZFriendCell.h"
#import "HUZGkTreasureCommentCell.h"

@interface HUZFriendController ()

@property (nonatomic,strong) NSMutableArray *dataType;
@property (nonatomic,strong) NSMutableArray *dataCommonPost;
@property (nonatomic,strong) NSMutableArray *dataSpecialPost;
@property (nonatomic,assign) int totalPage;
@property (nonatomic, assign) BOOL isUpdate;
@end

@implementation HUZFriendController

- (void)dealloc{
    [KNotificationCenter removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationItem setHidesBackButton:YES];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController.navigationBar.backItem setHidesBackButton:YES];
    
    self.isUpdate = NO;
    self.navigationItem.title = @"";
    self.view.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    [self removeUIPanGestureRecognizer];
    
    [KNotificationCenter addObserver:self selector:@selector(lickSuccess:) name:LikeSuccess object:nil];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.isUpdate) {
        [self loadData];
    }
    CGFloat y = self.tableView.contentOffset.y;
    if (y>0) {
        CGFloat alpha=self.tableView.contentOffset.y/HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT>1.0f?1:self.tableView.contentOffset.y/HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT;
        [self.navigationController.navigationBar setBackgroundImage:[UIImage getImageWithAlpha:alpha] forBarMetrics:UIBarMetricsDefault];
        self.navigationItem.title = @"朋友圈";
//        [self showBarButton:NAV_LEFT imageName:NAV_BACK_BLACK];
        if (y>HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT) {
            self.navigationController.navigationBar.translucent = NO;
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        }else{
            self.navigationController.navigationBar.translucent = YES;
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        }
    }else{
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.translucent = YES;
        self.navigationItem.title = @"";
        [self showBarButton:NAV_LEFT imageName:NAV_BACK_WHITE];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)configComponents{
    [super configComponents];
    
    [self.tableView dz_registerCell:[HUZFriendCell class]];
    [self.tableView dz_registerCell:[HUZGkTreasureCommentCell class]];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(-HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT);
        make.left.bottom.right.equalTo(self.view);
    }];
    HUZWEAK_SELF
    self.tableView.mj_header = [HUZRefreshHeader headerWithRefreshingBlock:^{
        HUZSTRONG_SELF
        strongSelf.page = 1;
        [strongSelf loadData];
    }];
    self.tableView.mj_footer = [HUZRefreshFooter footerWithRefreshingBlock:^{
        HUZSTRONG_SELF
        strongSelf.page ++;
        [strongSelf loadData];
    }];
    [self.tableView.mj_header beginRefreshing];
}

- (void)configStyle{
    self.style = UITableViewStyleGrouped;
}

#pragma mark notify
- (void)lickSuccess:(NSNotification *)noti{
    HUZFriendListDataListModel *model = noti.object[@"model"];
    for (HUZFriendListDataListModel *commonModel in self.dataCommonPost) {
        if ([commonModel.id isEqualToString:model.id]) {
            commonModel.isClick = @"1";
            commonModel.likeNum = model.likeNum;
        }
    }
    for (HUZFriendListDataListModel *specicalModel in self.dataSpecialPost) {
        if ([specicalModel.id isEqualToString:model.id]) {
            specicalModel.isClick = @"1";
            specicalModel.likeNum = model.likeNum;
        }
    }
    [self.tableView reloadData];
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? self.dataSpecialPost.count : self.dataCommonPost.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return AutoDistance(8);
    }
    return DRArrayIsEmpty(self.dataType) ? 0.0001f : AutoDistance(240);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return [UIView new];
    }else{
        if (DRArrayIsEmpty(self.dataType)) {
            return [UIView new];
        }
        HUZFriendPostHeaderView *friendPostHeaderView = [[HUZFriendPostHeaderView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(240))];
        friendPostHeaderView.datas = self.dataType;
        return friendPostHeaderView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [HUZFriendCell calculateHeightWithEntity:self.dataSpecialPost[indexPath.row]];
    }else{
        return [HUZGkTreasureCommentCell calculateHeightWithEntity:self.dataCommonPost[indexPath.row]];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HUZFriendCell *cell = [HUZFriendCell cellWithTableView:tableView];
        [cell reloadData:self.dataSpecialPost[indexPath.row]];
        return cell;
    }else{
        HUZGkTreasureCommentCell *cell = [HUZGkTreasureCommentCell cellWithTableView:tableView];
        [cell reloadData:self.dataCommonPost[indexPath.row]];
        cell.btnLike.tag = indexPath.row;
        [cell.btnLike addTarget:self action:@selector(like:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HUZPostInfoViewController *postInfoVC = [HUZPostInfoViewController new];
    HUZFriendListDataListModel *model = indexPath.section == 0 ? self.dataSpecialPost[indexPath.row] : self.dataCommonPost[indexPath.row];
    postInfoVC.model = model;
    [self.navigationController pushViewController:postInfoVC animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = self.tableView.contentOffset.y;
    if (y>0) {
        CGFloat alpha=self.tableView.contentOffset.y/HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT>1.0f?1:self.tableView.contentOffset.y/HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT;
        [self.navigationController.navigationBar setBackgroundImage:[UIImage getImageWithAlpha:alpha] forBarMetrics:UIBarMetricsDefault];
        self.navigationItem.title = @"朋友圈";
//        [self showBarButton:NAV_LEFT imageName:NAV_BACK_BLACK];
        if (y>HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT) {
            self.navigationController.navigationBar.translucent = NO;
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        }else{
            self.navigationController.navigationBar.translucent = YES;
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        }
    }
    else{
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.translucent = YES;
        self.navigationItem.title = @"";
        [self showBarButton:NAV_LEFT imageName:NAV_BACK_WHITE];
    }
}



#pragma mark NETWork
- (void)loadData{
    dispatch_group_t group = dispatch_group_create();
    
    /// 分类列表
    dispatch_group_enter(group);
    HUZWEAK_SELF
    [HUZFriendService getFriendReleaseType:nil success:^(HUZFriendReleaseTypeModel * model) {
        HUZSTRONG_SELF
        [strongSelf.dataType removeAllObjects];
        [strongSelf.dataType addObjectsFromArray:model.data];
        dispatch_group_leave(group);
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        dispatch_group_leave(group);
    }];
    
    /// 加精帖列表
    dispatch_group_enter(group);
    [HUZFriendService getFriendRefinementList:@{@"pageNow":@"1",@"pageSize":@"3"} success:^(HUZFriendListModel * model) {
        HUZSTRONG_SELF
        [strongSelf.dataSpecialPost removeAllObjects];
        [strongSelf.dataSpecialPost addObjectsFromArray:model.data.list];
        dispatch_group_leave(group);
        
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        dispatch_group_leave(group);
    }];

    /// 普通帖子列表
    dispatch_group_enter(group);
    [HUZFriendService getFriendList:@{@"pageNow":@(self.page),@"pageSize":@(self.size)} success:^(HUZFriendListModel * model) {
        HUZSTRONG_SELF
        if (strongSelf.page == 1) {
            [strongSelf.dataCommonPost removeAllObjects];
        }
        strongSelf.totalPage = model.data.totalPage;
        [strongSelf.dataCommonPost addObjectsFromArray:model.data.list];
        dispatch_group_leave(group);
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
       HUZSTRONG_SELF
        self.isUpdate = YES;
        if (DRArrayIsEmpty(self.dataCommonPost) && DRArrayIsEmpty(self.dataSpecialPost)) {
            [strongSelf configEmptyViewWithError:EMPTYDATA];
        }
        [strongSelf.tableView.mj_header endRefreshing];
        [strongSelf.tableView.mj_footer endRefreshing];
        [strongSelf.tableView reloadData];
        if (strongSelf.page >= strongSelf.totalPage) {
            [strongSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    });

}

/// 点赞
- (void)like:(UIButton *)sender{
    if (sender.selected) {
        return;
    }
    HUZFriendListDataListModel *postModel = self.dataCommonPost[sender.tag];
    HUZWEAK_SELF
    [self displayOverFlowActivityView];
    [HUZFriendService getPostLike:@{@"id":postModel.id} success:^(HUZModel * model) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        postModel.isClick = @"1";
        int likeNum = [postModel.likeNum intValue];
        postModel.likeNum = [NSString stringWithFormat:@"%d",likeNum+1];
        [strongSelf.tableView reloadData];
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        [strongSelf presentErrorSheet:errorStr];
    }];
}


#pragma mark - Lazy
- (NSMutableArray *)dataType{
    if (!_dataType) {
        _dataType = [NSMutableArray new];
    }
    return _dataType;
}

- (NSMutableArray *)dataCommonPost{
    if (!_dataCommonPost) {
        _dataCommonPost = [NSMutableArray new];
    }
    return _dataCommonPost;
}

- (NSMutableArray *)dataSpecialPost{
    if (!_dataSpecialPost) {
        _dataSpecialPost = [NSMutableArray new];
    }
    return _dataSpecialPost;
}
@end


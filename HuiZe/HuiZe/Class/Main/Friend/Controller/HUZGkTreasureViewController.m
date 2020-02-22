//
//  HUZGkTreasureViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/29.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZGkTreasureViewController.h"
#import "HUZGkTreasureHeaderView.h"
#import "HUZGkTreasurePostCell.h"
#import "HUZGkTreasureCommentCell.h"
#import "HUZPostInfoViewController.h"

#import "HUZCommentInputView.h"

@interface HUZGkTreasureViewController ()<UIScrollViewDelegate,HUZCommentInputDelegate>

@property (nonatomic,strong) UIButton *btnPost;
@property (nonatomic,strong) NSMutableArray *dataCommonPost;
@property (nonatomic,strong) NSMutableArray *dataSpecialPost;
@property (nonatomic,assign) int totalPage;
@property (nonatomic,strong) HUZCommentInputView *commentInputView;


@end

@implementation HUZGkTreasureViewController

- (void)dealloc{
    [KNotificationCenter removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    
    [KNotificationCenter addObserver:self selector:@selector(lickSuccess:) name:LikeSuccess object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    CGFloat y = self.tableView.contentOffset.y;
    if (y>0) {
        CGFloat alpha=self.tableView.contentOffset.y/HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT>1.0f?1:self.tableView.contentOffset.y/HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT;
        [self.navigationController.navigationBar setBackgroundImage:[UIImage getImageWithAlpha:alpha] forBarMetrics:UIBarMetricsDefault];
        self.title = self.model.typeName;
        [self showBarButton:NAV_LEFT imageName:NAV_BACK_BLACK];
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
        self.title = @"";
        [self showBarButton:NAV_LEFT imageName:NAV_BACK_WHITE];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
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

- (void)configComponents{
    [super configComponents];
    
    [self.tableView dz_registerCell:[HUZGkTreasurePostCell class]];
    [self.tableView dz_registerCell:[HUZGkTreasureCommentCell class]];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(-HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT);
        make.left.bottom.right.equalTo(self.view);
    }];
    
    [self.view addSubview:self.btnPost];
    [self.btnPost addTarget:self action:@selector(clickPost) forControlEvents:UIControlEventTouchUpInside];
    
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


/// 发帖弹窗
- (void)clickPost{
    [self.commentInputView show];
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? self.dataSpecialPost.count : self.dataCommonPost.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [HUZGkTreasurePostCell calculateHeightWithEntity:self.dataSpecialPost[indexPath.row]];
    }else{
        return [HUZGkTreasureCommentCell calculateHeightWithEntity:self.dataCommonPost[indexPath.row]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) return AutoDistance(216);
    return AutoDistance(12);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HUZGkTreasurePostCell *cell = [HUZGkTreasurePostCell cellWithTableView:tableView];
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        HUZGkTreasureHeaderView *headerView = [[HUZGkTreasureHeaderView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, 216)];
        headerView.model = self.model;
        return headerView;
    }
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HUZPostInfoViewController *postInfoVC = [HUZPostInfoViewController new];
    HUZFriendListDataListModel *model = indexPath.section == 0 ? self.dataSpecialPost[indexPath.row] : self.dataCommonPost[indexPath.row];
    postInfoVC.model = model;
    [self.navigationController pushViewController:postInfoVC animated:YES];
}

#pragma mark - HUZCommentInputDelegate
- (void)commitComment:(NSString *)comment{
    if (DRStringIsEmpty(comment)) {
        return [self presentSheet:@"请输入内容"];
    }
    [self.commentInputView dismiss];
    [self.commentInputView reset];
    [self clickPost:comment];
}

#pragma mark - NETWork
- (void)loadData{
    dispatch_group_t group = dispatch_group_create();
    
    /// 加精帖列表
    dispatch_group_enter(group);
    HUZWEAK_SELF
    [HUZFriendService getFriendRefinementList:@{@"pageNow":@"1",@"pageSize":@"100",@"typeId":self.model.id} success:^(HUZFriendListModel * model) {
        HUZSTRONG_SELF
        [strongSelf.dataSpecialPost removeAllObjects];
        [strongSelf.dataSpecialPost addObjectsFromArray:model.data.list];
        dispatch_group_leave(group);
        
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        dispatch_group_leave(group);
    }];
    
    /// 普通帖子列表
    dispatch_group_enter(group);
    [HUZFriendService getFriendList:@{@"pageNow":@(self.page),@"pageSize":@(self.size),@"typeId":self.model.id} success:^(HUZFriendListModel * model) {
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
        [strongSelf.tableView.mj_header endRefreshing];
        [strongSelf.tableView.mj_footer endRefreshing];
        if (strongSelf.page >= strongSelf.totalPage) {
            [strongSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [strongSelf.tableView reloadData];
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
        KPostNotification(LikeSuccess, @{@"model":postModel});
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        [strongSelf presentErrorSheet:errorStr];
    }];
}

/// 发帖
- (void)clickPost:(NSString *)content{
    HUZWEAK_SELF
    [self displayOverFlowActivityView];
    
    [HUZFriendService getFriendSave:@{@"typeId":self.model.id,@"content":content} success:^(HUZModel * model) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        [strongSelf presentSuccessSheet:@"发布成功"];
        
        NSInteger releaseSum = [self.model.releaseSum integerValue];
        if (self.model.releaseSum.length == 0) {
            self.model.releaseSum = @"1";
        }else{
            releaseSum += 1;
            self.model.releaseSum = [NSString stringWithFormat:@"%zd",releaseSum];
        }
        
        strongSelf.page = 1;
        [strongSelf loadData];
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        [strongSelf presentErrorSheet:errorStr];
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = self.tableView.contentOffset.y;
    if (y>0) {
        CGFloat alpha=self.tableView.contentOffset.y/HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT>1.0f?1:self.tableView.contentOffset.y/HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT;
        [self.navigationController.navigationBar setBackgroundImage:[UIImage getImageWithAlpha:alpha] forBarMetrics:UIBarMetricsDefault];
        self.title = self.model.typeName;
        [self showBarButton:NAV_LEFT imageName:NAV_BACK_BLACK];
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
        self.title = @"";
        [self showBarButton:NAV_LEFT imageName:NAV_BACK_WHITE];
    }
}

#pragma mark - Lazy
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

- (UIButton *)btnPost{
    if (!_btnPost) {
        _btnPost = [[UIButton alloc] initWithFrame:CGRectMake(HUZSCREEN_WIDTH-AutoDistance(95), HUZSCREEN_HEIGHT-HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT-AutoDistance(130), AutoDistance(79), AutoDistance(79))];
        [_btnPost setImage:ImageNamed(@"ic_post") forState:UIControlStateNormal];
    }
    return _btnPost;
}

- (HUZCommentInputView *)commentInputView{
    if (!_commentInputView) {
        _commentInputView = [[HUZCommentInputView alloc] init];
        _commentInputView.title = @"发帖";
        _commentInputView.delegate = self;
    }
    return _commentInputView;
}

@end

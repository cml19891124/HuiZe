//
//  HUZPostInfoViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/5.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZPostInfoViewController.h"
#import "HUZPostInfoHeaderView.h"
#import "HUZPostInfoFooterView.h"
#import "HUZPostInfoCell.h"
#import "HUZCommentInputView.h"

@interface HUZPostInfoViewController ()<HUZCommentInputDelegate>

@property (nonatomic,strong) HUZPostInfoHeaderView *postInfoHeaderView;
@property (nonatomic,strong) HUZPostInfoFooterView *postInfoFooterView;
@property (nonatomic,strong) HUZCommentInputView *commentInputView;
@property (nonatomic, copy) NSString * rank;
@end

@implementation HUZPostInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"帖子详情";
    self.view.backgroundColor = ColorS(COLOR_BG_F6F6F6);
//    [self showBarButton:NAV_RIGHT imageName:@"btn_share_uni"];
}

- (void)rightButtonTouch{
    HUZShareView *shareView = [HUZShareView new];
    [shareView show];
    shareView.block = ^(NSString * _Nonnull platform) {
        
    };
}

- (void)configComponents{
    [super configComponents];
    
    self.postInfoHeaderView = [[HUZPostInfoHeaderView alloc] init];
    [self.postInfoHeaderView.btnRanking addTarget:self action:@selector(rankingAction:) forControlEvents:(UIControlEventTouchUpInside)];
    /// 设置数据,适配高度
    self.postInfoHeaderView.model = self.model;
    self.postInfoHeaderView.frame = CGRectMake(0, 0, HUZSCREEN_WIDTH, [self.postInfoHeaderView cacluateHeightWithModel:self.model]);
    self.tableView.tableHeaderView = self.postInfoHeaderView;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(49))];
    self.tableView.tableFooterView = footerView;
    [self.tableView dz_registerCell:[HUZPostInfoCell class]];
    
    self.postInfoFooterView = [[HUZPostInfoFooterView alloc] initWithFrame:CGRectMake(0, HUZSCREEN_HEIGHT-HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT-AutoDistance(49), HUZSCREEN_WIDTH, AutoDistance(49))];
    [self.view addSubview:self.postInfoFooterView];
    [self.postInfoFooterView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(inputClick)]];
    
    
    HUZWEAK_SELF
    self.tableView.mj_header = [HUZRefreshHeader headerWithRefreshingBlock:^{
        HUZSTRONG_SELF
        strongSelf.page = 1;
        [strongSelf loadCommentList];
    }];
    self.tableView.mj_footer = [HUZRefreshFooter footerWithRefreshingBlock:^{
        HUZSTRONG_SELF
        strongSelf.page ++;
        [strongSelf loadCommentList];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    /// 点赞
    self.postInfoHeaderView.likeBlock = ^{
        HUZSTRONG_SELF
        [strongSelf like];
    };
}

-(void)rankingAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.rank = sender.selected ? @"1" : @"0";
    [self loadCommentList];
}

- (void)inputClick{
    [self.commentInputView show];
}

#pragma mark - HUZCommentInputDelegate
- (void)commitComment:(NSString *)comment{
    if (DRStringIsEmpty(comment)) {
        return [self presentSheet:@"请输入评价"];
    }
    [self.commentInputView dismiss];
    [self.commentInputView reset];
    [self commitCommnet:comment];
}

#pragma mark - tableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [HUZPostInfoCell calculateHeightWithEntity:self.dataSource[indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    return [HUZPostInfoCell cellWithTableView:tableView];
}

- (void)configureCell:(HUZPostInfoCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    [cell reloadData:self.dataSource[indexPath.row]];
}

#pragma mark - NETWork
/// 评论列表
- (void)loadCommentList{
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    par[@"pageNow"] = @(self.page);
    par[@"pageSize"] = @(self.size);
    par[@"piccontentid"] = self.model.id;
    if (self.rank.length > 0) {
        par[@"dateTime"] = self.rank;
    }
//    @{@"pageNow":@(self.page),@"pageSize":@(self.size),@"piccontentid":self.model.id}
    HUZWEAK_SELF
    [HUZFriendService getFriendCommentList:par success:^(HUZFriendCommentModel * model) {
        HUZSTRONG_SELF
        if (strongSelf.page == 1) {
            [strongSelf.dataSource removeAllObjects];
        }
        [strongSelf.dataSource addObjectsFromArray:model.data.list];
//        if (DRArrayIsEmpty(self.dataSource)) {
//            [strongSelf configEmptyViewWithError:EMPTYDATA];
//        }

        [strongSelf.tableView reloadData];
        [strongSelf.tableView.mj_header endRefreshing];
        [strongSelf.tableView.mj_footer endRefreshing];
        if (strongSelf.page >= model.data.totalPage) {
            [strongSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf presentErrorSheet:errorStr];
//        if (DRArrayIsEmpty(self.dataSource)) {
//            [strongSelf configEmptyViewWithError:EMPTYDATA];
//        }
        [strongSelf.tableView reloadData];
        [strongSelf.tableView.mj_header endRefreshing];
        [strongSelf.tableView.mj_footer endRefreshing];
    }];
}

/// 点赞
- (void)like{
    HUZWEAK_SELF
    [self displayOverFlowActivityView];
    [HUZFriendService getPostLike:@{@"id":self.model.id} success:^(HUZModel * model) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        strongSelf.model.isClick = @"1";
        int likeNum = [strongSelf.model.likeNum intValue];
        strongSelf.model.likeNum = [NSString stringWithFormat:@"%d",likeNum+1];
        strongSelf.postInfoHeaderView.model = strongSelf.model;
        KPostNotification(LikeSuccess, @{@"model":strongSelf.model});
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        [strongSelf presentErrorSheet:errorStr];
    }];
}

/// 评论
- (void)commitCommnet:(NSString *)comment{
    HUZWEAK_SELF
    [self displayOverFlowActivityView];
    [HUZFriendService getCommitComment:@{@"contentId":self.model.id,@"content":comment} success:^(HUZModel * model) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        [strongSelf presentSuccessSheet:@"评价成功"];
        strongSelf.page = 1;
        
        NSInteger count = [strongSelf.model.commentNum integerValue];
        if (strongSelf.model.commentNum.length == 0) {
            strongSelf.model.commentNum = @"1";
        }else{
            count += 1;
            strongSelf.model.commentNum = [NSString stringWithFormat:@"%zd",count];
        }

        strongSelf.postInfoHeaderView.model = strongSelf.model;
        [strongSelf loadCommentList];
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        [strongSelf presentErrorSheet:errorStr];
    }];
}

#pragma mark - Lazy
- (HUZCommentInputView *)commentInputView{
    if (!_commentInputView) {
        _commentInputView = [[HUZCommentInputView alloc] init];
        _commentInputView.delegate = self;
        _commentInputView.title = [NSString stringWithFormat:@"评论给 %@",self.model.username];
    }
    return _commentInputView;
}
@end

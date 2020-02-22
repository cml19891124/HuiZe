//
//  HUZMyFocusMajorViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/5.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZMyFocusMajorViewController.h"
#import "HUZMyFocusMajorCell.h"
#import "HUZMineService.h"
#import "HUZFocusMajorModel.h"
#import "HUZMajorInfoViewController.h"
@interface HUZMyFocusMajorViewController ()<KSSideslipCellDelegate>
@property (nonatomic) NSIndexPath *indexPath;

@end

@implementation HUZMyFocusMajorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)configComponents{
    [super configComponents];
    
    self.cellHeight = AutoDistance(68);
    [self.tableView dz_registerCell:[HUZMyFocusMajorCell class]];
    self.tableView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    HUZWEAK_SELF
    self.tableView.mj_header = [HUZRefreshHeader headerWithRefreshingBlock:^{
        HUZSTRONG_SELF
        strongSelf.page = 1;
        [strongSelf configDatas];
    }];
    self.tableView.mj_footer = [HUZRefreshFooter footerWithRefreshingBlock:^{
        HUZSTRONG_SELF
        strongSelf.page ++;
        [strongSelf configDatas];
    }];
}

//kUrl_follow_listMajor
- (void)configDatas {
    [super configDatas];
    HUZWEAK_SELF
    NSMutableDictionary *postDict = [[NSMutableDictionary alloc]initWithDictionary:@{@"pageNow":@(self.page),@"pageSize":@(self.size)}];
    [HUZNetWorkTool huz_POST:kUrl_follow_listMajor parameters:postDict success:^(id  _Nonnull responseObject) {
        NSString *totalPageStr = responseObject[@"data"][@"totalPage"];
        HUZSTRONG_SELF
        if (strongSelf.page == 1) {
            [strongSelf.dataSource removeAllObjects];
        }
        
        if (DRArrayIsEmpty(self.dataSource)) {
            [strongSelf configEmptyViewWithError:EMPTYDATA];
        }
        
        HUZFocusMajorModel *majorModel = [HUZFocusMajorModel modelWithJSON:responseObject];
        [strongSelf.dataSource addObjectsFromArray:[majorModel.data.list mutableCopy]];
        [strongSelf.tableView reloadData];
        [strongSelf.tableView.mj_header endRefreshing];
        [strongSelf.tableView.mj_footer endRefreshing];
        
        if (strongSelf.page >= [totalPageStr integerValue]) {
            [strongSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        HUZSTRONG_SELF
        [strongSelf presentErrorSheet:error];
        [strongSelf.tableView reloadData];
        [strongSelf.tableView.mj_header endRefreshing];
        [strongSelf.tableView.mj_footer endRefreshing];
    }];
    
}

#pragma mark - tableView
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    HUZMyFocusMajorCell *cell = [HUZMyFocusMajorCell cellWithTableView:tableView style:UITableViewCellStyleDefault];
    HUZFocusMajorDataListModel *model = self.dataSource[indexPath.row];
    cell.delegate = self;
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HUZFocusMajorDataListModel *model = self.dataSource[indexPath.row];

    if (model.majorAllId.length != 0) {
        if (model.majorAllId.length == 0) {
            return;
        }
        HUZMajorInfoViewController *vc = [[HUZMajorInfoViewController alloc] init];
        vc.majorId = model.majorAllId;
        [self.navigationController pushViewController:vc animated:true];
    }else{
        [self presentErrorSheet:@"数据为空"];
    }

}

#pragma mark - KSSideslipCellDelegate
- (NSArray<KSSideslipCellAction *> *)sideslipCell:(KSSideslipCell *)sideslipCell editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KSSideslipCellAction *action = [KSSideslipCellAction rowActionWithStyle:KSSideslipCellActionStyleDestructive title:@"删除" handler:^(KSSideslipCellAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"点击删除");
    }];
    NSArray *array =  @[action];
    return array;
}

- (BOOL)sideslipCell:(KSSideslipCell *)sideslipCell canSideslipRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UIView *)sideslipCell:(KSSideslipCell *)sideslipCell rowAtIndexPath:(NSIndexPath *)indexPath didSelectedAtIndex:(NSInteger)index {
    self.indexPath = indexPath;
    UIButton * view =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 135, 0)];
    view.titleLabel.textAlignment = NSTextAlignmentCenter;
    view.titleLabel.font = [UIFont systemFontOfSize:17];
    [view setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [view setTitle:@"确认删除" forState:UIControlStateNormal];
    view.backgroundColor = [UIColor redColor];
    [view addTarget:self action:@selector(delBtnClick) forControlEvents:UIControlEventTouchUpInside];
    return view;
}

- (void)delBtnClick {
    HUZWEAK_SELF
    HUZFocusMajorDataListModel *model = self.dataSource[ self.indexPath.row];
    [self displayOverFlowActivityView];
    [HUZMineService getFollowDeleteWithFollowId:model.followId success:^(NSString * _Nonnull success) {
        [weakSelf removeOverFlowActivityView];
        [weakSelf.dataSource removeObjectAtIndex:self.indexPath.row];
        [weakSelf.tableView deleteRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        [weakSelf removeOverFlowActivityView];
        [weakSelf presentErrorSheet:errorStr];
    }];
}

@end

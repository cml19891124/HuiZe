//
//  HUZMessageListViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/5.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZMessageListViewController.h"
#import "HUZMessageListCell.h"

#import "HUZMineService.h"

#import "HUZMessageListModel.h"

@interface HUZMessageListViewController ()
@property (nonatomic, copy) NSString * mesState;
@property (nonatomic, assign) BOOL isShowed;
@end

@implementation HUZMessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"消息";
    [self showBarButton:NAV_RIGHT title:@"全部已读" fontColor:ColorS(COLOR_2E86FF)];
}

- (void)configDatas {
    HUZWEAK_SELF
    [self displayOverFlowActivityView];
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    par[@"pageNow"] = @(self.page);
    par[@"pageSize"] = @(self.size);
    
    if (self.mesState.length != 0) {
        par[@"mesState"] = self.mesState;
    }
    
    [HUZMineService getMessageListWithParameters:@{@"pageNow":@(self.page),@"pageSize":@(self.size)} success:^(HUZMessageListModel * _Nonnull messageModel) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];

        if (strongSelf.page == 1) {
            [strongSelf.dataSource removeAllObjects];
        }
        [strongSelf.dataSource addObjectsFromArray:messageModel.data.list];
        if (DRArrayIsEmpty(self.dataSource)) {
            [strongSelf configEmptyViewWithError:EMPTYDATA];
            strongSelf.view.backgroundColor = COLOR_BG_WHITE;
            strongSelf.tableView.backgroundColor = strongSelf.view.backgroundColor;
        }
        [strongSelf.tableView reloadData];
        [strongSelf.tableView.mj_header endRefreshing];
        [strongSelf.tableView.mj_footer endRefreshing];
        
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        [strongSelf presentErrorSheet:errorStr];
        [strongSelf.tableView reloadData];
        [strongSelf.tableView.mj_header endRefreshing];
        [strongSelf.tableView.mj_footer endRefreshing];
        
    }];
}

- (void)rightButtonTouch{
    self.isShowed = !self.isShowed;//yes未读
    if(self.isShowed) {
        self.mesState = @"1";
        [self showBarButton:NAV_RIGHT title:@"全部未读" fontColor:ColorS(COLOR_2E86FF)];
    }else{
        self.mesState = @"2";
        [self showBarButton:NAV_RIGHT title:@"全部已读" fontColor:ColorS(COLOR_2E86FF)];
    }
    [self configDatas];
}

- (void)configComponents{
    [super configComponents];
    
//    self.dataSource = @[@"1",@"1",@"1"].mutableCopy;
    self.tableView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    self.cellHeight = AutoDistance(76);
    [self.tableView dz_registerCell:[HUZMessageListCell class]];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(8))];
    self.tableView.tableHeaderView = headerView;
}

#pragma mark - tableView
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    
    HUZMessageModel *model = self.dataSource[indexPath.row];
    HUZMessageListCell *cell = [HUZMessageListCell cellWithTableView:tableView];
    cell.model = model;
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HUZMessageModel *model = self.dataSource[indexPath.row];
    
    NSArray *arr = @[@([model.Id integerValue])];
    
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    par[@"ids"] = arr;
    
    [HUZNetWorkTool huz_POST:kUrl_usermessage_update parameters:par success:^(id  _Nonnull responseObject) {
        
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        
    }];
    
    [UIViewController currentViewController].tabBarController.selectedIndex = 2;
}
@end


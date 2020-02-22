//
//  HUZSearchMajorResultViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/26.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZSearchMajorResultViewController.h"
#import "HUZSearchMajorCell.h"
#import "HUZMajorInfoViewController.h"
#import "HUZSearchMajorModel.h"
@interface HUZSearchMajorResultViewController ()

@property (nonatomic,strong) NSString *keyword;

@end

@implementation HUZSearchMajorResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ColorS(COLOR_BG_F6F6F6);

}

- (void)configComponents{
    [super configComponents];
    
    self.cellHeight = AutoDistance(58);
    
    [self.tableView dz_registerCell:[HUZSearchMajorCell class]];
    
    HUZWEAK_SELF
    self.tableView.mj_header = [HUZRefreshHeader headerWithRefreshingBlock:^{
        HUZSTRONG_SELF
        strongSelf.page = 1;
        [strongSelf loadMajorList];
    }];
    self.tableView.mj_footer = [HUZRefreshFooter footerWithRefreshingBlock:^{
        HUZSTRONG_SELF
        strongSelf.page ++;
        [strongSelf loadMajorList];
    }];
    if (self.keyword) {
        self.page = 1;
        [self loadMajorList];
    }
}

- (void)searchMajorWithkeyword:(NSString *)keyword{
    self.keyword = DRStringIsEmpty(keyword) ? @"" : keyword;
    self.page = 1;
    [self loadMajorList];
}

/// 搜索专业
- (void)loadMajorList{
    HUZWEAK_SELF
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    par[@"keyWord"] = self.keyword;
    par[@"pageNow"] = @(self.page);
    par[@"pageSize"] = @"20";
    [HUZHomeService getSearchMajorList:par success:^(HUZSearchMajorModel * _Nonnull model) {
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
    return [HUZSearchMajorCell cellWithTableView:tableView];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HUZSearchMajorDataListModel *model = nil;
    if (self.dataSource.count > indexPath.row) {
        model = self.dataSource[indexPath.row];
    }
    if (self.isGotoMajor) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HUZSearchMajorResultViewController_post_key" object:model];
        for (UIViewController * controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:NSClassFromString(@"HUZMajorPriorityController")]) {
                [self.navigationController popToViewController:controller animated:YES];
                return;
            }
        }
    }else{
        HUZMajorInfoViewController *VC = [[HUZMajorInfoViewController alloc] init];
        VC.majorId = model.majorAllId;
        [self.navigationController pushViewController:VC animated:true];
    }
}
- (void)configureCell:(HUZSearchMajorCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    [cell reloadData:object];
}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

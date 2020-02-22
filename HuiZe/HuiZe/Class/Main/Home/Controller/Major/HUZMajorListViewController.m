//
//  HUZMajorListViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/29.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZMajorListViewController.h"
#import "HUZSearchAllMajorCell.h"
#import "HUZUniInfoCommonCell.h"
#import "HUZMajorListModel.h"
#import "HUZUniInfoViewController.h"
#import "HUZMajorInfoViewController.h"
@interface HUZMajorListViewController ()

@property (nonatomic, strong) NSMutableDictionary * searchPar;

@end

@implementation HUZMajorListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.isSearch) {
        [self setupRefresh:self.tableView];
    }
    
}

- (void)configComponents{
    [super configComponents];
    
    [self.tableView dz_registerCell:[HUZSearchAllMajorCell class]];
    [self.tableView dz_registerCell:[HUZUniInfoCommonCell class]];
    
    if ([self.type isEqualToString:@"1"] || [self.type isEqualToString:@"2"]) {
        [self loadMajorList];
    }
}

-(void)onStartRefresh {
    self.page = 1;
    self.searchPar[@"pageNow"] = @(self.page);
    [self getSearchList:self.searchPar];
}

-(void)onStartLoadMore {
    self.page ++;
    self.searchPar[@"pageNow"] = @(self.page);
    [self getSearchList:self.searchPar];
}

/// 搜索专科，本科 1-专科 2-本科
- (void)clickSearchMajorWithKeyword:(NSString *)keyword type:(int)type{
    self.searchPar[@"keyWord"] = keyword;
    self.searchPar[@"type"] = type == 1 ? @"2" : @"1";
    self.searchPar[@"pageNow"] = @"1";
    self.searchPar[@"pageSize"] = @"10";
    [self.dataSource removeAllObjects];
    [self getSearchList:self.searchPar];
}

-(void)getSearchList:(NSMutableDictionary *)par {
    HUZWEAK_SELF
    [self displayOverFlowActivityView];
    [HUZHomeService getSearchMajorByKey:par success:^(HUZSearchAllMajorModel * _Nonnull model) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        if (strongSelf.page == 1) {
            [strongSelf.dataSource removeAllObjects];
        }
        [strongSelf.dataSource addObjectsFromArray:model.data.list];
        
        [strongSelf stopRefresh:strongSelf.tableView];
        [strongSelf.tableView reloadData];
        
        if (model.data.list.count == 0) {
            [strongSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf stopRefresh:strongSelf.tableView];
        [strongSelf removeOverFlowActivityView];
        [strongSelf presentErrorSheet:errorStr];
    }];
    
}

#pragma mark NETWork
/// 查询专业列表
- (void)loadMajorList{
    HUZWEAK_SELF
    [self displayOverFlowActivityView];
    [HUZHomeService getAllMajorCategory:self.type success:^(HUZAllMajorModel * _Nonnull model) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        [strongSelf processData:model.data];
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        [strongSelf presentErrorSheet:errorStr];
    }];
}

/// 处理数据
- (void)processData:(NSArray *)data{
    for (int i = 0; i < data.count; i ++) {
        HUZAllMajorDataFirstModel * firstModel = data[i];
        HUZMajorListModel *model = [[HUZMajorListModel alloc] initWithFirst_index:i + 1 second_index:0 third_index:0 is_show:YES is_open:NO content:firstModel.category majorId:firstModel.majorAllId];
        [self.dataSource addObject:model];
        for (int j = 0; j < firstModel.majorAllEntityList.count; j ++) {
            HUZAllMajorDataSecondModel *secondModel = firstModel.majorAllEntityList[j];
            HUZMajorListModel *model = [[HUZMajorListModel alloc] initWithFirst_index:i + 1 second_index:j+1 third_index:0 is_show:NO is_open:NO content:secondModel.category majorId:secondModel.majorAllId];
            [self.dataSource addObject:model];
            for (int k = 0; k < secondModel.majorAllEntityList.count; k++) {
                HUZAllMajorDataThirdModel *thirdModel = secondModel.majorAllEntityList[k];
                HUZMajorListModel *model = [[HUZMajorListModel alloc] initWithFirst_index:i+1 second_index:j+1 third_index:k+1 is_show:NO is_open:NO content:thirdModel.category majorId:thirdModel.majorAllId];
                [self.dataSource addObject:model];
            }
        }
    }
    [self.tableView reloadData];
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.type isEqualToString:@"1"] || [self.type isEqualToString:@"2"]) {
        HUZSearchAllMajorCell *cell = [HUZSearchAllMajorCell cellWithTableView:tableView];
        [cell reloadData:self.dataSource[indexPath.row]];
        return cell;
    }else{
        HUZUniInfoCommonCell *cell = [HUZUniInfoCommonCell cellWithTableView:tableView];
        [cell reloadData:self.dataSource[indexPath.row]];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.type isEqualToString:@"1"] || [self.type isEqualToString:@"2"]) {
        [self clickCellAtIndexPath:indexPath];
    }else{
        HUZSearchAllMajorDataListModel *model = nil;
        if (indexPath.row < self.dataSource.count) {
            model = self.dataSource[indexPath.row];
        }
        
        HUZMajorInfoViewController *VC = [[HUZMajorInfoViewController alloc] init];
        VC.majorId = model.majorAllId;
        [self.navigationController pushViewController:VC animated:true];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.type isEqualToString:@"1"] || [self.type isEqualToString:@"2"]) {
        HUZMajorListModel *model = self.dataSource[indexPath.row];
        return model.is_show ? AutoDistance(60) : 0;
    }
    return AutoDistance(60);

}

#pragma mark - data update
- (void)clickCellAtIndexPath:(NSIndexPath *)indexPath{
    HUZMajorListModel *current_model = self.dataSource[indexPath.row];
    //如果点击的是一级cell
    if (current_model.second_index == 0 && current_model.third_index == 0) {
        //如果该一级cell是展开的
        if (current_model.is_open) {
            for (HUZMajorListModel *model in self.dataSource) {
                BOOL is_belong = model.first_index == current_model.first_index;    //是否在当前分组
                BOOL is_current = model.second_index == 0;                           //是否是一级cell
                //如果在当前分组下，并且不是一级cell,则全部隐藏，关闭
                if (is_belong && !is_current) {
                    model.is_open = NO;
                    model.is_show = NO;
                }
                else
                {
                    //其他一级cell，不操作
                }
            }
            //关闭该一级cell
            current_model.is_open = NO;
            [self.tableView reloadData];
            return;
        }
        //如果该一级cell是关闭的
        else
        {
            for (HUZMajorListModel *model in self.dataSource) {
                BOOL is_belong = model.first_index == current_model.first_index;    //是否在当前分组
                BOOL is_current = model.second_index == 0;                           //是否是一级cell
                //如果在当前分组下，并且不是一级cell,则二级cell显示,三级cell不操作
                if (is_belong && !is_current) {
                    //如果是二级cell
                    if (model.third_index == 0) {
                        model.is_show = YES;
                    }
                    else
                    {
                        //三级cell，不操作
                    }
                }else{
                    //其他一级cell，不操作
                }
            }
            //打开该一级cell
            current_model.is_open = YES;
            [self.tableView reloadData];
            return;
        }
    }
    
    //如果点击的是二级cell
    if (current_model.third_index == 0) {
        //如果该二级cell是展开的
        if (current_model.is_open) {
            for (HUZMajorListModel *model in self.dataSource) {
                BOOL is_belong = model.second_index == current_model.second_index && model.first_index == current_model.first_index;  //是否在当前分组
                BOOL is_current = model.third_index == 0;                           //是否是二级cell
                //如果在当前分组下，并且不是二级cell，则全部隐藏
                if (is_belong && !is_current) {
                    model.is_show = NO;
                }
                else
                {
                    //其他二级cell，不操作
                }
            }
            //关闭该二级cell
            current_model.is_open = NO;
            [self.tableView reloadData];
            return;
        }
        //如果该二级cell是关闭的
        else
        {
            for (HUZMajorListModel *model in self.dataSource) {
                BOOL is_belong = model.second_index == current_model.second_index && model.first_index == current_model.first_index;  //是否在当前分组
                BOOL is_current = model.third_index == 0;                           //是否是二级cell
                //如果在当前分组下，并且不是二级cell，则全部显示
                if (is_belong && !is_current) {
                    model.is_show = YES;
                }
                else
                {
                    //其他二级cell，不操作
                }
            }
            //打开该二级cell
            current_model.is_open = YES;
            [self.tableView reloadData];
            return;
        }
    }
    
    //如果点击的是三级cell
    NSLog(@"点击了三级cell");
    HUZMajorListModel *model = self.dataSource[indexPath.row];
    NSLog(@"点击:%@",model.content);
    HUZMajorInfoViewController *VC = [[HUZMajorInfoViewController alloc] init];
    VC.majorId = model.majorId;
    [self.navigationController pushViewController:VC animated:true];
}

-(NSMutableDictionary *)searchPar {
    if (!_searchPar) {
        _searchPar = [NSMutableDictionary dictionary];
    }
    return _searchPar;
}

@end

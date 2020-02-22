//
//  HUZMajorCategoryViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/29.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZMajorCategoryViewController.h"
#import "HUZSearchAllMajorCell.h"
#import "HUZMajorListModel.h"
#import "HUZPkListHeaderView.h"
#import "HUZUniInfoCommonCell.h"
#import "HUZMajorCategoryViewControllerHeader.h"
@interface HUZMajorCategoryViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) HUZPkListHeaderView *headerView;
@property (nonatomic, strong) NSMutableDictionary * searchPar;

@property (nonatomic, assign) BOOL isSearch;
@property (nonatomic, strong) NSMutableArray * searchDataArr;
@end

@implementation HUZMajorCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"所有专业";
    [self.view addSubview:self.headerView];
//    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.headerView.mas_bottom).mas_equalTo(100);
//        make.right.left.bottom.equalTo(self.view);
//    }];
}

- (void)configComponents{
    [super configComponents];
//    self.tableView.tableHeaderView = self.headerView;
    [self.tableView dz_registerCell:[HUZSearchAllMajorCell class]];
    [self.tableView dz_registerCell:[HUZUniInfoCommonCell class]];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(AutoDistance(52));
        make.left.bottom.right.equalTo(self.view);
    }];
    [self.tableView dz_registerCell:[HUZSearchAllMajorCell class]];
    [self.tableView registerNib:[UINib nibWithNibName:@"HUZMajorCategoryViewControllerHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"HUZMajorCategoryViewControllerHeader"];

    
    [self loadMajorList];
}

#pragma mark NETWork
/// 查询专业列表
- (void)loadMajorList{
    HUZWEAK_SELF
    [self displayOverFlowActivityView];
    [HUZHomeService getAllMajorCategory:self.category success:^(HUZAllMajorModel * _Nonnull model) {
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

/// 搜索专科，本科 1-专科 2-本科
- (void)clickSearchMajorWithKeyword:(NSString *)keyword{
    self.searchPar[@"keyWord"] = keyword;
    self.searchPar[@"type"] = [self.category isEqualToString:@"1"] ? @"2" : @"1";
    self.searchPar[@"pageNow"] = @"1";
    self.searchPar[@"pageSize"] = @"10";
    [self.searchDataArr removeAllObjects];
    [self getSearchList:self.searchPar];
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

-(void)getSearchList:(NSMutableDictionary *)par {
    HUZWEAK_SELF
    [self displayOverFlowActivityView];
    [HUZHomeService getSearchMajorByKey:par success:^(HUZSearchAllMajorModel * _Nonnull model) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        [strongSelf stopRefresh:strongSelf.tableView];
        
        if (strongSelf.page == 1) {
            [strongSelf.searchDataArr removeAllObjects];
        }
        [strongSelf.searchDataArr addObjectsFromArray:model.data.list];
        
        
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

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    
    if (DRStringIsEmpty(textField.text)) {
        return YES;
    }
    self.isSearch = YES;
    [self clickSearchMajorWithKeyword:textField.text];
    return YES;
}

- (void)tfKeywordChange:(UITextField *)tf{
    if (DRStringIsEmpty(tf.text)) {
        self.isSearch = NO;
        [self.searchDataArr removeAllObjects];
        [self removeRefresh];
        [self.tableView reloadData];
    }else{
        self.isSearch = YES;
        [self setupRefresh:self.tableView];
        [self clickSearchMajorWithKeyword:tf.text];
    }
}

-(void)removeRefresh {
    self.tableView.mj_header = nil;
    self.tableView.mj_footer = nil;
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.isSearch) {
        return self.searchDataArr.count;
    }
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isSearch) {
        HUZUniInfoCommonCell *searchCell = [tableView dequeueReusableCellWithIdentifier:@"HUZUniInfoCommonCell"];
        
        HUZSearchAllMajorDataListModel *listModel = nil;
        if (self.searchDataArr.count > indexPath.row) {
            listModel = self.searchDataArr[indexPath.row];
        }
        
        [searchCell reloadData:listModel];
        
        return searchCell;
    }else{
        HUZSearchAllMajorCell *cell = [HUZSearchAllMajorCell cellWithTableView:tableView];
        HUZMajorListModel *listModel = nil;
        if (self.dataSource.count > indexPath.row) {
            listModel = self.dataSource[indexPath.row];
        }
        [cell reloadData:listModel];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isSearch) {
        HUZSearchAllMajorDataListModel *listModel = nil;
        if (self.searchDataArr.count > indexPath.row) {
            listModel = self.searchDataArr[indexPath.row];
        }
        //如果点击的是三级cell
        NSLog(@"点击了三级cell");
        HUZMajorListModel *model = [[HUZMajorListModel alloc] init];
        model.content = listModel.category;
        model.majorId = listModel.majorAllId;
        if (_selectBlock) {
            _selectBlock(model);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self clickCellAtIndexPath:indexPath];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isSearch) {
        return AutoDistance(60);
    }else{
        HUZMajorListModel *model = self.dataSource[indexPath.row];
        return model.is_show ? AutoDistance(60) : 0;
    }
}

-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.isSearch) {
        return 0.001;
    }else{
        return 44;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.isSearch) {
        return nil;
    }else{
        HUZMajorCategoryViewControllerHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HUZMajorCategoryViewControllerHeader"];
        header.backgroundColor = UIColor.whiteColor;
        header.contentView.backgroundColor = UIColor.whiteColor;
        if ([self.category isEqualToString:@"1"]) {
            header.titleLb.text = @"专科";
        }else{
            header.titleLb.text = @"本科";
        }
        return header;
    }

}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
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
                }
                else
                {
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
    if (_selectBlock) {
        _selectBlock(model);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UI
- (HUZPkListHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[HUZPkListHeaderView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(52))];
        _headerView.tfKeyword.delegate = self;
        if ([self.category isEqualToString:@"1"]) {
            self.headerView.tfKeyword.placeholder = @"搜索专业(专科)";
        }else{
            self.headerView.tfKeyword.placeholder = @"搜索专业(本科)";
        }
        [_headerView.tfKeyword addTarget:self action:@selector(tfKeywordChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _headerView;
}
-(NSMutableDictionary *)searchPar {
    if (!_searchPar) {
        _searchPar = [NSMutableDictionary dictionary];
    }
    return _searchPar;
}

-(NSMutableArray *)searchDataArr {
    if (!_searchDataArr) {
        _searchDataArr = [NSMutableArray array];
    }
    return _searchDataArr;
}

@end

//
//  HUZUniRankingListViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/24.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniRankingListViewController.h"
#import "HUZUniRankingListSectionView.h"
#import "HUZUniRankingListCell.h"
#import "HUZProvinceModel.h"
#import "HUZLoginService.h"
#import "HUZPPPSelectView.h"
#import "HUZUniRankingListSectionView.h"
#import "HUZUniRankingListModel.h"
@interface HUZUniRankingListViewController ()<HUZPPPSelectViewDelegate>
@property (nonatomic,strong) HUZProvinceModel *provinceModel;
@property (nonatomic,strong) HUZPPPSelectView *selectProvinceView;
@property (nonatomic,strong) HUZPPPSelectView *selectSchoolTypeView;

@property (nonatomic, strong) HUZUniRankingListSectionView *uniRankingListSectionView;

@property (nonatomic, copy) NSString * provinceId;
@property (nonatomic, copy) NSString * schoolTypeId;
@end

@implementation HUZUniRankingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.navTitle;
    self.schoolTypeId = @"-1";
    //self.provinceId = @"-1";
}

- (void)configComponents{
    [super configComponents];
    
//    self.dataSource = [@[@"1",@"1",@"1"] mutableCopy];
    self.cellHeight = AutoDistance(83);
    [self.tableView dz_registerCell:[HUZUniRankingListCell class]];
    [self setupRefresh:self.tableView];
    [self.tableView.mj_header beginRefreshing];
}

-(void)onStartRefresh {
    self.page = 1;
    [self getUniversityData];
}

-(void)onStartLoadMore {
    self.page++;
    [self getUniversityData];
}
#pragma mark -- net
-(void)getUniversityData {
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    par[@"pageNow"] = @(self.page);
    par[@"pageSize"] = @(self.size);
    if (self.provinceId) {
        par[@"province"] = self.provinceId;
    }
    par[@"schoolType"] = self.schoolTypeId;
    par[@"type"] = @(self.type);
    [self displayOverFlowActivityView];
    [HUZNetWorkTool huz_POST:kUrl_ranking_list parameters:par success:^(id  _Nonnull responseObject) {
        [self stopRefresh:self.tableView];
        NSString *code = [responseObject valueForKey:@"code"];
        if ([code integerValue] == 0) {
            [self removeOverFlowActivityView];
            if (self.page==1) {
                [self.dataSource removeAllObjects];
            }
            NSArray *arr = [NSArray modelArrayWithClass:[HUZUniRankingListModel class] json:responseObject[@"data"][@"list"]];
            [self.dataSource addObjectsFromArray:arr];
            [self.tableView reloadData];
            if (arr.count == 0 && self.page != 1) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            NSString *msg = responseObject[@"msg"];
            [self presentErrorSheet:msg];
        }

    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        [self stopRefresh:self.tableView];
        [self removeOverFlowActivityView];
        [self presentErrorSheet:error];
    }];
}

-(void)getProvinceData {
    [self displayOverFlowActivityView];
    [HUZLoginService getProvinceSuccess:^(HUZProvinceModel * _Nonnull object) {
        [self removeOverFlowActivityView];
        self.provinceModel = [HUZProvinceModel new];
        self.provinceModel = object;
        [self.selectProvinceView show];
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        [self removeOverFlowActivityView];
        [self presentErrorSheet:errorStr];
    }];
}

#pragma mark -- net end

#pragma mark -- <UITableViewDelegate,UITableViewDataSource>
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    HUZUniRankingListModel *listModel = nil;
    if (indexPath.row < self.dataSource.count) {
        listModel = self.dataSource[indexPath.row];
    }
    HUZUniRankingListCell *cell = [HUZUniRankingListCell cellWithTableView:tableView];
    [self configureCell:cell atIndexPath:indexPath withObject:listModel];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    HUZUniRankingListCell *uniRankingListCell = (HUZUniRankingListCell *)cell;
    uniRankingListCell.type = self.type;
    [uniRankingListCell reloadData:object indexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AutoDistance(46);
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.uniRankingListSectionView;
}
#pragma mark -- <UITableViewDelegate,UITableViewDataSource> end
#pragma mark -- action
-(void)selectArea:(UIButton *)snder {
    if (self.provinceModel) {
        [self.selectProvinceView show];
    }else{
        [self getProvinceData];
    }
}

-(void)selectType:(UIButton *)snder {
    [self.selectSchoolTypeView show];
}
#pragma mark -- action end

#pragma mark -- lazy
- (HUZPPPSelectView *)selectProvinceView {
    if (!_selectProvinceView) {
        _selectProvinceView = [HUZPPPSelectView new];
        _selectProvinceView.headTitle = @"选择省份";
        NSMutableArray *marr = [NSMutableArray array];
        for (HUZProvince *province in self.provinceModel.data) {
            [marr addObject:province.title];
        }
        _selectProvinceView.dataArray = marr;
        _selectProvinceView.delegate = self;
        _selectProvinceView.tag = 1;
        [self.view addSubview:_selectProvinceView];
    }
    return _selectProvinceView;
}

-(HUZPPPSelectView *)selectSchoolTypeView {
    if (!_selectSchoolTypeView) {
        _selectSchoolTypeView = [HUZPPPSelectView new];
        _selectSchoolTypeView.headTitle = @"选择学校类别";
        _selectSchoolTypeView.delegate = self;
        _selectSchoolTypeView.dataArray = HUZDataBaseManager.dataSchoolType.mutableCopy;
        _selectSchoolTypeView.tag = 11000;
        [self.view addSubview:_selectSchoolTypeView];
    }
    return _selectSchoolTypeView;
}

-(HUZUniRankingListSectionView *)uniRankingListSectionView {
    if (!_uniRankingListSectionView) {
        _uniRankingListSectionView = [[HUZUniRankingListSectionView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(46))];
        [_uniRankingListSectionView.btnArea addTarget:self action:@selector(selectArea:) forControlEvents:(UIControlEventTouchUpInside)];
        [_uniRankingListSectionView.btnType addTarget:self action:@selector(selectType:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _uniRankingListSectionView;
}
#pragma mark -- lazy


#pragma mark -- HUZPPPSelectViewDelegate
- (void)pppSelectViewDelegateWith:(HUZPPPSelectView *)selectView indexPath:(NSIndexPath*)indexPAth result:(NSString *)result {
    if ([selectView.headTitle isEqualToString:@"选择省份"]) {
        [self.uniRankingListSectionView.btnArea setTitle:result forState:(UIControlStateNormal)];
        HUZProvince *province = self.provinceModel.data[indexPAth.row];
        self.provinceId = province.Id;
    }else{
        /// 查大学---学校类型  学校类型：不限为-1 0综合，1工科，2师范，3农业，4医药，5军事，6林业，7语言，8财经，9体育，10艺术，11政法，12民族
//        instance.dataSchoolType = @[@"全部",@"综合",@"工科",@"师范",@"农业",@"医药",@"军事",@"林业",@"语言",@"财经",@"体育",@"艺术",@"政法",@"民族"];
        [self.uniRankingListSectionView.btnType setTitle:result forState:(UIControlStateNormal)];
        self.schoolTypeId = [NSString stringWithFormat:@"%zd",indexPAth.row-1];
    }
    [self onStartRefresh];
}
#pragma mark -- HUZPPPSelectViewDelegate end
@end

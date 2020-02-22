//
//  HUZHistoryStudentsPlanTableView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/23.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZHistoryStudentsPlanTableView.h"
#import "HUZHistoryStudentsPlanCell.h"
#import "HUZUniInfoViewController.h"
@interface HUZHistoryStudentsPlanTableView ()<HUZPPPSelectViewDelegate>{
    
    NSString *_year; /// 年份
    int _batch; /// 0本科批， 1本科一批，2本科二批，3本科三批，4专科批，5平行录取一段，6平行录取二段，7平行录取三段，8本科提前批 ，9国家专项计划本科批
    int _type;  /// 1录取人数,2录取最低排名,3录取最低分数
    int _grade; /// 0文科，1理科，2综合，3体育，4艺术文，5艺术理
    
    NSString *_batchStr;
    NSString *_typeStr;
    NSString *_gradeStr;
}
@property (nonatomic,strong) HUZHistoryStudentsPlanSectionView *historyStudentsPlanSectionView;
@property (nonatomic,strong) HUZPPPSelectView *selectYearView;
@property (nonatomic,strong) HUZPPPSelectView *selectBatchView;
@property (nonatomic,strong) HUZPPPSelectView *selectTypeView;
@property (nonatomic,strong) HUZPPPSelectView *selectSubjectView;
@property (nonatomic,strong) NSMutableArray *dataHistory;

@property (nonatomic, strong) NSMutableArray * selectYearViewArr;
@end

@implementation HUZHistoryStudentsPlanTableView



- (instancetype)init{
    self = [super init];
    if (self) {
        
        _year = @"2018";//HUZDataBaseManager.dataYear[0];
        _batchStr = @"本科一批";//HUZDataBaseManager.dataBatch[0];
        _typeStr = HUZDataBaseManager.dataType[0];
        _gradeStr = HUZDataBaseManager.dataSubject[0];
        
        _batch = 1;
        _type = 1;
        _grade = 0;
        
        self.dataHistory = [NSMutableArray new];
        
        self.rowHeight = AutoDistance(110);
        [self dz_registerCell:[HUZHistoryStudentsPlanCell class]];

    }
    return self;
}

-(void)setVipState:(NSInteger)vipState {
    _vipState = vipState;
    if (vipState !=0) {
        HUZWEAK_SELF
        self.mj_footer = [HUZRefreshFooter footerWithRefreshingBlock:^{
            HUZSTRONG_SELF
            strongSelf.page ++;
            [strongSelf loadHistoryPlanList];
        }];
        self.tableHeaderView = nil;
        [self loadHistoryPlanList];
    }else{
        self.tableHeaderView = self.droplineToBuyVipView;
    }
}

#pragma mark NETWork
- (void)loadHistoryPlanList{
    NSDictionary *params = @{@"year":_year,
                             @"batch":@(_batch),
                             @"type":@(_type),
                             @"grade":@(_grade),
                             @"pageNow":@(self.page),
                             @"pageSize":@(self.size)};
    HUZWEAK_SELF
    [self displayOverFlowActivityView];
    [HUZHomeService getStudentPlanData:params success:^(HUZStudentPlanModel * model) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        if (strongSelf.page == 1) {
            [strongSelf.dataHistory removeAllObjects];
        }
        [strongSelf.dataHistory addObjectsFromArray:model.data.list];
        [strongSelf configEmptyViewWithError:EMPTYDATA];
        strongSelf.datas = strongSelf.dataHistory;
        [strongSelf.mj_footer endRefreshing];
        if (strongSelf.page >= model.data.totalPage) {
            [strongSelf.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        [strongSelf configEmptyViewWithError:errorStr];
        [strongSelf.mj_footer endRefreshing];
        [strongSelf reloadData];
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.vipState == 0) {
        return 0;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HUZHistoryStudentsPlanCell *cell = [HUZHistoryStudentsPlanCell cellWithTableView:tableView];
    cell.ivDiviceline.hidden = indexPath.row == self.datas.count - 1 ? YES : NO;
    [cell reloadData:self.dataHistory[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AutoDistance(40);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HUZStudentPlanDataListModel *listModel = nil;
    if (indexPath.row < self.datas.count) {
        listModel = self.datas[indexPath.row];
    }
    HUZUniInfoViewController *uniInfoVC = [HUZUniInfoViewController new];
    uniInfoVC.schoolId = listModel.schoolId;
    [self.YQViewController.navigationController pushViewController:uniInfoVC animated:true];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HUZHistoryStudentsPlanSectionView *historyStudentsPlanSectionView = [[HUZHistoryStudentsPlanSectionView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(40))];
    self.historyStudentsPlanSectionView = historyStudentsPlanSectionView;
    [self.historyStudentsPlanSectionView.btnYear addTarget:self action:@selector(clickYear) forControlEvents:UIControlEventTouchUpInside];
    [self.historyStudentsPlanSectionView.btnBatch addTarget:self action:@selector(clickBatch) forControlEvents:UIControlEventTouchUpInside];
    [self.historyStudentsPlanSectionView.btnType addTarget:self action:@selector(clickType) forControlEvents:UIControlEventTouchUpInside];
    [self.historyStudentsPlanSectionView.btnSubjectType addTarget:self action:@selector(clickSubjectType) forControlEvents:UIControlEventTouchUpInside];
    self.historyStudentsPlanSectionView.year = _year;
    self.historyStudentsPlanSectionView.batch = _batchStr;
    self.historyStudentsPlanSectionView.type = _typeStr;
    self.historyStudentsPlanSectionView.subject = _gradeStr;
    return self.historyStudentsPlanSectionView;
}

- (void)clickYear{
    if (self.selectYearViewArr.count > 0) {
        self.selectYearView.dataArray = self.selectYearViewArr.copy;
        [self.selectYearView show];
    }else{
        [HUZDataBase getYearType:5 yearBlock:^(NSArray * _Nonnull yearArr) {
            self.selectYearViewArr = yearArr.copy;
            self.selectYearView.dataArray = yearArr.copy;
            [self.selectYearView show];
        }];
    }
}

- (void)clickBatch{
    [self.selectBatchView show];
}

- (void)clickType{
    [self.selectTypeView show];
}

- (void)clickSubjectType{
    [self.selectSubjectView show];
}

- (void)pppSelectViewDelegateWith:(HUZPPPSelectView *)selectView indexPath:(NSIndexPath*)indexPAth result:(NSString *)result{
    /// 选择年份
    if (selectView.tag == 1) {
        _year = result;
        
    }
    /// 选择批次
    else if (selectView.tag == 2){
        _batchStr = result;
        _batch = (int)indexPAth.row+1;
    }
    /// 选择类别
    else if (selectView.tag == 3){
        _typeStr = result;
        _type = (int)indexPAth.row + 1;
    }
    /// 选择文理
    else if (selectView.tag == 4){
        _gradeStr = result;
        _grade = (int)indexPAth.row;
    }
    [self loadHistoryPlanList];
    [self reloadData];
}

#pragma mark Lazy
- (HUZPPPSelectView *)selectYearView{
    if (!_selectYearView) {
        _selectYearView = [HUZPPPSelectView new];
        _selectYearView.dataArray = HUZDataBaseManager.dataYear.mutableCopy;
        _selectYearView.headTitle = @"请选择年份";
        _selectYearView.delegate = self;
        _selectYearView.tag = 1;
    }
    return _selectYearView;
}

- (HUZPPPSelectView *)selectBatchView{
    if (!_selectBatchView) {
        _selectBatchView = [HUZPPPSelectView new];
        _selectBatchView.dataArray = @[@"本科一批",@"本科二批",@"专科批"].copy;//HUZDataBaseManager.dataBatch.mutableCopy;
        _selectBatchView.headTitle = @"请选择批次";
        _selectBatchView.delegate = self;
        _selectBatchView.tag = 2;
    }
    return _selectBatchView;
}

- (HUZPPPSelectView *)selectTypeView{
    if (!_selectTypeView) {
        _selectTypeView = [HUZPPPSelectView new];
        _selectTypeView.dataArray = HUZDataBaseManager.dataType.mutableCopy;
        _selectTypeView.headTitle = @"请选择类别";
        _selectTypeView.delegate = self;
        _selectTypeView.tag = 3;
    }
    return _selectTypeView;
}

- (HUZPPPSelectView *)selectSubjectView{
    if (!_selectSubjectView) {
        _selectSubjectView = [HUZPPPSelectView new];
        _selectSubjectView.dataArray = HUZDataBaseManager.dataSubject.mutableCopy;
        _selectSubjectView.headTitle = @"请选择类别";
        _selectSubjectView.delegate = self;
        _selectSubjectView.tag = 4;
    }
    return _selectSubjectView;
}


-(HUZGoToBuyVipView *)droplineToBuyVipView {
    if (!_droplineToBuyVipView) {
        _droplineToBuyVipView = [HUZGoToBuyVipView viewFromXib];
        _droplineToBuyVipView.titleLb.text = @"开通会员、立即查看详情";
        _droplineToBuyVipView.frame = CGRectMake(0, 0, HUZSCREEN_WIDTH, 188);
        _droplineToBuyVipView.height = 188.0;
    }
    return _droplineToBuyVipView;
}
-(NSMutableArray *)selectYearViewArr {
    if (!_selectYearViewArr) {
        _selectYearViewArr = [NSMutableArray array];
    }
    return _selectYearViewArr;
}
@end

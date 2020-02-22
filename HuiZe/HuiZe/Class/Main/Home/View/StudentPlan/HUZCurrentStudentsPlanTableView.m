//
//  HUZCurrentStudentsPlanTableView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/23.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZCurrentStudentsPlanTableView.h"
#import "HUZCurrentStudentsPlanCell.h"
#import "HUZStudentPlanModel.h"
#import "HUZUniInfoViewController.h"
@interface HUZCurrentStudentsPlanTableView ()<HUZPPPSelectViewDelegate>
{
    int _batch; /// 0本科批， 1本科一批，2本科二批，3本科三批，4专科批，5平行录取一段，6平行录取二段，7平行录取三段，8本科提前批 ，9国家专项计划本科批
    int _type;  /// 1录取人数,2录取最低排名,3录取最低分数
    int _grade; /// 0文科，1理科，2综合，3体育，4艺术文，5艺术理

    NSString *_batchStr;
    NSString *_typeStr;
    NSString *_gradeStr;

}
@property (nonatomic,strong) HUZCurrentStudentsPlanSectionView *currentStudentsPlanSectionView;
@property (nonatomic,strong) HUZPPPSelectView *selectBatchView;
@property (nonatomic,strong) HUZPPPSelectView *selectTypeView;
@property (nonatomic,strong) HUZPPPSelectView *selectSubjectView;
@property (nonatomic,strong) NSMutableArray *dataPlan;

@end

@implementation HUZCurrentStudentsPlanTableView

- (instancetype)init{
    self = [super init];
    if (self) {
        
        _batch = 1;
        _type = 1;
        _grade = 0;
        
        _batchStr = @"本科一批";//HUZDataBaseManager.dataBatch[0];
        _typeStr = HUZDataBaseManager.dataType[0];
        _gradeStr = HUZDataBaseManager.dataSubject[0];
        
        self.dataPlan = [NSMutableArray new];
        
        self.rowHeight = AutoDistance(81);
        [self dz_registerCell:[HUZCurrentStudentsPlanCell class]];
    }
    return self;
}
-(void)setVipState:(NSInteger)vipState {
    _vipState = vipState;
    if (vipState != 0) {
        HUZWEAK_SELF
        self.mj_footer = [HUZRefreshFooter footerWithRefreshingBlock:^{
            HUZSTRONG_SELF
            strongSelf.page ++;
            [strongSelf loadCurrentPlanList];
        }];
        self.tableHeaderView = nil;
        [self loadCurrentPlanList];
    }else{
        self.tableHeaderView = self.droplineToBuyVipView;
    }
}
#pragma mark NETWork
- (void)loadCurrentPlanList{
    NSDictionary *params = @{@"year":@"2019",
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
            [strongSelf.dataPlan removeAllObjects];
        }
        [strongSelf.dataPlan addObjectsFromArray:model.data.list];
        [strongSelf configEmptyViewWithError:EMPTYDATA];
        strongSelf.datas = strongSelf.dataPlan;
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
    HUZCurrentStudentsPlanCell *cell = [HUZCurrentStudentsPlanCell cellWithTableView:tableView];
    cell.ivDiviceline.hidden = indexPath.row == self.datas.count - 1 ? YES : NO;
    [cell reloadData:self.datas[indexPath.row]];
    return cell;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AutoDistance(40);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HUZCurrentStudentsPlanSectionView *currentStudentsPlanSectionView = [[HUZCurrentStudentsPlanSectionView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(40))];
    currentStudentsPlanSectionView.backgroundColor = COLOR_BG_WHITE;
    self.currentStudentsPlanSectionView = currentStudentsPlanSectionView;
    [self.currentStudentsPlanSectionView.btnBatch addTarget:self action:@selector(clickBatch) forControlEvents:UIControlEventTouchUpInside];
    [self.currentStudentsPlanSectionView.btnType addTarget:self action:@selector(clickType) forControlEvents:UIControlEventTouchUpInside];
    [self.currentStudentsPlanSectionView.btnSubjectType addTarget:self action:@selector(clickSubjectType) forControlEvents:UIControlEventTouchUpInside];
    self.currentStudentsPlanSectionView.batch = _batchStr;
    self.currentStudentsPlanSectionView.type = _typeStr;
    self.currentStudentsPlanSectionView.subject = _gradeStr;
    return self.currentStudentsPlanSectionView;
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

#pragma mark HUZPPPSelectViewDelegate
- (void)pppSelectViewDelegateWith:(HUZPPPSelectView *)selectView indexPath:(NSIndexPath*)indexPAth result:(NSString *)result{
    /// 选择批次
    if (selectView.tag == 1) {
        _batchStr = result;
        _batch = (int)indexPAth.row + 1;
    }
    /// 选择类别
    else if (selectView.tag == 2){
        _typeStr = result;
        _type = (int)indexPAth.row + 1;
    }
    /// 选择文理分科
    else if (selectView.tag == 3){
        _gradeStr = result;
        _grade = (int)indexPAth.row;
    }
    self.page = 1;
    [self loadCurrentPlanList];
    [self reloadData];
}

#pragma mark Lazy
- (HUZPPPSelectView *)selectBatchView{
    if (!_selectBatchView) {
        _selectBatchView = [HUZPPPSelectView new];
        _selectBatchView.dataArray = @[@"本科一批",@"本科二批",@"专科批"].copy;//HUZDataBaseManager.dataBatch.mutableCopy;
        _selectBatchView.headTitle = @"请选择批次";
        _selectBatchView.delegate = self;
        _selectBatchView.tag = 1;
    }
    return _selectBatchView;
}

- (HUZPPPSelectView *)selectTypeView{
    if (!_selectTypeView) {
        _selectTypeView = [HUZPPPSelectView new];
        _selectTypeView.dataArray = HUZDataBaseManager.dataType.mutableCopy;
        _selectTypeView.headTitle = @"请选择类别";
        _selectTypeView.delegate = self;
        _selectTypeView.tag = 2;
    }
    return _selectTypeView;
}

- (HUZPPPSelectView *)selectSubjectView{
    if (!_selectSubjectView) {
        _selectSubjectView = [HUZPPPSelectView new];
        _selectSubjectView.dataArray = HUZDataBaseManager.dataSubject.mutableCopy;
        _selectSubjectView.headTitle = @"请选择类别";
        _selectSubjectView.delegate = self;
        _selectSubjectView.tag = 3;
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
@end



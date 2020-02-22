//
//  HUZVolunteerPacketController.m
//  HuiZe
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZVolunteerPacketController.h"
#import "HUZVolPacketHeaderView.h"
#import "HUZVolPacketCell.h"
#import "HUZVolunteerBottomView.h"

#import "HUZVolunteerService.h"
#import "HUZVolunteerPacketHeaerView.h"
#import "HUZFillVolunteerController.h"
#import "HUZSchoolListDataModel.h"
#import "HUZPPPSelectView.h"
#import "HUZTargetBatchModel.h"
@interface HUZVolunteerPacketController ()<HUZVolPacketHeaderViewDeletage,HUZVolPacketCellDelegate,HUZPPPSelectViewDelegate>
@property (nonatomic,strong) HUZVolunteerBottomView *viewBotm;
@property (nonatomic,strong) HUZPacketVolModel *packetVolModel; //model

@property (strong, nonatomic) HUZPacketVolListModel *selectedModel;

@property (nonatomic, strong) NSMutableArray * selectSchoolArr;

@property (nonatomic, strong) NSMutableDictionary * selectSubjectDict;

@property (nonatomic, strong) HUZVolunteerPacketHeaerView * headerView;

@property (nonatomic, copy) NSString * batchName;

@property (nonatomic,strong)HUZPPPSelectView *pppView;
@property (nonatomic, strong) HUZTargetBatchDataModel * batchDataModel;
@end

@implementation HUZVolunteerPacketController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的备选志愿";
    self.packetVolModel = [HUZPacketVolModel new];
}

- (void)configComponents{
    [super configComponents];
    CGFloat top = 8.0;
    if (!self.batch) {
        [self.view addSubview:self.headerView];
        [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.equalTo(self.view);
            make.height.mas_equalTo(44);
        }];
        top = 52;
    }
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(top);
        make.left.right.equalTo(self.view);
        make.bottom.mas_offset(-AutoDistance(49));
    }];

    self.shouldMultiSections = YES;
    
    self.tableView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    self.view.backgroundColor = self.tableView.backgroundColor;
    
    self.tableView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    self.cellHeight = AutoDistance(89);
    [self.tableView dz_registerCell:[HUZVolPacketCell class]];
    [self.tableView dz_registerHeaderFooterViewView:[HUZVolPacketHeaderView class]];
    self.viewBotm = [[HUZVolunteerBottomView alloc]initWithFrame:CGRectMake(0, HUZSCREEN_HEIGHT - HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT - AutoDistance(49), HUZSCREEN_WIDTH, AutoDistance(49))];
    self.viewBotm.viewBotm.backgroundColor = ColorS(COLOR_989898);
    [self.viewBotm.btnSelected setTitleColor:COLOR_BG_WHITE forState:UIControlStateNormal];
    [self.viewBotm.btnSelected setTitle:@"选择" forState:UIControlStateNormal];
    self.viewBotm.btnSelected.enabled = NO;
    [self.viewBotm.btnSelected addTarget:self action:@selector(selectClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.viewBotm];
    
}

- (void)configStyle{
    self.style = UITableViewStyleGrouped;
}

- (void)configDatas {
    [super configDatas];
    if (!self.batch) {
        [self getVoluntaryTargetBatchData];
    }else{
        [self getVolunteerVoluntaryList];
    }
}

-(void)getVolunteerVoluntaryList {
        NSMutableDictionary *par = [NSMutableDictionary dictionary];
        par[@"batch"] = self.batch;
        
        HUZWEAK_SELF;
        [self displayOverFlowActivityView];
        [HUZVolunteerService getVolunteerVoluntaryWithParamters:par success:^(HUZPacketVolModel * _Nonnull packVolModel) {
            [weakSelf removeOverFlowActivityView];
            
            [self.selectSchoolArr removeAllObjects];
            [self.selectSubjectDict removeAllObjects];
            
            [weakSelf.dataSource addObjectsFromArray:packVolModel.data];
            weakSelf.packetVolModel = packVolModel;
            if (DRArrayIsEmpty(packVolModel.data)) {
                [weakSelf configEmptyViewWithError:EMPTYDATA];
            }

            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
        } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
    //        if (DRArrayIsEmpty(weakSelf.packetVolModel.data)) {
    //            [weakSelf configEmptyViewWithError:EMPTYDATA];
    //        }
            [weakSelf removeOverFlowActivityView];
            [weakSelf presentErrorSheet:errorStr];
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
        }];
    
}

-(void)getVoluntaryTargetBatchData {
    //获取建议填报批次
    HUZWEAK_SELF;
    [self getVoluntaryTargetBatch:^(HUZTargetBatchDataModel * _Nonnull batchDataModel) {
        weakSelf.batchDataModel = batchDataModel;
        weakSelf.batch = batchDataModel.targetBatch.Id;
        weakSelf.batchName = batchDataModel.targetBatch.batchName;
        self.headerView.titleLb.text = [NSString stringWithFormat:@"当前选择批次:%@",batchDataModel.targetBatch.batchName];
        [self getVolunteerVoluntaryList];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.packetVolModel.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    HUZPacketVolListModel *list = self.packetVolModel.data[section];
    return list.subjectVoList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    HUZVolPacketCell *cell = [HUZVolPacketCell cellWithTableView:tableView];
    HUZPacketVolListModel *model = self.packetVolModel.data[indexPath.section];
    HUZSubjectVoListModel *major = model.subjectVoList[indexPath.row];
    
    cell.model = major;
    cell.indexPath = indexPath;
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.packetVolModel.data.count > 0) {
        return AutoDistance(102);
    }
    return 0.00001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectModel:)];
    
    HUZVolPacketHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HUZVolPacketHeaderView"];
    headerView.tag = section;
    [headerView addGestureRecognizer:tap];
    
    HUZPacketVolListModel *packetVol = self.packetVolModel.data[section];
    headerView.model = packetVol;
    headerView.isSelected = packetVol.isSelected;
    headerView.section = section;
    headerView.deletage = self;
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HUZPacketVolListModel *model = self.packetVolModel.data[indexPath.section];
    self.selectedModel = model;
    HUZSubjectVoListModel *major = model.subjectVoList[indexPath.row];
    
    NSArray *arr = self.selectSubjectDict[model.schoolId];
    NSMutableArray *selectMajorArr = [NSMutableArray arrayWithArray:arr];
    
    if (!major.isSelected) {
        if(selectMajorArr.count > 4) {
            [self presentSheet:@"当前学校最多选择5个专业"];
            return;
        }
    }
    
    major.isSelected = !major.isSelected;
    if (major.isSelected) {

        [selectMajorArr addObject:major];
    }else{
        [selectMajorArr removeObject:major];
    }
        // 遍历当所有cell反选，section反选
    BOOL sectionSelected = NO;
    for (int i = 0; i < model.subjectVoList.count; i++) {
        HUZSubjectVoListModel *major = model.subjectVoList[i];
        if (major.isSelected) {
            model.isSelected = YES;
            sectionSelected = YES;
            break;
        }else{
            sectionSelected = NO;
        }
    }
    model.isSelected = sectionSelected;//major.isSelected;
    
    if (sectionSelected) {
        model.selectSubjectVoList = selectMajorArr.copy;
        [self.selectSubjectDict setValue:selectMajorArr.copy forKey:model.schoolId];
        if (![self.selectSchoolArr containsObject:model]) {
            [self.selectSchoolArr addObject:model];
        }
    }else{
        [self.selectSubjectDict removeObjectForKey:model.schoolId];
        model.selectSubjectVoList = nil;
        [self.selectSchoolArr removeObject:model];
    }
    
    [self isHasSelectMajor];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    
}
/// 判断是否已有了选择
- (void)isHasSelectMajor {
    BOOL hasSelected = NO;
    for (HUZPacketVolListModel *list in self.packetVolModel.data) {
        if (list.isSelected) {
            hasSelected = YES;
            break;
        }
    }
    // 选择
    self.viewBotm.btnSelected.enabled = hasSelected;
    self.viewBotm.viewBotm.backgroundColor = hasSelected ? ColorS(COLOR_2E86FF) : ColorS(COLOR_989898);
}
#warning mark --

#pragma  mark -- 全选
- (void)selectModel:(UITapGestureRecognizer *)tap
{
    HUZPacketVolListModel *packetVol = self.packetVolModel.data[tap.view.tag];
    if (!packetVol.isSelected) {
        if(packetVol.subjectVoList.count > 5) {
            [self presentSheet:@"当前学校最多选择5个专业"];
            return;
        }
    }
    // 执行全选或反选
    packetVol.isSelected = !packetVol.isSelected;
    if (packetVol.isSelected) {
        packetVol.selectSubjectVoList = packetVol.subjectVoList.copy;
        [self.selectSchoolArr addObject:packetVol];
    }else{
        packetVol.selectSubjectVoList = nil;
        [self.selectSubjectDict removeObjectForKey:packetVol.schoolId];
        [self.selectSchoolArr removeObject:packetVol];
    }
    for (HUZSubjectVoListModel *major in packetVol.subjectVoList) {
        major.isSelected = packetVol.isSelected;
    }
    //是否已经选择了专业或者全选了，那么“选择”按钮就变色
    [self isHasSelectMajor];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:tap.view.tag] withRowAnimation:UITableViewRowAnimationFade];
}


#pragma mark - 选择按钮选择事件(前往志愿页面)
- (void)selectClick {
    
    NSMutableArray *batchUniversity1Arr = [NSMutableArray array];
    NSMutableArray *batchUniversity2Arr = [NSMutableArray array];
    NSMutableArray *batchUniversity3Arr = [NSMutableArray array];
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    if (self.selectSchoolArr.count > 6) {
        [self presentSheet:@"最多添加六所学校"];
        return;
    }
    for(HUZPacketVolListModel *selectSchoolModel in self.selectSchoolArr) {
        HUZSchoolModel *schoolModel = [HUZSchoolModel modelWithJSON:[selectSchoolModel modelToJSONString]];
        NSMutableArray *selectMajorArr = [NSMutableArray array];
        for (HUZSubjectVoListModel *subjctModel in selectSchoolModel.selectSubjectVoList) {
            HUZUniInfoGeneralizeMajorModel *majorModel = [HUZUniInfoGeneralizeMajorModel new];
            majorModel.majIntroduce = subjctModel.category;
            majorModel.majorAllId = subjctModel.majorAllId;
            majorModel.alternativeMajorId = subjctModel.alternativeMajorId;
            [selectMajorArr addObject:majorModel];
        }
        schoolModel.major = selectMajorArr.copy;
        if ([schoolModel.batch integerValue] == 1) {
            [batchUniversity1Arr addObject:schoolModel];
        }else if ([schoolModel.batch integerValue] == 2) {
            [batchUniversity2Arr addObject:schoolModel];
        }else{
            [batchUniversity3Arr addObject:schoolModel];
        }
    }
    if (batchUniversity1Arr.count > 0) {
        par[@"1"] = batchUniversity1Arr;
    }
    if (batchUniversity2Arr.count > 0) {
        par[@"2"] = batchUniversity2Arr;
    }
    
    if (batchUniversity3Arr.count > 0) {
        par[@"4"] = batchUniversity3Arr;
    }
    
    HUZFillVolunteerController *packet = [HUZFillVolunteerController new];
    packet.volunteerDict = par.copy;
    [self.navigationController pushViewController:packet animated:YES];
}
#pragma mark --- <HUZVolPacketHeaderViewDeletage,HUZVolPacketCellDelegate>
//删除学校
-(void)deleteActionSection:(NSInteger)section {
    
    ZJAnimationPopView *popView = [[ZJAnimationPopView alloc] initWithPopStyle:ZJAnimationPopStyleShake dismissStyle:ZJAnimationDismissStyleNO];
    [popView popAwaitAlertWithTitle:@"\"是否要删除所选学校\"" cancel:@"取消" confirm:@"确定"];
    popView.confirmClick = ^{
        
        HUZPacketVolListModel *packetVol = self.packetVolModel.data[section];
        [HUZNetWorkTool huz_GET:kUrl_volunteer_delete_alternativeSchool parameters:@{@"schoolId":packetVol.schoolId} success:^(id  _Nonnull responseObject) {
            NSString *codeStr = responseObject[@"code"];
            if ([codeStr integerValue] == 0) {
                [self presentSuccessSheet:@"删除成功"];
                [self configDatas];
            }else{
                [self presentErrorSheet:responseObject[@"msg"]];
            }
        } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
            [self presentErrorSheet:error];
        }];
    };
}
//删除专业
-(void)deleteMajorIndexPath:(NSIndexPath *)indexPath {
    ZJAnimationPopView *popView = [[ZJAnimationPopView alloc] initWithPopStyle:ZJAnimationPopStyleShake dismissStyle:ZJAnimationDismissStyleNO];
    [popView popAwaitAlertWithTitle:@"\"是否要删除所选专业\"" cancel:@"取消" confirm:@"确定"];
    popView.confirmClick = ^{
        
        HUZPacketVolListModel *packetVol = self.packetVolModel.data[indexPath.section];
        HUZSubjectVoListModel *subjectModel = packetVol.subjectVoList[indexPath.row];
        
        [HUZNetWorkTool huz_POST:kUrl_volunteer_delete_alternativeMajor parameters:@{@"schoolId":packetVol.schoolId,@"majorAllId":subjectModel.majorAllId} success:^(id  _Nonnull responseObject) {
            NSString *codeStr = responseObject[@"code"];
            if ([codeStr integerValue] == 0) {
                [self presentSuccessSheet:@"删除成功"];
                [self configDatas];
            }else{
                [self presentErrorSheet:responseObject[@"msg"]];
            }

        } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
            [self presentErrorSheet:error];
        }];
    };
}
#pragma mark -<HUZVolPacketHeaderViewDeletage> end
#pragma mark - HUZPPPSelectViewDelegate
- (void)pppSelectViewDelegateWith:(HUZPPPSelectView *)selectView indexPath:(NSIndexPath*)indexPAth result:(NSString *)result {
    
    HUZTargetBatchModel *batchModel = nil;
    if (self.batchDataModel.suitableBatch.count > indexPAth.row) {
        batchModel = self.batchDataModel.suitableBatch[indexPAth.row];
    }

    self.batchName = batchModel.batchName;
    self.headerView.titleLb.text = [NSString stringWithFormat:@"当前选择批次:%@",batchModel.batchName];
    self.batch = batchModel.Id;
    [self getVolunteerVoluntaryList];
}
#pragma mark --lazy
-(NSMutableArray *)selectSchoolArr {
    if (!_selectSchoolArr) {
        _selectSchoolArr = [NSMutableArray array];
    }
    return _selectSchoolArr;
}

-(NSMutableDictionary *)selectSubjectDict {
    if (!_selectSubjectDict) {
        _selectSubjectDict = [NSMutableDictionary dictionary];
    }
    return _selectSubjectDict;
}

-(HUZVolunteerPacketHeaerView *)headerView {
    if (!_headerView) {
        _headerView = [HUZVolunteerPacketHeaerView viewFromXib];
        _headerView.backgroundColor = UIColor.whiteColor;
        HUZWEAK_SELF;
        [_headerView.titleLb addTapAction:^(id  _Nonnull sender) {
            NSMutableArray *batchArr = @[].mutableCopy;
            for (HUZTargetBatchModel *model in self.batchDataModel.suitableBatch) {
                [batchArr addObject:model.batchName];
            }
            weakSelf.pppView.dataArray = batchArr.copy;
            // 批次选择
            [weakSelf.pppView show];
        }];
    }
    return _headerView;
}


- (HUZPPPSelectView *)pppView {
    if (!_pppView) {
        _pppView = [HUZPPPSelectView new];
        _pppView.headTitle = @"请选择批次";
        _pppView.delegate = self;
        [self.view addSubview:_pppView];
    }
    return _pppView;
}

#pragma mark --lazy end
@end

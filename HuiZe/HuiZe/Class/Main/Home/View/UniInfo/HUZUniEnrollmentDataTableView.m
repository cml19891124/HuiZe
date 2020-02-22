//
//  HUZUniEnrollmentDataTableView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/25.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniEnrollmentDataTableView.h"
#import "HUZUniEnrollmentDataFirstCell.h"
#import "HUZUniEnrollmentDataSecondCell.h"
#import "HUZUniEnrollmentDataThirdCell.h"
#import "HUZUniEnrollmentInfoSectionView.h"
#import "HUZUniInfoFooterView.h"
#import "HUZEmptyFooterView.h"
#import "HUZAllMajorModel.h"
#import "HUZUniEnrollmentInfoViewController.h"
#import "HUZUniEnrollmentDataModel.h"
#import "HUZUniEnrollmentDataChartModel.h"
#import "HUZChooseTypeView.h"
#import "HUZUniInfoGeneralizeModel.h"
#import "HUZUniEnrollmentAdmissionHistoryModel.h"
#import "HUZUniEnrollmentAdmissionHistoryCell.h"
@interface HUZUniEnrollmentDataTableView ()<HUZPPPSelectViewDelegate>

@property (nonatomic,strong) HUZUniEnrollmentInfoSectionView *sectionView1;
@property (nonatomic,strong) HUZUniEnrollmentInfoSectionView *sectionView2;
@property (nonatomic,strong) HUZUniEnrollmentInfoSectionView *sectionView3;

@property (nonatomic, strong) HUZUniEnrollmentDataModel * enrollmenModel;
@property (nonatomic, strong) HUZUniEnrollmentDataChartModel * charModel;//图表数据

@property (nonatomic,strong) HUZPPPSelectView *selectBatchView;
@property (nonatomic,strong) HUZPPPSelectView *lookTypeSelectView;
@property (nonatomic,strong) HUZPPPSelectView *gradeSelectView;
@property (nonatomic, strong) HUZPPPSelectView * yearSelectView;
@property (nonatomic, strong) HUZPPPSelectView * majorSelectView;

@property (nonatomic, strong) HUZUniEnrollmentDataSecondCell *dataSecondCell;
@property (nonatomic, strong) NSMutableDictionary * chartPar;
@property (nonatomic, strong) NSMutableDictionary * formerPar;

@property (nonatomic, strong) NSMutableArray * majorNameArr;
@property (nonatomic, strong) NSMutableArray * schoolMajorArr;

@property (nonatomic, strong) HUZChooseTypeView *yearView ;
@property (nonatomic, strong) NSMutableArray * admissionHistoryArr;
@end

@implementation HUZUniEnrollmentDataTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        [self dz_registerCell:[HUZUniEnrollmentDataFirstCell class]];
        [self dz_registerCell:[HUZUniEnrollmentDataFirstCell class]];
        [self dz_registerCell:[HUZUniEnrollmentDataThirdCell class]];
        [self dz_registerCell:[HUZGoToBuyVipCell class]];
        [self registerNib:[UINib nibWithNibName:@"HUZUniEnrollmentAdmissionHistoryCell" bundle:nil] forCellReuseIdentifier:@"HUZUniEnrollmentAdmissionHistoryCell"];
        
        HUZUniEnrollmentInfoSectionView *sectionView = [[HUZUniEnrollmentInfoSectionView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(74))];
        sectionView.labTitle.text = @"历年院校录取数据";
        sectionView.type = HUZUniEnrollmentInfoPlan;
        if (!sectionView.ivBatch.labContent.text) {
            sectionView.ivBatch.labContent.text = @"本科第一批";
        }
        sectionView.ivBatch.hidden = YES;
        HUZWEAK_SELF;
//        [sectionView.ivBatch addTapAction:^(UIGestureRecognizer   *sender) {
//            weakSelf.selectBatchView.tag = 11000;
//            [weakSelf.selectBatchView show];
//        }];
//        sectionView.ivScore.hidden = YES;
//        if (sectionView.ivScore.labContent.text) {
//            sectionView.ivScore.labContent.text = @"录取人数";
//        }
//        [sectionView.ivScore addTapAction:^(UIGestureRecognizer   *sender) {
//            [weakSelf.lookTypeSelectView show];
//        }];
//        sectionView.ivSubject.hidden = YES;
//        if (!sectionView.ivSubject.labContent.text) {
//            sectionView.ivSubject.labContent.text = @"理科";
//        }
//        [sectionView.ivSubject addTapAction:^(UIGestureRecognizer   *sender) {
//            weakSelf.gradeSelectView.tag = 11002;
//            [weakSelf.gradeSelectView show];
//        }];
        UILabel *batchLb = [[UILabel alloc] init];
        batchLb.font = FontS(FONT_12);
        batchLb.textColor = ColorS(COLOR_989898);
        batchLb.text = @"招生批次";
        
        UILabel *avgAndMaxL = [[UILabel alloc] init];
        avgAndMaxL.font = FontS(FONT_12);
        avgAndMaxL.textColor = ColorS(COLOR_989898);
        avgAndMaxL.text = @"最高分/平均分";
        
        UILabel *minLb = [[UILabel alloc] init];
        minLb.font = FontS(FONT_12);
        minLb.textColor = ColorS(COLOR_989898);
        minLb.text = @"最底分/最底位次";
        
        UILabel *palNumLb = [[UILabel alloc] init];
        palNumLb.font = FontS(FONT_12);
        palNumLb.textColor = ColorS(COLOR_989898);
        palNumLb.text = @"录取数";
        
        [sectionView addSubview:batchLb];
        [batchLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(AutoDistance(50));
            make.height.mas_equalTo(20);
        }];
        
        [sectionView addSubview:palNumLb];
        [palNumLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(AutoDistance(50));
            make.height.mas_equalTo(20);
        }];
        
        UIView *centerView = [UIView new];
        [sectionView addSubview:centerView];
        [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(AutoDistance(50));
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(20);
            make.centerX.mas_equalTo(sectionView);
        }];
        
        [sectionView addSubview:avgAndMaxL];
        [avgAndMaxL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(centerView.mas_left).mas_equalTo(0);
            make.top.mas_equalTo(AutoDistance(50));
            make.height.mas_equalTo(20);
        }];
        
        [sectionView addSubview:minLb];
        [minLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(centerView.mas_right).mas_equalTo(0);
            make.top.mas_equalTo(AutoDistance(50));
            make.height.mas_equalTo(20);
        }];
        
        
        
        self.sectionView2 = sectionView;
        
        
        
        
        HUZUniEnrollmentInfoSectionView *sectionView3 = [[HUZUniEnrollmentInfoSectionView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(74))];
        sectionView3.labTitle.text = @"历年专业录取数据";
        sectionView3.type = HUZUniEnrollmentInfoPlan;
        CGFloat w = (HUZSCREEN_WIDTH - 5*AutoDistance(8)) / 4.0;

        sectionView3.ivBatch.labContent.text = @"2018";
        [sectionView3.ivBatch addTapAction:^(UIGestureRecognizer   *sender) {
            [weakSelf.yearSelectView show];
        }];
        sectionView3.ivScore.labContent.text = @"本科一批";
        [sectionView3.ivScore addTapAction:^(UIGestureRecognizer   *sender) {
            weakSelf.selectBatchView.tag = 11005;
            [weakSelf.selectBatchView show];
//            [weakSelf.majorSelectView show];
        }];
        sectionView3.ivSubject.labContent.text = @"文理科";
        sectionView3.ivSubject.ivSelect.hidden = YES;
        self.sectionView3 = sectionView3;
    }
    return self;
}
-(void)setMajorModel:(HUZAllMajorModel *)majorModel {
    _majorModel = majorModel;
    [self.majorNameArr removeAllObjects];
    for (HUZAllMajorDataFirstModel *model in majorModel.data) {
        [self.majorNameArr addObject:model.category];
    }
}

-(void)setSchoolId:(NSString *)schoolId {
    _schoolId = [schoolId copy];
    [self loadEnrollmentData];
//    [self loadSchoolAdmissionData];
    [self loadSchoolFormerData];
    [self loadUniversityAdmissionHistoryData];
}
-(void)setVipState:(NSInteger)vipState {
    _vipState = vipState;
    [self reloadData];
}
-(void)loadEnrollmentData {
    HUZWEAK_SELF
    [HUZNetWorkTool huz_POSTWithForm:kUrl_recruitPlan_getEnrollsitTest parameters:@{@"schoolId":self.schoolId} success:^(id  _Nonnull responseObject) {
        NSString *codeStr = responseObject[@"code"];
        if ([codeStr integerValue] == 0) {
             self.enrollmenModel = [HUZUniEnrollmentDataModel modelWithJSON:responseObject[@"data"]];
            [self reloadData];
        }else{
            [self presentErrorSheet:responseObject[@"msg"]];
        }
        
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        [weakSelf presentErrorSheet:error];
    }];
}
//获取历年录取数据
-(void)loadUniversityAdmissionHistoryData {
    HUZWEAK_SELF;
    [HUZNetWorkTool huz_GET:[NSString stringWithFormat:@"%@%@",kUrl_University_AdmissionHistory,self.schoolId] parameters:nil success:^(id  _Nonnull responseObject) {
        NSString *codeStr = responseObject[@"code"];
        if ([codeStr integerValue] == 0) {
            [self.admissionHistoryArr removeAllObjects];
            NSArray *arr = [NSArray modelArrayWithClass:[HUZUniEnrollmentAdmissionHistoryModel class] json:responseObject[@"data"]];
            [self.admissionHistoryArr addObjectsFromArray:arr];
            [self reloadData];
        }else{
            [self presentErrorSheet:responseObject[@"msg"]];
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        [weakSelf presentErrorSheet:error];
    }];
}
////获取图表数据
//-(void)loadSchoolAdmissionData {
//    HUZWEAK_SELF
//    [HUZNetWorkTool huz_POST:kUrl_recruitPlan_schoolAdmissionData parameters:self.chartPar success:^(id  _Nonnull responseObject) {
//        NSString *codeStr = responseObject[@"code"];
//        if ([codeStr integerValue] == 0) {
//            self.charModel = [HUZUniEnrollmentDataChartModel modelWithJSON:responseObject[@"data"]];
//            [self reloadData];
//        }else{
//            [self presentErrorSheet:responseObject[@"msg"]];
//        }
//
//    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
//        [weakSelf presentErrorSheet:error];
//    }];
//}
//历年专业录取数据
-(void)loadSchoolFormerData{
    self.formerPar[@"schoolId"] = self.schoolId;
    HUZWEAK_SELF
    [HUZNetWorkTool huz_POST:kUrl_University_majorAdmissionHistory parameters:self.formerPar success:^(id  _Nonnull responseObject) {
        NSString *codeStr = responseObject[@"code"];
        if ([codeStr integerValue] == 0) {
            [self.schoolMajorArr removeAllObjects];
            NSArray *arr = [NSArray modelArrayWithClass:[HUZUniInfoGeneralizeMajorModel class] json:responseObject[@"data"][@"list"]];
            [self.schoolMajorArr addObjectsFromArray:arr];
            [self reloadData];
        }else{
            [self presentErrorSheet:responseObject[@"msg"]];
        }
        NSLog(@"responseObject: %@",responseObject);
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        [weakSelf presentErrorSheet:error];
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.vipState < 2) {
        return 1;
    }else{
        if (section == 0) return 1;
        if (section == 1) {
            return self.admissionHistoryArr.count;
        }
        return self.schoolMajorArr.count;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.vipState < 2) {
        return 100;
    }else{
        if (indexPath.section == 0) return AutoDistance(206);
        else if (indexPath.section == 1) return AutoDistance(80);
        else {
            HUZUniInfoGeneralizeMajorModel *model = nil;
            if (indexPath.row < self.schoolMajorArr.count) {
                model = self.schoolMajorArr[indexPath.row];
            }

            return  [tableView fd_heightForCellWithIdentifier:@"HUZUniEnrollmentDataThirdCell" configuration:^(HUZUniEnrollmentDataThirdCell *cell) {
                cell.majorModel = model;
            }];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.vipState < 2) {
        HUZGoToBuyVipCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HUZGoToBuyVipCell"];
        cell.title = @"开通会员、立即查看详情";
        return cell;
    }else{
        /// 招生录取情况
        if (indexPath.section == 0) {
            HUZUniEnrollmentDataFirstCell *cell = [HUZUniEnrollmentDataFirstCell cellWithTableView:tableView];
            cell.dataModel = self.enrollmenModel;
            return cell;
        }
        
        /// 历年录取数据 singleBarChartView
        else if (indexPath.section == 1){
            HUZUniEnrollmentAdmissionHistoryModel *historyModel = nil;
            if (indexPath.row < self.admissionHistoryArr.count) {
                historyModel = self.admissionHistoryArr[indexPath.row];
            }
            HUZUniEnrollmentAdmissionHistoryCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HUZUniEnrollmentAdmissionHistoryCell"];
            cell.historyModel = historyModel;
            cell.topView.hidden = NO;
            if (indexPath.row == 0) {
                cell.topView.hidden = YES;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
//            HUZUniEnrollmentDataSecondCell *cell = [HUZUniEnrollmentDataSecondCell cellWithTableView:tableView];
//            self.dataSecondCell = cell;
//            cell.chartModel = self.charModel;
//            return cell;
        }
        
        /// 历年专业录取数据
        else{
            HUZUniEnrollmentDataThirdCell *cell = [HUZUniEnrollmentDataThirdCell cellWithTableView:tableView];
            HUZUniInfoGeneralizeMajorModel *model = nil;
            if (indexPath.row < self.schoolMajorArr.count) {
                model = self.schoolMajorArr[indexPath.row];
            }
            cell.majorModel = model;
            return cell;
        }
        
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if(self.vipState < 2) {
//        return 100;
//    }else{
    if (section == 1 || section == 2) return AutoDistance(74);
    return AutoDistance(50);
//    }

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        HUZUniEnrollmentInfoSectionView *sectionView = [[HUZUniEnrollmentInfoSectionView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(50))];
        sectionView.labTitle.text = [NSString stringWithFormat:@"%@年招生录取情况",self.enrollmenModel.title];//@"18年招生录取情况";
        sectionView.type = HUZUniEnrollmentInfoRegulation;
        self.sectionView1 = sectionView;
        return self.sectionView1;
    }else if(section == 1){
        if (self.vipState < 2) {
            self.sectionView2.ivBatch.hidden = YES;
            self.sectionView2.ivScore.hidden = YES;
            self.sectionView2.ivSubject.hidden = YES;
        }else{
            self.sectionView2.ivBatch.hidden = YES;
            self.sectionView2.ivScore.hidden = YES;
            self.sectionView2.ivSubject.hidden = YES;
        }
        return self.sectionView2;
    }else{
        if (self.vipState < 2) {
            self.sectionView3.ivBatch.hidden = YES;
            self.sectionView3.ivScore.hidden = YES;
            self.sectionView3.ivSubject.hidden = YES;
            self.yearView.hidden = YES;
        }else{
            self.sectionView3.ivBatch.hidden = NO;
            self.sectionView3.ivScore.hidden = NO;
            self.sectionView3.ivSubject.hidden = NO;
            self.yearView.hidden = NO;
        }
//        self.sectionView3.ivScore.hidden = YES;
        return self.sectionView3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.vipState < 2) {
        return 0.001;;
    }else{
        if (section == 0) return AutoDistance(32);
        if (section == 1) return 8;
        return AutoDistance(44);
    }

}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.vipState < 2) {
        return nil;
    }else{
        if (section == 0) {
            HUZEmptyFooterView *footerView = [[HUZEmptyFooterView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(44))];
            return footerView;
        }else if(section == 1){
            return nil;
        }else{
            HUZUniInfoFooterView *footer = [[HUZUniInfoFooterView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(47))];
            [footer.btnMore addTarget:self action:@selector(clickEnroolmentInfo) forControlEvents:UIControlEventTouchUpInside];
            return footer;
        }
    }
}
#pragma mark - UITableViewDelegate, UITableViewDataSource end
/// 具体招录情况
- (void)clickEnroolmentInfo{
    HUZUniEnrollmentInfoViewController *uniEnrollmentInfoVC = [HUZUniEnrollmentInfoViewController new];
    uniEnrollmentInfoVC.schoolId = self.schoolId;
    [[UIViewController currentViewController].navigationController pushViewController:uniEnrollmentInfoVC animated:YES];
}

#pragma mark --lazy
-(NSMutableDictionary *)chartPar {
    if (!_chartPar) {
        _chartPar = [NSMutableDictionary dictionary];
        _chartPar[@"batch"] = @"1";
        _chartPar[@"grade"] = @"1";
        _chartPar[@"type"] = @"3";
        _chartPar[@"schoolId"] = self.schoolId;
    }
    return _chartPar;
}

-(NSMutableDictionary *)formerPar {
    if (!_formerPar) {
        _formerPar = [NSMutableDictionary dictionary];
        _formerPar[@"batch"] = @"1";
        //_formerPar[@"grade"] = @"1";
        _formerPar[@"year"] = @"2018";
//        _formerPar[@"majorAllId"] = @"0";
        _formerPar[@"pageNow"] = @"1";
        _formerPar[@"pageSize"] = @"6";
    }
    return _formerPar;
}

-(HUZPPPSelectView *)gradeSelectView {
    if (!_gradeSelectView) {
        _gradeSelectView = [HUZPPPSelectView new];
        _gradeSelectView.headTitle = @"选择文理科";
        _gradeSelectView.delegate = self;
        _gradeSelectView.dataArray = @[@"文科",@"理科"].copy;//0,1,2,@"综合"
        
        [self.YQViewController.view addSubview:_gradeSelectView];
    }
    return _gradeSelectView;
}

-(HUZPPPSelectView *)lookTypeSelectView {
    if (!_lookTypeSelectView) {
        _lookTypeSelectView = [HUZPPPSelectView new];
        _lookTypeSelectView.headTitle = @"选择你要看的数据方式";
        _lookTypeSelectView.delegate = self;
        _lookTypeSelectView.dataArray = @[@"录取最低分",@"最低分数差",@"录取最低排名",@"录取人数"].copy;
        _lookTypeSelectView.tag = 11001;
        [self.YQViewController.view addSubview:_lookTypeSelectView];
    }
    return _lookTypeSelectView;
}

-(HUZPPPSelectView *)selectBatchView {
    if (!_selectBatchView) {
        _selectBatchView = [HUZPPPSelectView new];
        _selectBatchView.headTitle = @"选择批次";
        _selectBatchView.delegate = self;
        _selectBatchView.dataArray = @[@"本科一批",@"本科二批",@"专科(高职)批"].copy;//HUZDataBaseManager.dataBatch.mutableCopy;
        
        [self.YQViewController.view addSubview:_selectBatchView];
    }
    return _selectBatchView;
}

-(HUZPPPSelectView *)yearSelectView {
    if (!_yearSelectView) {
        _yearSelectView = [HUZPPPSelectView new];
        _yearSelectView.headTitle = @"选择年份";
        _yearSelectView.delegate = self;
        _yearSelectView.dataArray = @[@"2019",@"2018",@"2017",@"2016",@"2015"].mutableCopy;;
        _yearSelectView.tag = 11003;
        [self.YQViewController.view addSubview:_yearSelectView];
    }
    return _yearSelectView;
}

-(HUZPPPSelectView *)majorSelectView {
    if (!_majorSelectView) {
        _majorSelectView = [HUZPPPSelectView new];
        _majorSelectView.headTitle = @"专业";
        _majorSelectView.delegate = self;
        _majorSelectView.dataArray = self.majorNameArr;
        _majorSelectView.tag = 11004;
        [self.YQViewController.view addSubview:_majorSelectView];
    }
    return _majorSelectView;
}

-(NSMutableArray *)majorNameArr {
    if (!_majorNameArr) {
        _majorNameArr = [NSMutableArray array];
    }
    return _majorNameArr;
}
-(NSMutableArray *)schoolMajorArr {
    if (!_schoolMajorArr) {
        _schoolMajorArr = [NSMutableArray array];
    }
    return _schoolMajorArr;
}

-(NSMutableArray *)admissionHistoryArr {
    if (!_admissionHistoryArr) {
        _admissionHistoryArr = [NSMutableArray array];
    }
    return _admissionHistoryArr;
}

#pragma mark --lazy end

#pragma mark --HUZPPPSelectViewDelegate
- (void)pppSelectViewDelegateWith:(HUZPPPSelectView *)selectView indexPath:(NSIndexPath*)indexPAth result:(NSString *)result {
    if (selectView.tag == 11000) {
        self.chartPar[@"batch"] = [NSString stringWithFormat:@"%zd",indexPAth.row];
        self.sectionView2.ivBatch.labContent.text = result;
//        [self loadSchoolAdmissionData];
    }else if (selectView.tag == 11001) {
        self.chartPar[@"type"] = [NSString stringWithFormat:@"%zd",indexPAth.row];
        self.sectionView2.ivScore.labContent.text = result;
        self.dataSecondCell.type = indexPAth.row;
        self.dataSecondCell.singleBarChartView.labToppic.text = result;
        self.dataSecondCell.lineChartView.labToppic.text = result;
//        [self loadSchoolAdmissionData];
    }else if (selectView.tag == 11002) {
        self.chartPar[@"grade"] = [NSString stringWithFormat:@"%zd",indexPAth.row];
        self.sectionView2.ivSubject.labContent.text = result;
//        [self loadSchoolAdmissionData];
    }else if (selectView.tag == 11003) {
        self.formerPar[@"year"] = result;
        //self.yearView.labContent.text = result;
        self.sectionView3.ivBatch.labContent.text = result;
        [self loadSchoolFormerData];
    }else if (selectView.tag == 11004) {
        HUZAllMajorDataFirstModel *model = self.majorModel.data[indexPAth.row];
        self.formerPar[@"majorAllId"] = model.majorAllId;
        self.sectionView3.ivScore.labContent.text = result;
        [self loadSchoolFormerData];
    }else if (selectView.tag == 11005) {
        self.formerPar[@"batch"] = [NSString stringWithFormat:@"%zd",indexPAth.row+1];
        self.sectionView3.ivScore.labContent.text = result;
        //self.sectionView3.ivBatch.labContent.text = result;
        [self loadSchoolFormerData];
    }else if (selectView.tag == 11006) {
        self.formerPar[@"grade"] = [NSString stringWithFormat:@"%zd",indexPAth.row];
        self.sectionView3.ivSubject.labContent.text = result;
        [self loadSchoolFormerData];
    }
}
#pragma mark --HUZPPPSelectViewDelegate end
@end

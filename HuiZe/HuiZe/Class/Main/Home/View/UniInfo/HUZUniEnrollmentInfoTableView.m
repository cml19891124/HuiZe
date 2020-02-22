//
//  HUZUniEnrollmentInfoTableView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/25.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniEnrollmentInfoTableView.h"
#import "HUZUniEnrollmentInfoSectionView.h"
#import "HUZUniEnrollmentInfoMajorCell.h"
#import "HUZUniEnrollmentInfoRegulationCell.h"
#import "HUZUniEnrollmentInfoFooterView.h"
#import "HUZAllMajorModel.h"
#import "HUZEnrollmentRegulationViewController.h"
#import "HUZUniEnrollmentInfoModel.h"
#import "HUZUniEnrollmentInfoViewController.h"
#import "HUZRecruitConstitutionListModel.h"
#import "HUZAgreementViewController.h"
#import "HUZMajorInfoViewController.h"
@interface HUZUniEnrollmentInfoTableView ()<HUZPPPSelectViewDelegate>
@property (nonatomic, strong) HUZUniEnrollmentInfoSectionView *uniEnrollmentInfoSectionView;

@property (nonatomic,strong) HUZPPPSelectView *selectBatchView;
@property (nonatomic,strong) HUZPPPSelectView *majorSelectView;
@property (nonatomic,strong) HUZPPPSelectView *gradeSelectView;
@property (nonatomic, strong) NSMutableArray * majorNameArr;

@property (nonatomic, strong) NSMutableDictionary * dataPar;

@property (nonatomic, strong) NSMutableArray *enrollmentInfoArr;
@property (nonatomic, strong) NSMutableArray *recruitConstitutionArr;
@end

@implementation HUZUniEnrollmentInfoTableView

-(void)setVipState:(NSInteger)vipState {
    _vipState = vipState;
    if (self.vipState >= 2) {
        [self getMajorAdmissionData];
    }else{
        [self reloadData];
    }
    
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        [self dz_registerCell:[HUZUniEnrollmentInfoMajorCell class]];
        [self dz_registerCell:[HUZUniEnrollmentInfoRegulationCell class]];
        [self dz_registerCell:[HUZGoToBuyVipCell class]];
        
    }
    return self;
}

-(void)setSchoolId:(NSString *)schoolId {
    _schoolId = [schoolId copy];
    if (self.vipState >= 2) {
        [self getMajorAdmissionData];
    }
    [self getRecruitConstitutionList];
}

-(void)setMajorModel:(HUZAllMajorModel *)majorModel {
    _majorModel = majorModel;
    [self.majorNameArr removeAllObjects];
    for (HUZAllMajorDataFirstModel *model in majorModel.data) {
        [self.majorNameArr addObject:model.category];
    }
}
//专业招生计划数据
-(void)getMajorAdmissionData {
    self.dataPar[@"schoolId"] = self.schoolId;
    HUZWEAK_SELF
    [HUZNetWorkTool huz_POST:kUrl_recruitPlan_majorAdmissionData parameters:self.dataPar success:^(id  _Nonnull responseObject) {
        NSString *codeStr = responseObject[@"code"];
        if ([codeStr integerValue] == 0) {
            [self.enrollmentInfoArr removeAllObjects];
            NSArray *arr = [NSArray modelArrayWithClass:[HUZUniEnrollmentInfoModel class] json:responseObject[@"data"][@"list"]];
            [self.enrollmentInfoArr addObjectsFromArray:arr];
            [self reloadData];
        }else{
            [self presentErrorSheet:responseObject[@"msg"]];
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        [weakSelf presentErrorSheet:error];
    }];
}
/*
 招生简章
 */
-(void)getRecruitConstitutionList {
    HUZWEAK_SELF
    
    [HUZNetWorkTool huz_POSTWithForm:kUrl_recruitPlan_recruitConstitutionList parameters:@{@"schoolId":self.schoolId} success:^(id  _Nonnull responseObject) {
        NSString *codeStr = responseObject[@"code"];
        if ([codeStr integerValue] == 0) {
            [self.recruitConstitutionArr removeAllObjects];
            NSArray *arr = [NSArray modelArrayWithClass:[HUZRecruitConstitutionListModel class] json:responseObject[@"data"]];
            [self.recruitConstitutionArr addObjectsFromArray:arr];
            [self reloadData];
        }else{
            [self presentErrorSheet:responseObject[@"msg"]];
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        [weakSelf presentErrorSheet:error];
    }];
    
    
//    [HUZNetWorkTool huz_POSTWithForm:@"/api/recruitPlan/recruitConstitution" parameters:@{@"schoolId":self.schoolId,@"yearId":@"2018"} success:^(id  _Nonnull responseObject) {
//        NSString *codeStr = responseObject[@"code"];
//        if ([codeStr integerValue] == 0) {
//
//        }else{
//            [self presentErrorSheet:responseObject[@"msg"]];
//        }
//    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
//        [weakSelf presentErrorSheet:error];
//    }];
}


#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.vipState < 2) {
        if (section == 0) {
            return 1;
        }else{
            return self.recruitConstitutionArr.count;
        }
    }
    return section == 0 ? self.enrollmentInfoArr.count : self.recruitConstitutionArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.vipState < 2) {
        if (indexPath.section == 0) {
            return 100;
        }else{
            return AutoDistance(60);
        }
    }
    return indexPath.section == 0 ? AutoDistance(82) : AutoDistance(60);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.vipState < 2) {
        if (indexPath.section == 0) {
            HUZGoToBuyVipCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HUZGoToBuyVipCell"];
            cell.title = @"开通会员、立即查看详情";
            return cell;
        }else{
            HUZUniEnrollmentInfoRegulationCell *cell = [HUZUniEnrollmentInfoRegulationCell cellWithTableView:tableView];
            cell.ivDiviceline.hidden = indexPath.row == 1 ? YES : NO;
            HUZRecruitConstitutionListModel *listModel = nil;
            if (self.recruitConstitutionArr.count > indexPath.row) {
                listModel = self.recruitConstitutionArr[indexPath.row];
            }
            cell.listMode = listModel;
            return cell;
        }
    }else{
        if (indexPath.section == 0) {
            HUZUniEnrollmentInfoMajorCell *cell = [HUZUniEnrollmentInfoMajorCell cellWithTableView:tableView];
            cell.ivDiviceline.hidden = indexPath.row == (self.enrollmentInfoArr.count -1) ? YES : NO;
            HUZUniEnrollmentInfoModel *model = nil;
            if (self.enrollmentInfoArr.count > indexPath.row) {
                model = self.enrollmentInfoArr[indexPath.row];
            }
            cell.infoModel = model;
            return cell;
        }else{
            HUZUniEnrollmentInfoRegulationCell *cell = [HUZUniEnrollmentInfoRegulationCell cellWithTableView:tableView];
            cell.ivDiviceline.hidden = indexPath.row == 1 ? YES : NO;
            HUZRecruitConstitutionListModel *listModel = nil;
            if (self.recruitConstitutionArr.count > indexPath.row) {
                listModel = self.recruitConstitutionArr[indexPath.row];
            }
            cell.listMode = listModel;
            return cell;
        }
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ? AutoDistance(76) : AutoDistance(36);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        if (self.vipState < 2) {
            self.uniEnrollmentInfoSectionView.ivBatch.hidden = YES;
            self.uniEnrollmentInfoSectionView.ivScore.hidden = YES;
            self.uniEnrollmentInfoSectionView.ivSubject.hidden = YES;
        } else {
            self.uniEnrollmentInfoSectionView.ivBatch.hidden = NO;
            self.uniEnrollmentInfoSectionView.ivScore.hidden = NO;
            self.uniEnrollmentInfoSectionView.ivSubject.hidden = NO;
        }
        self.uniEnrollmentInfoSectionView.ivScore.hidden = YES;
        return self.uniEnrollmentInfoSectionView;
    }
    CGFloat sectionH = section == 0 ? AutoDistance(76) : AutoDistance(36);
    HUZUniEnrollmentInfoSectionView *uniEnrollmentInfoSectionView2 = [[HUZUniEnrollmentInfoSectionView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, sectionH)];
    uniEnrollmentInfoSectionView2.type = section == 0 ? HUZUniEnrollmentInfoPlan : HUZUniEnrollmentInfoRegulation;
    uniEnrollmentInfoSectionView2.labTitle.text = section == 0 ? @"专业招生计划" : @"招生章程";
    
    return uniEnrollmentInfoSectionView2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.vipState < 2) {
        return 0.001;
    }
    return section == 0 ? AutoDistance(49) : 0.000001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.vipState < 2) {
        return [UIView new];
    }
    if (section == 0) {
        HUZUniEnrollmentInfoFooterView *footerView = [[HUZUniEnrollmentInfoFooterView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(49))];
        [footerView.btnMore addTapAction:^(id  _Nonnull sender) {
            HUZUniEnrollmentInfoViewController *uniEnrollmentInfoVC = [HUZUniEnrollmentInfoViewController new];
            uniEnrollmentInfoVC.schoolId = self.schoolId;
            [[UIViewController currentViewController].navigationController pushViewController:uniEnrollmentInfoVC animated:YES];
        }];
        return footerView;
    }
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
//        HUZEnrollmentRegulationViewController *enrollmentRegulationVC = [HUZEnrollmentRegulationViewController new];
//        [[UIViewController currentViewController].navigationController pushViewController:enrollmentRegulationVC animated:YES];
        HUZRecruitConstitutionListModel *listModel = nil;
        if (self.recruitConstitutionArr.count > indexPath.row) {
            listModel = self.recruitConstitutionArr[indexPath.row];
        }
        HUZAgreementViewController *agreementVC = [[HUZAgreementViewController alloc] init];
        agreementVC.url =[NSString stringWithFormat:@"http://m.hz985211.com/m/news/school/regulations/%@/%@",self.schoolId,listModel.year];
        
        [self.YQViewController.navigationController pushViewController:agreementVC animated:true];
    }else{
        HUZUniEnrollmentInfoModel *model = nil;
        if (self.enrollmentInfoArr.count > indexPath.row) {
            model = self.enrollmentInfoArr[indexPath.row];
        }
        
        HUZMajorInfoViewController *VC = [[HUZMajorInfoViewController alloc] init];
        VC.majorId = model.majorAllId;
        [self.YQViewController.navigationController pushViewController:VC animated:true];
    }
}

#pragma mark - UITableViewDelegate, UITableViewDataSource end
#pragma mark - <HUZPPPSelectViewDelegate>
- (void)pppSelectViewDelegateWith:(HUZPPPSelectView *)selectView indexPath:(NSIndexPath*)indexPAth result:(NSString *)result {
    if (selectView.tag == 11110) {
        self.uniEnrollmentInfoSectionView.ivBatch.labContent.text = result;
        self.dataPar[@"batch"] = [NSString stringWithFormat:@"%zd",indexPAth.row];
        [self getMajorAdmissionData];
    }else if(selectView.tag == 11111) {
        self.uniEnrollmentInfoSectionView.ivScore.labContent.text = result;
        HUZAllMajorDataFirstModel *model = self.majorModel.data[indexPAth.row];
        self.dataPar[@"majorAllId"] = model.majorAllId;
        [self getMajorAdmissionData];
    }else if(selectView.tag == 11112) {
        self.uniEnrollmentInfoSectionView.ivSubject.labContent.text = result;
        self.dataPar[@"grade"] = [NSString stringWithFormat:@"%zd",indexPAth.row];
        [self getMajorAdmissionData];
    }
}

#pragma mark - <HUZPPPSelectViewDelegate> end
#pragma mark -- lazy
-(HUZPPPSelectView *)selectBatchView {
    if (!_selectBatchView) {
        _selectBatchView = [HUZPPPSelectView new];
        _selectBatchView.headTitle = @"选择批次";
        _selectBatchView.delegate = self;
        _selectBatchView.dataArray = HUZDataBaseManager.dataBatch.mutableCopy;
        _selectBatchView.tag = 11110;
        [self.YQViewController.view addSubview:_selectBatchView];
    }
    return _selectBatchView;
}

-(HUZPPPSelectView *)majorSelectView {
    if (!_majorSelectView) {
        _majorSelectView = [HUZPPPSelectView new];
        _majorSelectView.headTitle = @"专业";
        _majorSelectView.delegate = self;
        _majorSelectView.dataArray = self.majorNameArr;
        _majorSelectView.tag = 11111;
        [self.YQViewController.view addSubview:_majorSelectView];
    }
    return _majorSelectView;
}

-(HUZPPPSelectView *)gradeSelectView {
    if (!_gradeSelectView) {
        _gradeSelectView = [HUZPPPSelectView new];
        _gradeSelectView.headTitle = @"选择文理科";
        _gradeSelectView.delegate = self;
        _gradeSelectView.dataArray = @[@"文科",@"理科"].copy;//0,1,2 ,@"综合"
        _gradeSelectView.tag = 11112;
        [self.YQViewController.view addSubview:_gradeSelectView];
    }
    return _gradeSelectView;
}

-(NSMutableArray *)recruitConstitutionArr {
    if (!_recruitConstitutionArr) {
        _recruitConstitutionArr = [NSMutableArray array];
    }
    return _recruitConstitutionArr;
}
-(NSMutableArray *)majorNameArr {
    if (!_majorNameArr) {
        _majorNameArr = [NSMutableArray array];
    }
    return _majorNameArr;
}
-(NSMutableArray *)enrollmentInfoArr {
    if (!_enrollmentInfoArr) {
        _enrollmentInfoArr = [NSMutableArray array];
    }
    return _enrollmentInfoArr;
}

-(NSMutableDictionary *)dataPar {
    if (!_dataPar) {
        _dataPar = [NSMutableDictionary dictionary];
        _dataPar[@"batch"] = @"1";
        _dataPar[@"grade"] = @"1";
        _dataPar[@"majorAllId"] = @"-1";
        _dataPar[@"pageNow"] = @"1";
        _dataPar[@"pageSize"] = @"5";
    }
    return _dataPar;
}

-(HUZUniEnrollmentInfoSectionView *)uniEnrollmentInfoSectionView {
    if (!_uniEnrollmentInfoSectionView) {
        _uniEnrollmentInfoSectionView = [[HUZUniEnrollmentInfoSectionView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(76))];
        _uniEnrollmentInfoSectionView.type = HUZUniEnrollmentInfoPlan;
        _uniEnrollmentInfoSectionView.ivBatch.labContent.text = @"本科第一批";
        _uniEnrollmentInfoSectionView.ivScore.labContent.text = @"专业";
        _uniEnrollmentInfoSectionView.ivSubject.labContent.text = @"理科";
        _uniEnrollmentInfoSectionView.labTitle.text = @"专业招生计划";
        HUZWEAK_SELF;
        [_uniEnrollmentInfoSectionView.ivBatch addTapAction:^(id  _Nonnull sender) {
            [weakSelf.selectBatchView show];
        }];
        
        [_uniEnrollmentInfoSectionView.ivScore addTapAction:^(id  _Nonnull sender) {
            [weakSelf.majorSelectView show];
        }];
        
        [_uniEnrollmentInfoSectionView.ivSubject addTapAction:^(id  _Nonnull sender) {
            [weakSelf.gradeSelectView show];
        }];
        
    }
    return _uniEnrollmentInfoSectionView;
}
#pragma mark -- lazy
@end


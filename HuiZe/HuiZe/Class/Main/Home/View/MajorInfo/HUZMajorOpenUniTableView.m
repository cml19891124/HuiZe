//
//  HUZMajorOpenUniTableView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/28.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZMajorOpenUniTableView.h"
#import "HUZUniEnrollmentInfoSectionView.h"
#import "HUZOpenAllFooterView.h"
#import "HUZMajorOpenUniCell.h"
#import "HUZProvinceModel.h"
#import "HUZLoginService.h"
#import "HUZUniInfoModel.h"
#import "HUZUniInfoViewController.h"
@interface HUZMajorOpenUniTableView ()<HUZPPPSelectViewDelegate>
@property (nonatomic, strong) HUZUniEnrollmentInfoSectionView * sectionView;
@property (nonatomic,strong) HUZPPPSelectView *selectProvinceView;
@property (nonatomic,strong) HUZProvinceModel *provinceModel;

@property (nonatomic,strong) HUZPPPSelectView *selectSchoolTypeView;
@property (nonatomic, strong) NSMutableDictionary *universityPar;

@property (nonatomic, strong) NSMutableArray *universityArr;
@property (nonatomic, strong) HUZOpenAllFooterView *openAllFooterView;

@property (nonatomic, assign) BOOL isShowAll;
@end

@implementation HUZMajorOpenUniTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.isShowAll = NO;
        [self dz_registerCell:[HUZMajorOpenUniCell class]];
        [self dz_registerCell:[HUZGoToBuyVipCell class]];
        [self clickAllprovince];
    }
    return self;
}
-(void)setMajorId:(NSString *)majorId {
    _majorId = [majorId copy];
    if (self.vipState >= 2) {
        [self loadUniversity];
    }
}
- (void)clickAllprovince{
    /// 省份
    [self displayOverFlowActivityView];
    [HUZLoginService getProvinceSuccess:^(HUZProvinceModel * _Nonnull object) {
        [self removeOverFlowActivityView];
        self.provinceModel = [HUZProvinceModel new];
        self.provinceModel = object;
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        [self removeOverFlowActivityView];
        [self presentErrorSheet:errorStr];
    }];
}

-(void)setVipState:(NSInteger)vipState {
    _vipState = vipState;
    if (self.vipState >= 2) {
        [self loadUniversity];
    }else{
        [self reloadData];
    }
    
}

-(void)loadUniversity{
    HUZWEAK_SELF
    [HUZNetWorkTool huz_POST:kUrl_major_guess_university parameters:self.universityPar success:^(id  _Nonnull responseObject) {
        NSString *codeStr = responseObject[@"code"];
        if ([codeStr integerValue] == 0) {
            [self.universityArr removeAllObjects];
            NSArray *arr = [NSArray modelArrayWithClass:[HUZUniInfoDataModel class] json:responseObject[@"data"][@"list"]];
            [self.universityArr addObjectsFromArray:arr];
            [self reloadData];
        }else{
            [self presentErrorSheet:responseObject[@"msg"]];
        }
        
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        [weakSelf presentErrorSheet:error];
    }];

}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.vipState < 2) {
        return 1;
    } else {
        if (self.universityArr.count < 6) {
            return self.universityArr.count;
        }else if(self.isShowAll){
            return self.universityArr.count;
        }else{
            return 6;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.vipState < 2) {
        return 100;
    }
    return AutoDistance(60);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.vipState < 2) {
        HUZGoToBuyVipCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HUZGoToBuyVipCell"];
        cell.title = @"开通会员、立即查看详情";
        return cell;
    }
    HUZUniInfoDataModel *dataModel = nil;
    if (indexPath.row < self.universityArr.count) {
        dataModel = self.universityArr[indexPath.row];
    }

    HUZMajorOpenUniCell *cell = [HUZMajorOpenUniCell cellWithTableView:tableView];
    cell.dataModel = dataModel;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AutoDistance(78);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (self.vipState < 2) {
        self.sectionView.ivBatch.hidden = YES;
        self.sectionView.ivSubject.hidden = YES;
    }else{
        self.sectionView.ivBatch.hidden = NO;
        self.sectionView.ivSubject.hidden = NO;
    }
    return self.sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.vipState < 2) {
        return 0.001;
    }
    if (self.universityArr.count <= 0) {
        return 0.001;
    }
    return AutoDistance(41);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.vipState < 2) {
        return nil;
    }
    if (self.universityArr.count <= 0) {
        return nil;
    }
    return self.openAllFooterView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HUZUniInfoDataModel *dataModel = nil;
    if (indexPath.row < self.universityArr.count) {
        dataModel = self.universityArr[indexPath.row];
    }
    HUZUniInfoViewController *uniInfoVC = [HUZUniInfoViewController new];
    uniInfoVC.schoolId = dataModel.schoolId;
    [self.YQViewController.navigationController pushViewController:uniInfoVC animated:true];
}

-(void)btnOpenAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.isShowAll = sender.selected;
    [self reloadData];
}
#pragma mark HUZPPPSelectViewDelegate
-(HUZOpenAllFooterView *)openAllFooterView {
    if (!_openAllFooterView) {
        _openAllFooterView = [[HUZOpenAllFooterView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(41))];
        [_openAllFooterView.btnOpen addTarget:self action:@selector(btnOpenAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _openAllFooterView;
}

- (void)pppSelectViewDelegateWith:(HUZPPPSelectView *)selectView indexPath:(NSIndexPath*)indexPAth result:(NSString *)result {
    if (selectView.tag == 11010) {
        HUZProvince *province = self.provinceModel.data[indexPAth.row];
        self.universityPar[@"provinceId"] = province.Id;
        self.sectionView.ivBatch.labContent.text = result;
        [self loadUniversity];
    }else if(selectView.tag == 11011){
        self.universityPar[@"schoolType"] = [NSString stringWithFormat:@"%zd",indexPAth.row - 1];
        self.sectionView.ivSubject.labContent.text = result;
        [self loadUniversity];
    }
}
#pragma mark --lazy
-(HUZUniEnrollmentInfoSectionView *)sectionView {
    if (!_sectionView) {
        _sectionView = [[HUZUniEnrollmentInfoSectionView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(78))];
        _sectionView.type = HUZOpenUni;
        _sectionView.labTitle.text = @"开设院校";
        _sectionView.ivScore.hidden = YES;
        _sectionView.ivBatch.labContent.text = @"城市";
        _sectionView.ivSubject.labContent.text = @"综合";
        HUZWEAK_SELF;
        [_sectionView.ivBatch addTapAction:^(id  _Nonnull sender) {
            [weakSelf.selectProvinceView show];
        }];
        [_sectionView.ivSubject addTapAction:^(id  _Nonnull sender) {
            [weakSelf.selectSchoolTypeView show];
        }];
        
    }
    return _sectionView;
}

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
        _selectProvinceView.tag = 11010;
        [self.YQViewController.view addSubview:_selectProvinceView];
    }
    return _selectProvinceView;
}

-(HUZPPPSelectView *)selectSchoolTypeView {
    if (!_selectSchoolTypeView) {
        _selectSchoolTypeView = [HUZPPPSelectView new];
        _selectSchoolTypeView.headTitle = @"选择学校类别";
        _selectSchoolTypeView.delegate = self;
        _selectSchoolTypeView.dataArray = HUZDataBaseManager.dataSchoolType.mutableCopy;
        _selectSchoolTypeView.tag = 11011;
        [self.YQViewController.view addSubview:_selectSchoolTypeView];
    }
    return _selectSchoolTypeView;
}

-(NSMutableDictionary *)universityPar {
    if (!_universityPar) {
        _universityPar = [NSMutableDictionary dictionary];
        _universityPar[@"majorId"] = self.majorId;
        _universityPar[@"pageNow"] = @"1";
        _universityPar[@"pageSize"] =  @"2000";
//        _universityPar[@"provinceId"] = @"-1";
        _universityPar[@"schoolType"] = @"0";
    }
    return _universityPar;
}

-(NSMutableArray *)universityArr {
    if (!_universityArr) {
        _universityArr = [NSMutableArray array];
    }
    return _universityArr;
}
#pragma mark --lazy end
@end

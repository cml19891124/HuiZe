//
//  HUZUninfoHistoryEnrollmentTableView.m
//  HuiZe
//
//  Created by tbb on 2019/11/18.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZUninfoHistoryEnrollmentTableView.h"
#import "HUZUniEnrollmentDataThirdCell.h"
#import "HUZUniEnrollmentInfoSectionView.h"
@interface HUZUninfoHistoryEnrollmentTableView ()<HUZPPPSelectViewDelegate>
@property (nonatomic, strong) NSMutableDictionary * formerPar;
@property (nonatomic, strong) NSMutableArray * schoolMajorArr;
@property (nonatomic,strong) HUZUniEnrollmentInfoSectionView *sectionView3;

@property (nonatomic,strong) HUZPPPSelectView *gradeSelectView;
@property (nonatomic, strong) HUZPPPSelectView * yearSelectView;
@property (nonatomic,strong) HUZPPPSelectView *selectBatchView;

@end

@implementation HUZUninfoHistoryEnrollmentTableView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.rowHeight = AutoDistance(82);
        [self dz_registerCell:[HUZUniEnrollmentDataThirdCell class]];
        HUZUniEnrollmentInfoSectionView *sectionView3 = [[HUZUniEnrollmentInfoSectionView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(44))];
        sectionView3.labTitle.frame = CGRectMake(0, 0, 0, 0);
        sectionView3.ivBatch.huz_centerY = sectionView3.huz_centerY;
        sectionView3.ivScore.huz_centerY = sectionView3.huz_centerY;
        sectionView3.ivSubject.huz_centerY = sectionView3.huz_centerY;

        
        
//        sectionView3.labTitle.text = @"历年专业录取数据";
        sectionView3.type = HUZUniEnrollmentInfoPlan;
        
            
        sectionView3.ivBatch.labContent.text = @"2018";
        HUZWEAK_SELF;
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
        [self setupRefresh];
    }
    return self;
}

-(void)setSchoolId:(NSString *)schoolId {
    _schoolId = [schoolId copy];
    [self onStartRefresh];
}

- (void)onStartRefresh {
    self.page = 1;
    [self loadSchoolFormerData];
}

-(void)onStartLoadMore {
    self.page ++;
    [self loadSchoolFormerData];
}

//历年专业录取数据
-(void)loadSchoolFormerData{
    self.formerPar[@"schoolId"] = self.schoolId;
    self.formerPar[@"pageNow"] = @(self.page);
    HUZWEAK_SELF
    [HUZNetWorkTool huz_POST:kUrl_University_majorAdmissionHistory parameters:self.formerPar success:^(id  _Nonnull responseObject) {
        [self stopRefresh];
        NSString *codeStr = responseObject[@"code"];
        if ([codeStr integerValue] == 0) {
            if (self.page == 1) {
                [self.schoolMajorArr removeAllObjects];
            }
            NSArray *arr = [NSArray modelArrayWithClass:[HUZUniInfoGeneralizeMajorModel class] json:responseObject[@"data"][@"list"]];
            [self.schoolMajorArr addObjectsFromArray:arr];
            [self reloadData];
            if (arr.count == 0) {
                [self.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            [self presentErrorSheet:responseObject[@"msg"]];
        }
        NSLog(@"responseObject: %@",responseObject);
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        [self stopRefresh];
        [weakSelf presentErrorSheet:error];
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.schoolMajorArr.count;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HUZUniEnrollmentDataThirdCell *cell = [HUZUniEnrollmentDataThirdCell cellWithTableView:tableView];
    HUZUniInfoGeneralizeMajorModel *model = nil;
    if (indexPath.row < self.schoolMajorArr.count) {
        model = self.schoolMajorArr[indexPath.row];
    }
    cell.majorModel = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HUZUniInfoGeneralizeMajorModel *model = nil;
    if (indexPath.row < self.schoolMajorArr.count) {
        model = self.schoolMajorArr[indexPath.row];
    }
    return  [tableView fd_heightForCellWithIdentifier:@"HUZUniEnrollmentDataThirdCell" configuration:^(HUZUniEnrollmentDataThirdCell *cell) {
        cell.majorModel = model;
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.sectionView3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return AutoDistance(44);
}
#pragma mark - UITableViewDelegate, UITableViewDataSource end


#pragma mark --HUZPPPSelectViewDelegate
- (void)pppSelectViewDelegateWith:(HUZPPPSelectView *)selectView indexPath:(NSIndexPath*)indexPAth result:(NSString *)result {
    self.page = 1;
    if (selectView.tag == 11000) {

    }else if (selectView.tag == 11001) {

    }else if (selectView.tag == 11002) {

    }else if (selectView.tag == 11003) {
        self.formerPar[@"year"] = result;
        self.sectionView3.ivBatch.labContent.text = result;
        [self loadSchoolFormerData];
    }else if (selectView.tag == 11004) {

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

#pragma mark --lazy
-(NSMutableDictionary *)formerPar {
    if (!_formerPar) {
        _formerPar = [NSMutableDictionary dictionary];
        _formerPar[@"batch"] = @"1";
        _formerPar[@"year"] = @"2018";
        _formerPar[@"pageSize"] = @"10";
    }
    return _formerPar;
}

-(NSMutableArray *)schoolMajorArr {
    if (!_schoolMajorArr) {
        _schoolMajorArr = [NSMutableArray array];
    }
    return _schoolMajorArr;
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
#pragma mark --lazy end
@end
 

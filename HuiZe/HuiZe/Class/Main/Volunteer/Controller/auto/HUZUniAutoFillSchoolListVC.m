//
//  HUZUniAutoFillSchoolListVC.m
//  HuiZe
//
//  Created by tbb on 2019/11/20.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZUniAutoFillSchoolListVC.h"
#import "HUZUniAutoFillSchoolListHeader.h"
#import "HUZUniAutoFillSchoolMajorCell.h"
#import "HUZUniAutoFillSchoolListModel.h"
#import "HUZMineVolunteerListController.h"
@interface HUZUniAutoFillSchoolListVC ()
@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) UILabel * batchLb;
@property (nonatomic, strong) UILabel * voluntaryTitleLb;

@property (nonatomic, copy) NSArray * indexArr;
@end

@implementation HUZUniAutoFillSchoolListVC

- (void)viewDidLoad {
    self.style = UITableViewStyleGrouped;
    [super viewDidLoad];
    self.indexArr = @[@"A.",@"B.",@"C.",@"D.",@"E.",@"F.",@"G.",@"H.",
                      @"I.",@"J.",@"K.",@"L.",@"M.",@"N.",@"O.",@"P.",
                      @"Q.",@"R.",@"S.",@"T.",@"U.",@"V.",@"W.",@"X.",
                      @"Y.",@"Z."];
    self.navigationItem.title = @"将要生成的志愿表";
    [self showBarButton:NAV_RIGHT title:@"完成" fontColor:ColorS(COLOR_2E86FF)];
    [self.tableView registerNib:[UINib nibWithNibName:@"HUZUniAutoFillSchoolListHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"HUZUniAutoFillSchoolListHeader"];
    [self.tableView registerClass:[HUZUniAutoFillSchoolMajorCell class] forCellReuseIdentifier:@"HUZUniAutoFillSchoolMajorCell"];
    self.tableView.tableHeaderView = self.headerView;
    if ([self.batch isEqualToString:@"1"] || [self.batch isEqualToString:@"2"]) {
        self.batchLb.text = @"本科批";
    }else{
        self.batchLb.text = @"专科(高职)批";
    }
    NSString *timeStr = [self currentDateStr];
    if (HUZUserCenterManager.userModel.estimateScore.length > 0) {
        self.voluntaryTitleLb.text = [NSString stringWithFormat:@"%@_%@",HUZUserCenterManager.userModel.estimateScore,timeStr];
    }
    
    
    [self getIntelligentFirstList];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = @"将要生成的志愿表";
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationItem.title = @"";
}

//获取当前时间
- (NSString *)currentDateStr{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"YYYYMMddhhmmss  "];//设定时间格式,这里可以设置成自己需要的格式
    NSString *dateString = [dateFormatter stringFromDate:currentDate];//将时间转化成字符串
    return dateString;
}


-(void)getIntelligentFirstList {
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    par[@"batch"] = self.batch;
    par[@"targetProvincesList"] = [self.targetProvincesList componentsSeparatedByString:@","];
    par[@"targetMajorList"] = [self.targetMajorList componentsSeparatedByString:@","];
    [HUZNetWorkTool huz_POST:kUrl_IntelligentFirst parameters:par success:^(id  _Nonnull responseObject) {
        NSString *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([codeStr integerValue] == 0) {
            [self.dataSource removeAllObjects];
            NSArray *arr = [NSArray modelArrayWithClass:[HUZUniAutoFillSchoolListModel class] json:responseObject[@"data"][@"list"]];
            [self.dataSource addObjectsFromArray:arr];
            [self.tableView reloadData];
        }else{
                [self presentErrorSheet:responseObject[@"msg"]];
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        [self presentErrorSheet:error];
    }];
}

- (void)rightButtonTouch{

    NSMutableArray * volunteerArr = [NSMutableArray array];
    for (HUZUniAutoFillSchoolListModel *schoolModel in self.dataSource) {
        [volunteerArr addObject:[self withMajorAllIdsSchoolModel:schoolModel]];
    }
    
    
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    par[@"alternativeType"] = @"0";
    par[@"volunteerName"] = self.voluntaryTitleLb.text;
    par[@"volunteerSchoolEntities"] = volunteerArr.copy;

    MJWeakSelf;
    [self displayOverFlowActivityView];
    self.rightBtn.userInteractionEnabled = NO;
    [HUZNetWorkTool huz_POST:kUrl_volunteer_saveVolunteer parameters:par success:^(id  _Nonnull responseObject) {
        [self removeOverFlowActivityView];
        self.rightBtn.userInteractionEnabled = YES;
        NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([code integerValue] == 0) {
            HUZMineVolunteerListController *vc = [HUZMineVolunteerListController new];
            vc.barckVc = @"HUZUniAutoFillController";
            [weakSelf.navigationController pushViewController:vc animated:true];
        }else{
            [weakSelf presentErrorSheet:responseObject[@"msg"]];
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        self.rightBtn.userInteractionEnabled = YES;
        [self removeOverFlowActivityView];
        [weakSelf presentErrorSheet:error];
    }];
    
}

//生成专业majorAllIds字符串
-(NSDictionary *)withMajorAllIdsSchoolModel:(HUZUniAutoFillSchoolListModel *)schoolModel {
    NSMutableDictionary *volunteerDict = [NSMutableDictionary dictionary];
    NSMutableString *allids = [NSMutableString string];
    for (HUZUniInfoGeneralizeMajorModel *majorModel in schoolModel.majorList) {
        if([allids removeStringSpace].length == 0){
            [allids appendString:majorModel.majorAllId];
        }else{
            [allids appendString:@","];
            [allids appendString:majorModel.majorAllId];
        }
    }
    volunteerDict[@"majorAllIds"] = allids;
    volunteerDict[@"schoolId"] = schoolModel.schoolId;
    volunteerDict[@"batch"] = self.batch;
    return volunteerDict.copy;
}


#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    HUZUniAutoFillSchoolListModel *schoolModel = nil;
    if (section < self.dataSource.count) {
        schoolModel = self.dataSource[section];
    }
    return schoolModel.majorList.count;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    HUZUniAutoFillSchoolListModel *schoolModel = nil;
    if (indexPath.section < self.dataSource.count) {
        schoolModel = self.dataSource[indexPath.section];
    }
    
    HUZUniAutoFillSchoolMajorListModel *majorModle = nil;
    if (indexPath.row < schoolModel.majorList.count) {
        majorModle = schoolModel.majorList[indexPath.row];
    }
    
    HUZUniAutoFillSchoolMajorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HUZUniAutoFillSchoolMajorCell"];
    cell.majorLb.text = [NSString stringWithFormat:@"%zd.%@",indexPath.row+1,majorModle.majIntroduce];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HUZUniAutoFillSchoolListModel *schoolModel = nil;
    if (indexPath.section < self.dataSource.count) {
        schoolModel = self.dataSource[indexPath.section];
    }
    
    HUZUniAutoFillSchoolMajorListModel *majorModle = nil;
    if (indexPath.row < schoolModel.majorList.count) {
        majorModle = schoolModel.majorList[indexPath.row];
    }
    
    return [tableView fd_heightForCellWithIdentifier:@"HUZUniAutoFillSchoolMajorCell" configuration:^(HUZUniAutoFillSchoolMajorCell *cell) {
        cell.majorLb.text = [NSString stringWithFormat:@"%zd.%@",indexPath.row+1,majorModle.majIntroduce];
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 8;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HUZUniAutoFillSchoolListModel *schoolModel = nil;
    if (section < self.dataSource.count) {
        schoolModel = self.dataSource[section];
    }
    
    
    HUZUniAutoFillSchoolListHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HUZUniAutoFillSchoolListHeader"];
    if (section < self.indexArr.count) {
        header.indexLb.text = self.indexArr[section];
    }
    header.schoolModel = schoolModel;
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 56;
}
#pragma mark - UITableViewDelegate, UITableViewDataSource end

-(UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, 82)];
        _headerView.backgroundColor = UIColor.whiteColor;
        _batchLb = [UILabel new];
        _batchLb.textColor = ColorS(COLOR_414141);
        _batchLb.font = [UIFont systemFontOfSize:14 weight:(UIFontWeightMedium)];
        _batchLb.text = @"---";
        
        _voluntaryTitleLb = [UILabel new];
        _voluntaryTitleLb.textColor = ColorS(COLOR_414141);
        _voluntaryTitleLb.font = [UIFont systemFontOfSize:14 weight:(UIFontWeightMedium)];
        _voluntaryTitleLb.text = @"---";
        
        [_headerView addSubview:_batchLb];
        [_batchLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(_headerView.mas_centerY);
        }];
        
        [_headerView addSubview:_voluntaryTitleLb];
        [_voluntaryTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(_headerView.mas_centerY);
        }];
        
        UIView *topView = [UIView new];
        topView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
        [_headerView addSubview:topView];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(8);
        }];
        
        UIView *bottonView = [UIView new];
        bottonView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
        [_headerView addSubview:bottonView];
        [bottonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(8);
        }];
        
    }
    return _headerView;
}

@end

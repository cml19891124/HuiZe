//
//  HUZFillVolunteerSelectMarjorVC.m
//  HuiZe
//
//  Created by tbb on 2019/10/30.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZFillVolunteerSelectMarjorVC.h"
#import "HUZUniMajorHeaderView.h"
#import "HUZUniInfoGeneralizeModel.h"
#import "HUZFillVolunteerSelectMarjorCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
@interface HUZFillVolunteerSelectMarjorVC ()
@property (nonatomic,strong) HUZUniMajorHeaderView *uniMajorHeaderView;
@property (nonatomic, copy) NSMutableArray * selectArr;
@end

@implementation HUZFillVolunteerSelectMarjorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.style = UITableViewStyleGrouped;
    self.navigationItem.title = @"添加专业";
    [self showBarButton:NAV_LEFT imageName:NAV_BACK_BLACK];
    self.tableView.tableHeaderView = self.uniMajorHeaderView;
    self.uniMajorHeaderView.infoModel = self.infoModel;
    [self setRightItemTitle];
    [self.tableView registerNib:[UINib nibWithNibName:@"HUZFillVolunteerSelectMarjorCell" bundle:nil] forCellReuseIdentifier:@"HUZFillVolunteerSelectMarjorCell"];
//    [self setupRefresh:self.tableView];
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getSchoolMarjorList)];
    [self getSchoolMarjorList];
}

-(void)setMarjorArr:(NSArray *)marjorArr {
    _marjorArr = [marjorArr copy];
}
-(void)getSchoolMarjorList {

    HUZWEAK_SELF
    NSString *url = [NSString stringWithFormat:@"%@%@",kUrl_volunteer_voluntaryTest1,self.infoModel.schoolId];
    [HUZNetWorkTool huz_GET:url parameters:@{} success:^(id  _Nonnull responseObject) {
        HUZSTRONG_SELF;
        [strongSelf stopRefresh:weakSelf.tableView];
        NSInteger code = [[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue];
        if (code == 0) {
            [weakSelf.dataSource removeAllObjects];
            NSArray *arr = [NSArray modelArrayWithClass:[HUZUniInfoGeneralizeMajorModel class] json:responseObject[@"data"]];
            [weakSelf.dataSource addObjectsFromArray:arr];
            
            //筛选出已选择的数据
            if (weakSelf.selectArr.count > 0) {
                [weakSelf selectWithAction];
            }
            
            //如果是从外面伟进来数据也要，筛选出已选择的数据
            if(self.marjorArr.count > 0) {
                [weakSelf havaSelectWithAction];
            }
            
            [weakSelf.tableView reloadData];
        }else{
                [weakSelf presentErrorSheet:responseObject[@"msg"]];
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
//        [strongSelf presentSuccessSheet:@"登录成功"];
        [weakSelf presentErrorSheet:error];
        [weakSelf stopRefresh:weakSelf.tableView];
    }];
}
-(void)havaSelectWithAction {
    for (HUZUniInfoGeneralizeMajorModel *majorModel in self.dataSource) {
        for (HUZUniInfoGeneralizeMajorModel *selectMarjorModel in self.marjorArr) {
            if ([majorModel.majorAllId isEqualToString:selectMarjorModel.majorAllId]) {
                majorModel.alternative = YES;
                [self.selectArr addObject:majorModel];
                break;
            }
        }
    }
    self.marjorArr = @[];
}
#pragma mark -- 过滤已经选择的
-(void)selectWithAction {
    for (HUZUniInfoGeneralizeMajorModel *majorModel in self.dataSource) {
        for (HUZUniInfoGeneralizeMajorModel *selectMarjorModel in self.selectArr) {
            if ([majorModel.majorAllId isEqualToString:selectMarjorModel.majorAllId]) {
                majorModel.alternative = YES;
            }
        }
    }
}
-(void)setRightItemTitle {
    
    UIButton *cloreBtn = [UIButton buttonWithType:0];
    cloreBtn.titleLabel.font = [UIFont systemFontOfSize:15 weight:(UIFontWeightMedium)];//[UIFont systemFontOfSize:15];
    [cloreBtn setTitle:@"完成" forState:(UIControlStateNormal)];
    [cloreBtn setTitleColor:ColorS(COLOR_BG_2E86FF) forState:(UIControlStateNormal)];
    [cloreBtn addTarget:self action:@selector(rightItemAction:) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:cloreBtn];
    [cloreBtn.titleLabel sizeToFit];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)rightItemAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:true];
}
//划动时调用
- (void)willMoveToParentViewController:(UIViewController *)parent {
    if(!parent) {
        if (self.selectMarjorBlock) {
            self.selectMarjorBlock(self.selectArr.copy);
        }
    }
}
//完全退出时调用
- (void)didMoveToParentViewController:(UIViewController *)parent {
    
}


- (HUZUniMajorHeaderView *)uniMajorHeaderView{
    CGFloat H = HUZSCREEN_WIDTH >= 414 ? 105 : 90;
    if (!_uniMajorHeaderView) {
        _uniMajorHeaderView = [[HUZUniMajorHeaderView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, H)];
    }
    return _uniMajorHeaderView;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HUZUniInfoGeneralizeMajorModel *majorModel = nil;
    if (indexPath.section < self.dataSource.count) {
        majorModel = self.dataSource[indexPath.section];
    }
    HUZFillVolunteerSelectMarjorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HUZFillVolunteerSelectMarjorCell"];
    cell.majorModel = majorModel;
    cell.selectBtn.tag = 11100 + indexPath.section;
    [cell.selectBtn addTarget:self action:@selector(selectMarjorAction:) forControlEvents:(UIControlEventTouchUpInside)];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HUZUniInfoGeneralizeMajorModel *majorModel = nil;
    if (indexPath.section < self.dataSource.count) {
        majorModel = self.dataSource[indexPath.section];
    }
    return  [tableView fd_heightForCellWithIdentifier:@"HUZFillVolunteerSelectMarjorCell" configuration:^(HUZFillVolunteerSelectMarjorCell *cell) {
        cell.majorModel = majorModel;
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if (section == 0) {
//        return 10;
//    }
    return 0.001;
}
#pragma mark - UITableViewDelegate, UITableViewDataSource end
#pragma mark -- 添加备选志愿
-(void)selectMarjorAction:(UIButton *)sender {
    if (self.selectArr.count > 4) {
        [self presentErrorSheet:@"当前学校最多只能选择五个专业"];
        return;
    }
    NSInteger section = sender.tag - 11100;
    HUZUniInfoGeneralizeMajorModel *majorModel = nil;
    if (section < self.dataSource.count) {
        majorModel = self.dataSource[section];
    }
    majorModel.alternative = !majorModel.alternative;
    if (majorModel.alternative) {
        [self.selectArr addObject:majorModel];
    }else{
        NSInteger index = 0;
        for (NSInteger i = 0; i<self.selectArr.count; i++) {
            HUZUniInfoGeneralizeMajorModel *selectMajorModel  = self.selectArr[i];
            if ([selectMajorModel.majorAllId isEqualToString:majorModel.majorAllId]) {
                index = i;
            }
        }
        [self.selectArr removeObjectAtIndex:index];
    }
    [self.tableView reloadData];
}

#pragma mark --lazy
-(NSMutableArray *)selectArr {
    if (!_selectArr) {
        _selectArr = [NSMutableArray array];
    }
    return _selectArr;
}
#pragma mark --lazy end
@end

//
//  HUZVolunteerSelectController.m
//  HuiZe
//
//  Created by mac on 2019/4/27.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZVolunteerSelectController.h"
#import "HUZVolProfessionalSelectView.h"
#import "HUZVolunteerUniCell.h"
#import "HUZUniFiltrateView.h"
#import "HUZVolunteerPacketController.h"
#import "HUZVolunteerBottomView.h"
#import "HUZVolSelHeaderView.h"
#import "HUZVolunteerService.h"
#import "HUZVoluntPriorityModel.h"
#import "HUZMyVipCardViewController.h"
@interface HUZVolunteerSelectController ()<HUZVolProfessionalSelectViewDelegate,HUZPPPSelectViewDelegate>
@property (nonatomic,strong) HUZVolunteerBottomView *viewBotm;
@property (nonatomic,strong) HUZUniFiltrateView *filtrateView;
@property (nonatomic,strong) UIView *rightfullView;
@property (nonatomic,assign) NSUInteger selIndex;

/**
 筛选条件的各种属性
 */
@property (nonatomic, copy) NSString *category;//批次
@property (nonatomic, copy) NSString *address;//大学所在地省份id

@property (nonatomic, copy) NSString *keyOne;//1代表985，2代表211，3代表双一流

@property (nonatomic, copy) NSString *schoolPrivate;//学校性质（0 公办 1民办

@property (nonatomic, copy) NSString *schoolType;//学校类型（0综合，1工科，2师范，3农业，4医药，5军事，6林业，7语言，8财经，9体育，10艺术，11政法，12民族）
@property (nonatomic, copy) NSString *score;

@property (nonatomic,strong)HUZPPPSelectView *scorePopView;
@end

@implementation HUZVolunteerSelectController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"挑选";

}



- (void)configComponents {
    [super configComponents];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-AutoDistance(49));
    }];
    self.tableView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    self.view.backgroundColor = self.tableView.backgroundColor;
    self.tableView.separatorColor = self.tableView.backgroundColor;
    [self.tableView dz_registerCell:[HUZVolunteerUniCell class]];
    self.cellHeight = AutoDistance(173);
    
    self.viewBotm = [[HUZVolunteerBottomView alloc]initWithFrame:CGRectMake(0, HUZSCREEN_HEIGHT - HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT - AutoDistance(49), HUZSCREEN_WIDTH, AutoDistance(49))];
    self.viewBotm.viewBotm.backgroundColor = ColorS(COLOR_2E86FF);
    [self.viewBotm.btnSelected setTitleColor:COLOR_BG_WHITE forState:UIControlStateNormal];
    [self.viewBotm.btnSelected setTitle:@"我的备选志愿" forState:UIControlStateNormal];
    [self.viewBotm.btnSelected addTarget:self action:@selector(selectedVolunteer) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.viewBotm];
    
    HUZWEAK_SELF
    self.tableView.mj_header = [HUZRefreshHeader headerWithRefreshingBlock:^{
        HUZSTRONG_SELF
        strongSelf.page = 1;
        [strongSelf loadDatas];
    }];
    self.tableView.mj_footer = [HUZRefreshFooter footerWithRefreshingBlock:^{
        HUZSTRONG_SELF
        strongSelf.page ++;
        [strongSelf loadDatas];
    }];
    [self.tableView.mj_header beginRefreshing];
}

- (void)setVolType:(NSInteger)volType {
    _volType = volType;
    
    
    self.category = @"-1";
    self.address = @"-1";
    
    self.schoolPrivate = @"-1";
    
    self.schoolType = @"-1";
    
    self.keyOne = @"-1";
    
    self.score = @"1";
//    self.batchId = @"1";
}

- (void)loadDatas {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    dic[@"type"] = @(self.volType);
    dic[@"batch"] = self.batchId;
    //optional pramaters
    dic[@"pageNow"] = @(self.page);
    
    
    if (!self.isMajorPriority) {
        dic[@"pageSize"] = @(self.size);
        dic[@"category"] = @(self.category.intValue);
        dic[@"address"] = self.address;
        dic[@"keyOne"] = @(self.keyOne.intValue);
        dic[@"schoolPrivate"] = @(self.schoolPrivate.intValue);
        dic[@"schoolType"] = @(self.schoolType.intValue);
        dic[@"score"] = self.score;//1.默认降序不需要，0升序
    }else{
        dic[@"majorAllIds"] = self.majorAllIdsArr;
    }
    
    HUZWEAK_SELF;
    [self displayOverFlowActivityView];
    
    NSString *url = self.isMajorPriority ? KUrl_volunteerMajorUniversitySelect : kUrl_volunteerSchoolApplicationTest;
    [HUZNetWorkTool huz_POST:url parameters:dic success:^(id  _Nonnull responseObject) {
        [weakSelf removeOverFlowActivityView];
        if (DRArrayIsEmpty(weakSelf.dataSource)) {
            [weakSelf configEmptyViewWithError:EMPTYDATA];
        }
        NSString *codeStr = responseObject[@"code"];
        if ([codeStr integerValue] == 0) {
            if (self.page == 1) {
                [self.dataSource removeAllObjects];
            }
            NSArray *arr = [NSArray modelArrayWithClass:[HUZVoluntPriority class] json:responseObject[@"data"][@"list"]];
            [self.dataSource addObjectsFromArray:arr];
            [weakSelf.tableView reloadData];
            if (arr.count == 0) {
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            [weakSelf presentErrorSheet:responseObject[@"msg"]];
        }
        
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        
        //NSString *totalPageStr = responseObject[@"data"][@"totalPage"];

    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        if (DRArrayIsEmpty(weakSelf.dataSource)) {
            [weakSelf configEmptyViewWithError:EMPTYDATA];
        }
        [weakSelf removeOverFlowActivityView];
        [weakSelf presentErrorSheet:error];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];

}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    HUZWEAK_SELF;
    HUZVolunteerUniCell *cell = [HUZVolunteerUniCell cellWithTableView:tableView];
    cell.model = self.dataSource[indexPath.row];
    cell.addMajor = ^{
        weakSelf.selIndex = indexPath.row;
        [weakSelf selectMajor];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return AutoDistance(8);
//}


- (void)selectedVolunteer {
    HUZVolunteerPacketController *packet = [HUZVolunteerPacketController new];
    packet.batch = self.batchId;
    [self.navigationController pushViewController:packet animated:YES];
}
//弹出专业选择
- (void)selectMajor{
    NSInteger vipState = [HUZUserCenterManager.userModel.vip integerValue];
    if (vipState < 2) {
        HUZMyVipCardViewController *myVipCardVC = [HUZMyVipCardViewController new];
        [self.navigationController pushViewController:myVipCardVC animated:YES];
        return;
    }
    
    HUZVoluntPriority *model = self.dataSource[_selIndex];
    HUZLOG(@"schoolId: %@", model.schoolId);
    [self displayOverFlowActivityView];
    [HUZVolunteerService getVoluntaryAccordingSchoolWithID:model.schoolId success:^(HUZVoluntaryModel * _Nonnull voluntaryModel) {
        [self removeOverFlowActivityView];
        HUZVolProfessionalSelectView *major = [HUZVolProfessionalSelectView new];
        major.alternativeType = self.isMajorPriority ? 2 : 1;
        major.delegate = self;
        major.model = voluntaryModel;
        major.ID = model.ID;
        major.voluntPriorityModel = model;
        major.schoolName = model.schoolName.length > 0 ? model.schoolName : model.yuanxiaomingcheng;
        major.headTitle = @"请将你想上的专业加入备选";
        [self.view addSubview:major];
        [major show];
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        [self removeOverFlowActivityView];
        [self presentErrorSheet:errorStr];
    }];
    
}

- (void)filterClick { // 筛选

    UIView *rightfullView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT)];
    self.rightfullView = rightfullView;
    rightfullView.backgroundColor=[UIColor colorWithWhite:0 alpha:0.3];
    [[UIApplication sharedApplication].keyWindow addSubview:rightfullView];
    UIView *leftfullView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, AutoDistance(55), HUZSCREEN_HEIGHT)];
    leftfullView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [leftfullView addGestureRecognizer:tap];
    [rightfullView addSubview:leftfullView];
    self.filtrateView = [[HUZUniFiltrateView alloc]initWithFrame:CGRectMake(HUZSCREEN_WIDTH, 0, HUZSCREEN_WIDTH-AutoDistance(55), HUZSCREEN_HEIGHT)];

    HUZWEAK_SELF
    self.filtrateView.sendBlock = ^(NSString * _Nonnull category, NSString * _Nonnull address, NSString * _Nonnull keyOne, NSString * _Nonnull schoolPrivate, NSString * _Nonnull schoolType, NSString * _Nonnull score) {
        
        HUZSTRONG_SELF
        weakSelf.category = category;
        
        weakSelf.address = address;

        weakSelf.keyOne = keyOne;

        weakSelf.schoolPrivate = schoolPrivate;

        weakSelf.schoolType = schoolType;

//        weakSelf.score = score;

        [strongSelf loadDatas];
        
        [weakSelf.rightfullView removeFromSuperview];
    };
    [rightfullView addSubview:self.filtrateView];
    [UIView animateWithDuration:0.5 animations:^{
        self.filtrateView.frame = CGRectMake(50, 0, HUZSCREEN_WIDTH-AutoDistance(55), HUZSCREEN_HEIGHT);
    }];
}

- (void)tapClick:(UITapGestureRecognizer *)tap {
    [self.rightfullView removeFromSuperview];
}

- (void)gradeClick { //录取分数
    [self.scorePopView show];
}


#pragma mark - HUZVolProfessionalSelectViewDelegate
- (void)professionalSelectViewDelegateWith:(HUZVolProfessionalSelectView *)selectView selectArr:(NSMutableArray *)selectArr {
    self.viewBotm.viewBotm.backgroundColor = selectArr.count > 0? ColorS(COLOR_F19147) : ColorS(COLOR_2E86FF);
    [self.viewBotm.btnSelected showBadgeWithStyle:WBadgeStyleRedDot value:0 animationType:WBadgeAnimTypeScale];
    // 刷新数据源
    [self loadDatas];
//    [self presentSuccessSheet:@"操作成功"];

}

- (HUZPPPSelectView *)scorePopView {
    if (!_scorePopView) {
        _scorePopView = [HUZPPPSelectView new];
        _scorePopView.headTitle = @"选择排序";
        _scorePopView.dataArray =  @[@"升序",@"降序"].copy;//[self filterBatchListWith:self.batchModel];
        _scorePopView.delegate = self;
        [self.view addSubview:_scorePopView];
    }
    return _scorePopView;
}
#pragma mark --- HUZPPPSelectViewDelegate
-(void)pppSelectViewDelegateWith:(HUZPPPSelectView *)selectView indexPath:(NSIndexPath *)indexPAth result:(NSString *)result {
    if (indexPAth.row == 0) {
        self.score = @"0";
    }else{
        self.score = @"1";
    }
    [self loadDatas];
}
#pragma mark --- HUZPPPSelectViewDelegate end
@end


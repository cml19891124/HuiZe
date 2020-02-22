//
//  HUZUniAutoFillController.m
//  HuiZe
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZUniAutoFillController.h"
#import "HUZVolunteerBottomView.h"
#import "HUZAutoDetailTableViewCell.h"
#import "HUZUniFitTableViewCell.h"
#import "HUZVolunteerDetailController.h"
#import "HUZVolunteerWishController.h"
#import "HUZMyGkInfoViewController.h"
#import "HUZVolunteerService.h"
#import "HUZPPPSelectView.h"
#import "HUZVolFillResultController.h"
#import "HUZTargetBatchModel.h"
#import "HUZRecommendUniModel.h"
#import "HUZUniAutoFillSchoolListVC.h"
#import "HUZMyVipCardViewController.h"
@interface HUZUniAutoFillController ()<HUZPPPSelectViewDelegate>
{
    NSArray *titleArray, *subtitleArray;
}
@property (nonatomic,strong) HUZVolunteerBottomView *viewBotm;

/**
 男女比例 1 男>女 2 男<女 3 男=女
 */
@property (nonatomic, copy) NSString *boyAndGirl;

/**
 一级专业id
 */
@property (nonatomic, copy) NSString *majorAllIds;
@property (nonatomic, copy) NSString *majorAllNames;

/**
 学校省份id
 */
@property (nonatomic, copy) NSString *schoolProvinceIds;
@property (nonatomic, copy) NSString *schoolProvinceNames;
//兴趣
@property (nonatomic, copy) NSString * charactersIds;

@property (nonatomic, strong) HUZPPPSelectView * selectSchoolBatchView;

@property (nonatomic, copy) NSString * batch;
@property (nonatomic, copy) NSString * batchName;
@property (nonatomic, strong) HUZTargetBatchDataModel * batchDataModel;
@end

@implementation HUZUniAutoFillController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"智能生成报告";
    
    self.boyAndGirl = @"0";
}

- (void)configComponents{
    [super configComponents];
    [self setupRefresh:self.tableView];
    titleArray = @[@"我的高考信息",@"建议填报批次",@"意愿设置"];
    NSString *gkInfo =  HUZUserCenterManager.gkInfo;
    subtitleArray = @[gkInfo,@"本科批",@"按偏好进行设置"];
    
    self.tableView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    self.tableView.separatorColor = self.tableView.backgroundColor;
    [self.tableView dz_registerCell:[HUZAutoDetailTableViewCell class]];
    [self.tableView dz_registerCell:[HUZUniFitTableViewCell class]];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(AutoDistance(8));
        make.left.right.equalTo(self.view);
        make.bottom.mas_offset(-AutoDistance(49));
    }];
    self.viewBotm = [[HUZVolunteerBottomView alloc]initWithFrame:CGRectMake(0, HUZSCREEN_HEIGHT - HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT - AutoDistance(49), HUZSCREEN_WIDTH, AutoDistance(49))];
    self.viewBotm.viewBotm.backgroundColor = ColorS(COLOR_2E86FF);
    [self.viewBotm.btnSelected setTitleColor:COLOR_BG_WHITE forState:UIControlStateNormal];
    [self.viewBotm.btnSelected setTitle:@"生成志愿表" forState:UIControlStateNormal];
    [self.viewBotm.btnSelected setImage:ImageNamed(@"ic_btn_dirom") forState:UIControlStateNormal];
    [self.viewBotm.btnSelected setImage:ImageNamed(@"ic_btn_dirom") forState:UIControlStateSelected];
    [self.viewBotm.btnSelected addTarget:self action:@selector(selectClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.viewBotm];
}

- (void)configDatas {
    [super configDatas];
    [self getVoluntaryTargetBatchData];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)getVoluntaryTargetBatchData {
    //获取建议填报批次
    HUZWEAK_SELF;
    [self getVoluntaryTargetBatch:^(HUZTargetBatchDataModel * _Nonnull batchDataModel) {
        weakSelf.batchDataModel = batchDataModel;
        NSString *gkInfo =  HUZUserCenterManager.gkInfo;
        self->subtitleArray = @[gkInfo,batchDataModel.targetBatch.batchName,@"按偏好进行设置"];
        self.batch = batchDataModel.targetBatch.Id;
//        if ([batchDataModel.targetBatch.Id isEqualToString:@"4"]) {
//            self.batch = @"3";
//        }
        self.batchName = batchDataModel.targetBatch.batchName;
        
        NSMutableArray *batchArr = @[].mutableCopy;
        for (HUZTargetBatchModel *model in batchDataModel.suitableBatch) {
            [batchArr addObject:model.batchName];
        }
        self.selectSchoolBatchView.dataArray = batchArr.copy;
        [self onStartRefresh];
    }];
}

- (void)onStartRefresh {
    self.page = 1;
    [self loadSchoolsData];
}

-(void)onStartLoadMore {
    self.page ++;
    [self loadSchoolsData];
}

- (void)loadSchoolsData
{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
//    [postDic setValue:self.boyAndGirl?:@"" forKey:@"boyAndGirl"]; // 男女比例
//    [postDic setObject:[self.majorAllIds componentsSeparatedByString:@","]?:@[] forKey:@"majorAllIds"]; // 一级专业id
//    [postDic setObject:[self.schoolProvinceIds componentsSeparatedByString:@","]?:@[] forKey:@"schoolProvinceIds"]; // 学校省份id
    postDic[@"batch"] = self.batch;
    postDic[@"pageNow"] = @(self.page);
    HUZWEAK_SELF
    [HUZNetWorkTool huz_POST:kUrl_Voluntary_IntelligentFirst_SchoolList parameters:postDic success:^(id  _Nonnull responseObject) {
        HUZSTRONG_SELF
        [strongSelf stopRefresh:strongSelf.tableView];
        NSString *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([codeStr integerValue] == 0) {
            if (strongSelf.page == 1) {
                [strongSelf.dataSource removeAllObjects];
            }
            NSArray *arr = [NSArray modelArrayWithClass:[HUZRecommendUniDataModel class] json:responseObject[@"data"][@"list"]];
            [strongSelf.dataSource addObjectsFromArray:arr];
//            [strongSelf configEmptyViewWithError:EMPTYDATA];
            
            if (arr.count == 0) {
                [strongSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            [strongSelf.tableView reloadData];
            
        }else{
            [strongSelf configEmptyViewWithError:responseObject[@"msg"]];
        }

    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        HUZSTRONG_SELF
        [strongSelf configEmptyViewWithError:error];
        [strongSelf stopRefresh:strongSelf.tableView];
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HUZAutoDetailTableViewCell *cell = [HUZAutoDetailTableViewCell cellWithTableView:tableView];
        cell.lab.text = titleArray[indexPath.row];
        [cell.btn setTitle:subtitleArray[indexPath.row] forState:UIControlStateNormal];
        
        if (indexPath.row == 2) {
            [cell.btn setImage:ImageNamed(@"ic_btn_dirom") forState:UIControlStateNormal];
        }else if (indexPath.row == 1) {
            if (self.batchName.length > 0) {
                [cell.btn setTitle:self.batchName forState:UIControlStateNormal];
            }
        }
        cell.btn.userInteractionEnabled = NO;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    else {
        HUZUniFitTableViewCell *cell = [HUZUniFitTableViewCell cellWithTableView:tableView];
        
        HUZRecommendUniDataModel *model = nil;
        if (indexPath.row < self.dataSource.count) {
            model = self.dataSource[indexPath.row];
        }
        
        cell.recommendModel = model;
        
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HUZWEAK_SELF
    if (indexPath.section == 0) {
        if (indexPath.row == 0) { // 我的高考信息
            
            HUZMyGkInfoViewController *gaokao = [HUZMyGkInfoViewController new];
            gaokao.updateBlock = ^{
                NSString *gkInfo =  HUZUserCenterManager.gkInfo;
                self->subtitleArray = @[gkInfo,self->_batchName,@"按偏好进行设置"];
                [weakSelf getVoluntaryTargetBatchData];
            };
            [self.navigationController pushViewController:gaokao animated:YES];
        }
        else if(indexPath.row == 2) {  // 意愿设置
            HUZVolunteerWishController *wish = [HUZVolunteerWishController new];
            
            wish.provinceIdsBlock = ^(NSString *provinceIds,NSString *  provinceNames) {
                
                HUZSTRONG_SELF
                strongSelf.schoolProvinceIds = provinceIds;
                strongSelf.schoolProvinceNames = provinceNames;
//                [strongSelf loadSchoolsData];
            };
            
            wish.menIdBlock = ^(NSString * _Nullable menId) {
                
                HUZSTRONG_SELF
                strongSelf.boyAndGirl = menId;
                //[strongSelf loadSchoolsData];

            };
            
            wish.majorIdsBlock = ^(NSString * _Nullable majorIds,NSString * _Nullable majorNames) {
                
                HUZSTRONG_SELF
                strongSelf.majorAllIds = majorIds;
                strongSelf.majorAllNames = majorNames;
//                [strongSelf loadSchoolsData];
                
            };
            
            wish.selectCharactersBlock = ^(NSString * _Nonnull charactersIds) {
                HUZSTRONG_SELF;
                strongSelf.charactersIds = charactersIds;
                
            };
            if (self.schoolProvinceIds.length > 0) {
                wish.schoolProvinceNames = self.schoolProvinceNames;
                wish.schoolProvinceIds = self.schoolProvinceIds;
            }
            if (self.majorAllIds.length > 0) {
                wish.majorEntitiesIds = self.majorAllIds;
                wish.majorEntitiesIdsNames = self.majorAllNames;
            }
            [self.navigationController pushViewController:wish animated:YES];
        }else{
            [self.selectSchoolBatchView show];
        }
    }
    else {  //
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return AutoDistance(58.0);
    }
    return AutoDistance(102.0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return AutoDistance(8.0);
    }
    return AutoDistance(36.);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    if (section == 0) {
        view.backgroundColor = self.tableView.backgroundColor;
        return view;
    }
    else {
        view.backgroundColor = COLOR_BG_WHITE;
        UILabel *lab = [[UILabel alloc]initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
        lab.frame = CGRectMake(AutoDistance(15), AutoDistance(10), AutoDistance(150), AutoDistance(21));
        lab.text = @"符合成绩的学校";
        [view addSubview:lab];
    }
    return view;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if (section == 0) {
//        return AutoDistance(20);
//    }
//    return AutoDistance(4);
//}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc]init];
//    view.backgroundColor = UIColor.redColor;//self.tableView.backgroundColor;
//    return view;
//}
#pragma mark -- HUZPPPSelectViewDelegate
- (void)pppSelectViewDelegateWith:(HUZPPPSelectView *)selectView indexPath:(NSIndexPath*)indexPAth result:(NSString *)result {
    self.batchName = result;
    HUZTargetBatchModel *batchModel = nil;
    
    if (self.batchDataModel.suitableBatch.count > indexPAth.row) {
        batchModel = self.batchDataModel.suitableBatch[indexPAth.row];
    }
    self.batch = batchModel.Id;
//    if ([batchModel.Id isEqualToString:@"4"]) {
//        self.batch = @"3";
//    }
    //self.batch = [NSString stringWithFormat:@"%zd",indexPAth.row + 1];
    [self onStartRefresh];
}

/// 生成志愿表
- (void)selectClick {
    NSInteger vipState = [HUZUserCenterManager.userModel.vip integerValue];
    
    if (vipState < 2) {
        HUZMyVipCardViewController *myVipCardVC = [HUZMyVipCardViewController new];
        [self.navigationController pushViewController:myVipCardVC animated:YES];
    }else{
        HUZUniAutoFillSchoolListVC *vol = [HUZUniAutoFillSchoolListVC new];
        vol.targetProvincesList = self.schoolProvinceIds;
        vol.targetMajorList = self.majorAllIds;
        vol.batch = self.batch;
        [self.navigationController pushViewController:vol animated:YES];
    }

}

- (HUZPPPSelectView *)selectSchoolBatchView{
    if (!_selectSchoolBatchView) {
        _selectSchoolBatchView = [HUZPPPSelectView new];
        _selectSchoolBatchView.headTitle = @"选择学校层次";
        _selectSchoolBatchView.delegate = self;
        _selectSchoolBatchView.tag = 2;
    }
    return _selectSchoolBatchView;
}

@end

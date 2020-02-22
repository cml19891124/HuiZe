//
//  HUZUniPriorityFillController.m
//  HuiZe
//
//  Created by mac on 2019/4/27.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZUniPriorityFillController.h"
#import "HUZVolunteerSelectController.h"
#import "HUZUniPriorityFillCell.h"
#import "HUZMyGkInfoViewController.h"
#import "HUZVolunteerService.h"
#import "HUZTargetBatchModel.h"

@interface HUZUniPriorityFillController ()<HUZPPPSelectViewDelegate>
@property (nonatomic,strong)HUZPPPSelectView *pppView;
@property (nonatomic,strong)NSMutableArray <HUZBatch*> *batchArr;
@property (nonatomic,strong)HUZBatchModel *batchModel;
//@property (nonatomic,strong)HUZBatch *batchSelected;
@property (nonatomic, copy) NSString * batch;
@property (nonatomic, copy) NSString * batchName;

@property (nonatomic, strong) HUZTargetBatchDataModel * batchDataModel;
@end
@implementation HUZUniPriorityFillController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"院校优先填报";

}

- (void)configComponents{
    [super configComponents];
    
    self.batchArr = [NSMutableArray array];
    self.batchModel = [HUZBatchModel new];
//    self.batchSelected = [[HUZBatch alloc]init];
    NSMutableArray *array = [NSMutableArray array];
    NSArray *imageArray = @[@"ic_uni_chong",@"ic_uni_wen",@"ic_uni_bao"];
    NSArray *titleArray = @[@"可冲击的大学",@"较稳妥的大学",@"可保底的大学"];
    NSArray *subtitleArray = @[@"大学录取的可能性低",@"大学录取的可能性较高",@"大学录取的可能性非常高"];
    NSArray *detailArray = @[@"0",@"0",@"0"];

    for (int i = 0; i < imageArray.count; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:imageArray[i] forKey:@"image"];
        [dic setValue:titleArray[i] forKey:@"title"];
        [dic setValue:subtitleArray[i] forKey:@"subtitle"];
        [dic setValue:detailArray[i] forKey:@"detailtitle"];
        [array addObject:dic];
    }
    self.dataSource = [array mutableCopy];
    self.tableView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    self.tableView.separatorColor = self.tableView.backgroundColor;
    [self.tableView dz_registerCell:[UITableViewCell class]];
    [self.tableView dz_registerCell:[HUZUniPriorityFillCell class]];

}

- (void)configDatas {
    [super configDatas];
    [self getVoluntaryTargetBatchData];
}

-(void)getVoluntaryTargetBatchData {
    //获取建议填报批次
    HUZWEAK_SELF;
    [self getVoluntaryTargetBatch:^(HUZTargetBatchDataModel * _Nonnull batchDataModel) {
        weakSelf.batchDataModel = batchDataModel;
        weakSelf.batch = batchDataModel.targetBatch.Id;
        weakSelf.batchName = batchDataModel.targetBatch.batchName;
        [self loadDatas];
    }];
}

- (void)loadDatas {
    HUZWEAK_SELF;
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setValue:self.batch forKey:@"batch"];

    [self displayOverFlowActivityView];
    [HUZVolunteerService getVolunteerPriorityApplicationWithParamters:postDic success:^(HUZVolunteerPriorityUni * _Nonnull volunteerPriorityUni) {
        [weakSelf removeOverFlowActivityView];
        NSArray *detailArray = @[volunteerPriorityUni.data.punching,volunteerPriorityUni.data.stable,volunteerPriorityUni.data.protect];
        for (int i = 0; i < weakSelf.dataSource.count; i++) {
            NSDictionary *dic = weakSelf.dataSource[i];
            [dic setValue:detailArray[i] forKey:@"detailtitle"];
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        [weakSelf removeOverFlowActivityView];
        [weakSelf presentErrorSheet:errorStr];

    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        cell.textLabel.text = indexPath.row == 0 ? @"我的高考信息" : @"批次";
        cell.textLabel.textColor = ColorS(COLOR_414141);
        cell.textLabel.font = FontS(FONT_17);
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, AutoDistance(175), AutoDistance(30))];
        [button setTitle:indexPath.row == 0 ? HUZUserCenterManager.gkInfo : self.batchName forState:UIControlStateNormal];
        button.titleLabel.font = FontS(FONT_15);
        [button setTitleColor:ColorS(COLOR_989898) forState:UIControlStateNormal];
        [button setImage:ImageNamed(@"ic_more_arrow") forState:UIControlStateNormal];
        CGFloat spacing = 4.0;
        CGSize imageSize = button.imageView.frame.size;
        button.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, 0.0, imageSize.width + spacing);
        CGSize titleSize = button.titleLabel.frame.size;
        button.imageEdgeInsets = UIEdgeInsetsMake(0.0, titleSize.width + spacing, 0.0, - titleSize.width);
        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        button.userInteractionEnabled = NO;
        cell.accessoryView = button;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else {
        HUZUniPriorityFillCell *cell = [HUZUniPriorityFillCell cellWithTableView:tableView];
        [cell setDic:self.dataSource[indexPath.section - 1]];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            HUZMyGkInfoViewController *gaokao = [HUZMyGkInfoViewController new];
            HUZWEAK_SELF;
            gaokao.updateBlock = ^{
                [weakSelf getVoluntaryTargetBatchData];
            };
            [self.navigationController pushViewController:gaokao animated:YES];
        }
        else if (indexPath.row == 1) {
            NSMutableArray *batchArr = @[].mutableCopy;
            for (HUZTargetBatchModel *model in self.batchDataModel.suitableBatch) {
                [batchArr addObject:model.batchName];
            }
            self.pppView.dataArray = batchArr.copy;
            // 批次选择
            [self.pppView show];
        }
    }
    else {
        HUZVolunteerSelectController *uniSel = [HUZVolunteerSelectController new];
        uniSel.isMajorPriority = NO;
        uniSel.batchId = self.batch;
        uniSel.volType = indexPath.section - 1;
        [self.navigationController pushViewController:uniSel animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return AutoDistance(58.0);
    }
    return AutoDistance(77.0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return AutoDistance(8.0);
    }
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = self.tableView.backgroundColor;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return AutoDistance(20);
    }
    return AutoDistance(4);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = self.tableView.backgroundColor;
    return view;
}

#pragma mark - HUZPPPSelectViewDelegate
- (void)pppSelectViewDelegateWith:(HUZPPPSelectView *)selectView indexPath:(NSIndexPath*)indexPAth result:(NSString *)result {
    
    HUZTargetBatchModel *batchModel = nil;
    if (self.batchDataModel.suitableBatch.count > indexPAth.row) {
        batchModel = self.batchDataModel.suitableBatch[indexPAth.row];
    }
    
    NSLog(@"%@", result);
//    self.batchSelected = self.batchArr[indexPAth.row];
    self.batchName = batchModel.batchName;
    self.batch = batchModel.Id;
//    HUZLOG(@"id: %@, batchName: %@", self.batchSelected.ID, self.batchSelected.batchName);
    [self loadDatas];
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

//- (void)getBatchList {
//    HUZWEAK_SELF
//    [self displayOverFlowActivityView];
//    [HUZVolunteerService getBatchListSuccess:^(HUZBatchModel * _Nonnull batch) {
//        [weakSelf removeOverFlowActivityView];
//        weakSelf.batchModel = batch;
//        weakSelf.batchSelected = batch.data.firstObject;
//        [weakSelf.tableView reloadData];
//        [weakSelf loadDatas];
//
//    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
//        [weakSelf removeOverFlowActivityView];
//        [weakSelf presentErrorSheet:errorStr];
//    }];
//}

- (NSMutableArray *)filterBatchListWith:(HUZBatchModel *)batchModel {
    NSMutableArray *arr = [NSMutableArray array];
    for (HUZBatch *batch in batchModel.data) {
        [self.batchArr addObject:batch];
        [arr addObject:batch.batchName];
    }
    return arr;
}
@end

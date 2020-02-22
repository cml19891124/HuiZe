//
//  HUZMajorPriorityController.m
//  HuiZe
//
//  Created by mac on 2019/5/5.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZMajorPriorityController.h"
#import "HUZSearchNavView.h"
#import "HUZMajorAddCell.h"
#import "HUZPPPSelectView.h"
#import "HUZVolunteerBottomView.h"
#import "HUZMajorCategoryViewController.h"
#import "HUZMajorMatchUniController.h"
#import "HUZMajorMatchCellCell.h"
#import "HUZMyGkInfoViewController.h"
#import "HUZVolunteerService.h"
#import "HUZMajorListModel.h"
#import "HUZSearchViewController.h"
#import "HUZSearchMajorModel.h"
#import "HUZTargetBatchModel.h"
@interface HUZMajorPriorityController ()<HUZPPPSelectViewDelegate, KSSideslipCellDelegate,UITextFieldDelegate>
@property (strong, nonatomic) UIView *headView;
@property (strong, nonatomic) HUZSearchNavView *searchView;
@property (nonatomic,strong) HUZVolunteerBottomView *viewBotm;
@property (nonatomic,strong) NSMutableArray *majorArr;
@property (nonatomic,strong) NSMutableArray *majorListArr;
@property (nonatomic) NSIndexPath *indexPath;
@property (nonatomic,strong)HUZPPPSelectView *pppView;
@property (nonatomic,strong)NSMutableArray <HUZBatch*> *batchArr;
//@property (nonatomic,strong)HUZBatchModel *batchModel;
//@property (nonatomic,strong)HUZBatch *batchSelected;

@property (nonatomic, copy) NSString * batch;
@property (nonatomic, copy) NSString * batchName;
@property (nonatomic, strong) HUZTargetBatchDataModel * batchDataModel;
@end

@implementation HUZMajorPriorityController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"按专业选学校";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addMajorAction:) name:@"HUZSearchMajorResultViewController_post_key" object:nil];
}
-(void)addMajorAction:(NSNotification *)noti {
    self.searchView.tfKeyword.text = @"";
    HUZSearchMajorDataListModel *majorModel = noti.object;
    HUZMajorListModel *model = [HUZMajorListModel new];
    model.content = majorModel.category;
    model.majorId = majorModel.majorId;
    
    for (NSInteger i = 0; i<self.majorListArr.count; i++) {
        id obj = self.majorListArr[i];
        if (![obj isKindOfClass:[HUZMajorListModel class]]) {
            [self.majorArr replaceObjectAtIndex:i withObject:model.content];
            [self.majorListArr replaceObjectAtIndex:i withObject:model];
            ;
            if ([self isSelectMajor]) {
                self.viewBotm.viewBotm.backgroundColor = ColorS(COLOR_2E86FF);
                self.viewBotm.btnSelected.enabled = YES;
            }
            [self.tableView reloadData];
            return;
        }
    }
}

- (void)configComponents{
    [super configComponents];
   
    self.batchArr = [NSMutableArray array];
//    self.batchModel = [HUZBatchModel new];
//    self.batchSelected = [[HUZBatch alloc]init];
    self.dataSource = [@[@[@"1", @"1"], @[@"1", @"1", @"1", @"1", @"1", @"1"]] mutableCopy];
    self.majorArr = @[@"", @"", @"", @"", @"", @""].mutableCopy;
    self.majorListArr = @[@"", @"", @"", @"", @"", @""].mutableCopy;
    self.shouldMultiSections = YES;
    self.tableView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView dz_registerCell:[UITableViewCell class]];
    [self.tableView dz_registerCell:[HUZMajorAddCell class]];
    [self.tableView dz_registerCell:[HUZMajorMatchCellCell class]];
    
    self.viewBotm = [[HUZVolunteerBottomView alloc]initWithFrame:CGRectMake(0, HUZSCREEN_HEIGHT - HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT - AutoDistance(49), HUZSCREEN_WIDTH, AutoDistance(49))];
    self.viewBotm.viewBotm.backgroundColor = ColorS(COLOR_989898);
    [self.viewBotm.btnSelected setTitleColor:COLOR_BG_WHITE forState:UIControlStateNormal];
    [self.viewBotm.btnSelected setTitle:@"按专业查找学校" forState:UIControlStateNormal];
    self.viewBotm.btnSelected.enabled = NO;
    [self.viewBotm.btnSelected addTarget:self action:@selector(majorCheck) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.viewBotm];
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
        self.batch = batchDataModel.targetBatch.Id;
        self.batchName = batchDataModel.targetBatch.batchName;
        NSMutableArray *batchArr = @[].mutableCopy;
        for (HUZTargetBatchModel *model in batchDataModel.suitableBatch) {
            [batchArr addObject:model.batchName];
        }
        self.pppView.dataArray = batchArr.copy;
        [self.tableView reloadData];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        cell.textLabel.text = indexPath.row == 0 ? @"我的高考信息" : @"建议填报批次";
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
        if (self.majorArr.count > 0 ) { // 显示专业cell
            NSString *major = self.majorArr[indexPath.row];
            if (major.length > 0) { // 显示专业cell
                HUZMajorMatchCellCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HUZMajorMatchCellCell" forIndexPath:indexPath];
                cell.textLabel.text = major;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.delegate = self;
                return cell;
            }
        }
        HUZMajorAddCell *cell = [HUZMajorAddCell cellWithTableView:tableView];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HUZWEAK_SELF
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            HUZMyGkInfoViewController *gaokao = [HUZMyGkInfoViewController new];
            [self.navigationController pushViewController:gaokao animated:YES];
        }
        else if (indexPath.row == 1) {
            // 批次选择
            [self.pppView show];
        }
    }
    else { // 添加专业
        HUZMajorCategoryViewController *add = [HUZMajorCategoryViewController new];
        add.selectBlock = ^(HUZMajorListModel * _Nonnull model) {
            HUZSTRONG_SELF
            [strongSelf.majorArr replaceObjectAtIndex:indexPath.row withObject:model.content];
            [strongSelf.majorListArr replaceObjectAtIndex:indexPath.row withObject:model];
            if ([strongSelf isSelectMajor]) {
                self.viewBotm.viewBotm.backgroundColor = ColorS(COLOR_2E86FF);
                self.viewBotm.btnSelected.enabled = YES;
            }
            [self.tableView reloadData];
        };
        if ([self.batch isEqualToString:@"4"]) {
            add.category = @"1";
        }else{
            add.category = @"2";
        }
        
        [self.navigationController pushViewController:add animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return AutoDistance(58.0);
    }
    return AutoDistance(45);
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
    
    self.batchName = result;
    self.batch = batchModel.Id;
    self.majorArr = @[@"", @"", @"", @"", @"", @""].mutableCopy;
    self.majorListArr = @[@"", @"", @"", @"", @"", @""].mutableCopy;
    
    self.viewBotm.viewBotm.backgroundColor = ColorS(COLOR_989898);
    self.viewBotm.btnSelected.enabled = NO;
    
    [self.tableView reloadData];
}

- (UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(44))];
        _headView.backgroundColor = COLOR_BG_WHITE;
        HUZSearchNavView *searchView = [[HUZSearchNavView alloc]initWithFrame:CGRectMake(AutoDistance(15), AutoDistance(7), HUZSCREEN_WIDTH - 2 * AutoDistance(15), AutoDistance(30))];
        searchView.tfKeyword.placeholder = @"搜索专业";
        self.searchView = searchView;
        self.searchView.tfKeyword.returnKeyType = UIReturnKeySearch;
        self.searchView.tfKeyword.delegate = self;
        [_headView addSubview:searchView];
        
    }
    return _headView;
}

/// 按专业查找学校
- (void)majorCheck {
    HUZWEAK_SELF
    [self displayOverFlowActivityView];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (HUZMajorListModel *model in self.majorListArr) {
        if (![model isKindOfClass:[HUZMajorListModel class]]) {
            continue;
        }
        if (DRStringIsNotEmpty(model.majorId)) {
            [array addObject:model.majorId];
        }
    }
    NSMutableDictionary *postDict = [NSMutableDictionary dictionary];
    [postDict setValue:self.batch forKey:@"batch"]; // 批次
    [postDict setValue:array forKey:@"majorAllIds"]; // 专业ID数组
    HUZLOG(@"按专业查找学校 postDict:%@", postDict);
    [HUZVolunteerService getMajorUniversityWithParamters:postDict success:^(HUZMajorPriorityDataModel * _Nonnull dataModel) {
        [weakSelf removeOverFlowActivityView];
        HUZMajorMatchUniController *match = [HUZMajorMatchUniController new];
        match.batch = self.batch;
        match.dataModel = dataModel;
        match.majorAllIdsArr = array;
        [weakSelf.navigationController pushViewController:match animated:YES];
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        [weakSelf removeOverFlowActivityView];
        [weakSelf presentErrorSheet:errorStr];
    }];
}

#pragma mark - KSSideslipCellDelegate
- (NSArray<KSSideslipCellAction *> *)sideslipCell:(KSSideslipCell *)sideslipCell editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KSSideslipCellAction *action = [KSSideslipCellAction rowActionWithStyle:KSSideslipCellActionStyleDestructive title:@"删除" handler:^(KSSideslipCellAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"点击删除");
    }];
    NSArray *array = @[action];
    return array;
}

- (BOOL)sideslipCell:(KSSideslipCell *)sideslipCell canSideslipRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UIView *)sideslipCell:(KSSideslipCell *)sideslipCell rowAtIndexPath:(NSIndexPath *)indexPath didSelectedAtIndex:(NSInteger)index {
    self.indexPath = indexPath;
    UIButton * view =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 135, 0)];
    view.titleLabel.textAlignment = NSTextAlignmentCenter;
    view.titleLabel.font = [UIFont systemFontOfSize:17];
    [view setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [view setTitle:@"确认删除" forState:UIControlStateNormal];
    view.backgroundColor = [UIColor redColor];
    [view addTarget:self action:@selector(delBtnClick) forControlEvents:UIControlEventTouchUpInside];
    return view;
}

- (void)delBtnClick {
    [self.majorArr replaceObjectAtIndex:self.indexPath.row withObject:@""];
    if ([self isSelectMajor]) {
        self.viewBotm.viewBotm.backgroundColor = ColorS(COLOR_2E86FF);
        self.viewBotm.btnSelected.enabled = YES;
    }
    else {
        self.viewBotm.viewBotm.backgroundColor = ColorS(COLOR_989898);
        self.viewBotm.btnSelected.enabled = NO;
    }
    [self.tableView reloadData];
}

- (BOOL)isSelectMajor {
    __block BOOL isSelect = NO;
    [self.majorArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *str = (NSString *)obj;
        if (str.length > 0) {
            isSelect = YES;
            *stop = YES;
        }
    }];
    return isSelect;
}

- (HUZPPPSelectView *)pppView {
    if (!_pppView) {
        _pppView = [HUZPPPSelectView new];
        _pppView.headTitle = @"选择批次";
//        _pppView.dataArray =  [self filterBatchListWith:self.batchModel];
        _pppView.delegate = self;
//        [self.view addSubview:_pppView];
    }
    return _pppView;
}


- (NSMutableArray *)filterBatchListWith:(HUZBatchModel *)batchModel {
    NSMutableArray *arr = [NSMutableArray array];
    for (HUZBatch *batch in batchModel.data) {
        [self.batchArr addObject:batch];
        [arr addObject:batch.batchName];
    }
    return arr;
}
#pragma mark --UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.searchView.tfKeyword resignFirstResponder];
    HUZSearchViewController *searchVC = [HUZSearchViewController new];
    searchVC.isGotoMajor = YES;
    [searchVC clickKeywordSearch:textField.text];
    [self.navigationController pushViewController:searchVC animated:YES];
    return YES;
}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

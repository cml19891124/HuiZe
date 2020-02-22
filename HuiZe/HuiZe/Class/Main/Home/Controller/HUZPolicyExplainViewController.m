
//
//  HUZPolicyExplainViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/27.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZPolicyExplainViewController.h"
#import "HUZPolicyExplainCell.h"
#import "FORScrollViewEmptyAssistant.h"
#import "HUZChooseTypeView.h"
#import "HUZGkInfoModel.h"
#import "HUZLoginService.h"
#import "HUZAgreementViewController.h"
//#import "HUZProvinceModel.h"
#import "HUZGkInfoListCell.h"
#import "HUZNewGkSubjectModel.h"
@interface HUZPolicyExplainViewController ()<HUZPPPSelectViewDelegate>

@property (nonatomic,strong) NSString *provinceId;  /// 省份id

@property (nonatomic,strong) HUZChooseTypeView *chooseProvinceView;
@property (nonatomic,strong) HUZPPPSelectView *selectProvinceView;
@property (nonatomic,strong) HUZProvinceModel *provinceModel;

@end

@implementation HUZPolicyExplainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    self.navigationItem.title = @"政策解读";
}

- (void)configComponents{
    [super configComponents];
    self.cellHeight = AutoDistance(110);
    [self.tableView dz_registerCell:[HUZGkInfoListCell class]];
    [self.view addSubview:self.chooseProvinceView];

    self.shouldMultiSections = YES;
    [self.tableView dz_registerCell:[HUZPolicyExplainCell class]];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(52));
        make.left.bottom.right.equalTo(self.view);
    }];
    
    HUZWEAK_SELF
    self.tableView.mj_header = [HUZRefreshHeader headerWithRefreshingBlock:^{
        HUZSTRONG_SELF
        strongSelf.page = 1;
        [strongSelf getPolicyList];
    }];
    self.tableView.mj_footer = [HUZRefreshFooter footerWithRefreshingBlock:^{
        HUZSTRONG_SELF
        strongSelf.page ++;
        [strongSelf getPolicyList];
    }];
    [self.tableView.mj_header beginRefreshing];
}
/*
/// 获取省份
- (void)configDatas{
    [super configDatas];
    
    [self displayOverFlowActivityView];
    HUZWEAK_SELF
    [HUZLoginService getProvinceSuccess:^(HUZProvinceModel * _Nonnull object) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        strongSelf.provinceModel = [HUZProvinceModel new];
        strongSelf.provinceModel = object;
        HUZProvince *province = DRArrayIsEmpty(object.data) ? nil : object.data[0];
        strongSelf.chooseProvinceView.labContent.text = province.title;
        strongSelf.provinceId = province.Id;
        [strongSelf getPolicyList];
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        [strongSelf presentErrorSheet:errorStr];
    }];
}
*/
/// 政策解读列表
- (void)getPolicyList{
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    par[@"pageNow"] = @(self.page);
    par[@"pageSize"] = @(self.size);
    par[@"province"] = self.subjectModel.provinceId;
    par[@"type"] = @"4";
    HUZWEAK_SELF
    [self displayOverFlowActivityView];
    [HUZNetWorkTool huz_POST:KUrl_PolicyList parameters:par success:^(id  _Nonnull responseObject) {
    HUZSTRONG_SELF
        [self stopRefresh:self.tableView];
        NSString *code = [responseObject valueForKey:@"code"];
        if ([code integerValue] == 0) {
            [self removeOverFlowActivityView];
            if (self.page==1) {
                [self.dataSource removeAllObjects];
            }
            NSArray *arr = [NSArray modelArrayWithClass:[HUZGkInfoDataListModel class] json:responseObject[@"data"][@"list"]];
            [self.dataSource addObjectsFromArray:arr];
            [self.tableView reloadData];
        }else{
            NSString *msg = responseObject[@"msg"];
            [self presentErrorSheet:msg];
        }
        [strongSelf configEmptyViewWithError:EMPTYDATA];

    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        HUZSTRONG_SELF
        [strongSelf configEmptyViewWithError:EMPTYDATA];
        [strongSelf.tableView.mj_header endRefreshing];
        [strongSelf.tableView.mj_footer endRefreshing];
        [strongSelf.tableView reloadData];
    }];
    
}

#pragma mark HUZPPPSelectViewDelegate
- (void)pppSelectViewDelegateWith:(HUZPPPSelectView *)selectView indexPath:(NSIndexPath*)indexPAth result:(NSString *)result{
    return;
    self.chooseProvinceView.labContent.text = result;
    HUZProvince *province = self.provinceModel.data[indexPAth.row];
    self.provinceId = province.Id;
    [self getPolicyList];
}

#pragma mark - tableView
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return [HUZPolicyExplainCell calculateHeightWithEntity:self.dataSource[indexPath.section]];
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HUZGkInfoListCell *cell = [HUZGkInfoListCell cellWithTableView:tableView];
    [cell reloadData:self.dataSource[indexPath.section]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AutoDistance(8);
}

//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    return [UIView new];
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HUZGkInfoDataListModel *model = nil;
    if (indexPath.section < self.dataSource.count) {
        model = self.dataSource[indexPath.section];
    }
    if (model.jumpUrl.length == 0) {
        [self presentErrorSheet:@"跳转连接为空"];
        return;
    }
    HUZAgreementViewController *agreementVC = [[HUZAgreementViewController alloc] init];

    agreementVC.url = model.jumpUrl;
    [self.navigationController pushViewController:agreementVC animated:true];
}
#pragma mark - Lazy
- (HUZChooseTypeView *)chooseProvinceView{
    if (!_chooseProvinceView) {
        _chooseProvinceView = [[HUZChooseTypeView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(44))];
        _chooseProvinceView.ivSelect.hidden = YES;
        _chooseProvinceView.labContent.text = self.subjectModel.provinceName;
//        HUZWEAK_SELF
//        [_chooseProvinceView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
//            HUZSTRONG_SELF
//            [strongSelf.selectProvinceView show];
//        }];
    }
    return _chooseProvinceView;
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
        _selectProvinceView.tag = 1;
        [self.view addSubview:_selectProvinceView];
    }
    return _selectProvinceView;
}

@end


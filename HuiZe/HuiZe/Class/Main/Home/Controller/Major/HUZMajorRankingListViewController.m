//
//  HUZMajorRankingListViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/29.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZMajorRankingListViewController.h"
#import "HUZMajorRankingListHeaderView.h"
#import "HUZMajorRankingListCell.h"

#import "HUZUniInfoGeneralizeModel.h"
#import "HUZMajorRankingModel.h"
#import "HUZUniInfoViewController.h"
@interface HUZMajorRankingListViewController ()<HUZPPPSelectViewDelegate>
@property (nonatomic,strong) HUZPPPSelectView *selectBatchView;
@end

@implementation HUZMajorRankingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.navTitle;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.title = @"";
}

- (void)configComponents{
    [super configComponents];
    
//    self.dataSource = [@[@"1",@"1",@"1",@"1",@"1"] mutableCopy];
    self.cellHeight = AutoDistance(83);
    [self.tableView dz_registerCell:[HUZMajorRankingListCell class]];
    [self getMajorRankData];
}

-(void)getMajorRankData {
    NSString *url = [NSString stringWithFormat:@"%@%@",kUrl_Assess_Result,self.assessMajorId];
    [HUZNetWorkTool huz_GET:url parameters:nil success:^(id  _Nonnull responseObject) {
        NSString *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([codeStr integerValue] == 0) {
            [self.dataSource removeAllObjects];
            NSArray *arr = [NSArray modelArrayWithClass:[HUZMajorRankingModel class] json:responseObject[@"data"]];
            [self.dataSource addObjectsFromArray:arr];
            [self.tableView reloadData];
        }else{
            [self presentErrorSheet:responseObject[@"msg"]];
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        [self presentErrorSheet:error];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    HUZMajorRankingModel *rankingModel = nil;
    if (self.dataSource.count > indexPath.row) {
        rankingModel = self.dataSource[indexPath.row];
    }
    
    
    
    HUZMajorRankingListCell * cell = [HUZMajorRankingListCell cellWithTableView:tableView];
    cell.indexPath = indexPath;
    cell.rankingModel = rankingModel;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HUZMajorRankingModel *rankingModel = nil;
    if (self.dataSource.count > indexPath.row) {
        rankingModel = self.dataSource[indexPath.row];
    }
    
    HUZUniInfoViewController *unVC = [[HUZUniInfoViewController alloc] init];
    unVC.schoolId = rankingModel.schoolId;
    [self.navigationController pushViewController:unVC animated:true];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    HUZMajorRankingListCell *uniRankingListCell = (HUZMajorRankingListCell *)cell;
    
    [uniRankingListCell reloadData:nil indexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

#pragma mark --- action

#pragma mark --- action end

-(HUZPPPSelectView *)selectBatchView {
    if (!_selectBatchView) {
        _selectBatchView = [HUZPPPSelectView new];
        _selectBatchView.headTitle = @"选择学校类别";
        _selectBatchView.delegate = self;
        _selectBatchView.dataArray = HUZDataBaseManager.dataBatch.mutableCopy;
        _selectBatchView.tag = 11000;
        [self.view addSubview:_selectBatchView];
    }
    return _selectBatchView;
}
//@"本科批",@"本科一批",@"本科二批",@"本科三批",@"专科批",@"平行录取一段",@"平行录取二段",@"平行录取三段",@"本科提前批",@"国家专项计划本科批"
//0本科批， 1本科一批，2本科二批，3本科三批，4专科批，5平行录取一段，6平行录取二段，7平行录取三段，8本科提前批 ，9国家专项计划本科批 ,
#pragma mark -- HUZPPPSelectViewDelegate
- (void)pppSelectViewDelegateWith:(HUZPPPSelectView *)selectView indexPath:(NSIndexPath*)indexPAth result:(NSString *)result {
    [self onStartRefresh];
}
#pragma mark -- HUZPPPSelectViewDelegate end
@end

//
//  HUZRecommendMajorViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/14.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZRecommendMajorViewController.h"
#import "HUZSearchMajorLikeCell.h"
#import "HUZRecommendUniListSectionView.h"
#import "HUZUlikeMajorModel.h"
#import "HUZMajorInfoViewController.h"
#import "HUZTargetBatchModel.h"
@interface HUZRecommendMajorViewController ()<HUZPPPSelectViewDelegate>{
    NSString *_batch;   /// 批次 0本科批 1专科批
    
    NSString *_batchStr;
}
@property (nonatomic,strong) HUZPPPSelectView *selectBatchView;

@property (nonatomic,strong) NSMutableArray *dataBatch;

@end

@implementation HUZRecommendMajorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ColorS(COLOR_BG_F6F6F6);

}

- (void)configComponents{
    [super configComponents];
    
    [self reset];
    
    self.cellHeight = AutoDistance(110);
    [self.tableView dz_registerCell:[HUZSearchMajorLikeCell class]];
    
    HUZWEAK_SELF
    self.tableView.mj_header = [HUZRefreshHeader headerWithRefreshingBlock:^{
        HUZSTRONG_SELF
        strongSelf.page = 1;
        [strongSelf loadRecommendMajorList];
    }];
    self.tableView.mj_footer = [HUZRefreshFooter footerWithRefreshingBlock:^{
        HUZSTRONG_SELF
        strongSelf.page ++;
        [strongSelf loadRecommendMajorList];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    
//    [self loadJudgeBatch];
}

-(void)setBatchDataModel:(HUZTargetBatchDataModel *)batchDataModel {
    _batchDataModel = batchDataModel;
    NSMutableArray *batchArr = @[].mutableCopy;
    for (HUZTargetBatchModel *model in self.batchDataModel.suitableBatch) {
        [batchArr addObject:model.batchName];
    }
    self.selectBatchView.dataArray = batchArr.copy;
    [self reset];
}

- (void)reset{
    _batch = self.batchDataModel.targetBatch.Id;
    _batchStr = self.batchDataModel.targetBatch.batchName;
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark NETWork
/// 推荐专业集合
- (void)loadRecommendMajorList{
    HUZWEAK_SELF
    [HUZHomeService getRecommendMajorList:@{@"pageNow":@(self.page),@"pageSize":@(self.size),@"batch":_batch} success:^(HUZUlikeMajorModel * _Nonnull model) {
        HUZSTRONG_SELF
        if (strongSelf.page == 1) {
            [strongSelf.dataSource removeAllObjects];
        }
        [strongSelf.dataSource addObjectsFromArray:model.data.list];
        [strongSelf configEmptyViewWithError:EMPTYDATA];
        [strongSelf.tableView.mj_header endRefreshing];
        [strongSelf.tableView.mj_footer endRefreshing];
        [strongSelf.tableView reloadData];
        if (strongSelf.page >= model.data.totalPage) {
            [strongSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf configEmptyViewWithError:errorStr];
        [strongSelf.tableView.mj_header endRefreshing];
        [strongSelf.tableView.mj_footer endRefreshing];
        [strongSelf.tableView reloadData];
    }];
}

/// 获取批次
- (void)loadJudgeBatch{
    HUZWEAK_SELF
    [HUZHomeService getBatch:@{} success:^(HUZJudgeBatchModel * _Nonnull model) {
        HUZSTRONG_SELF
        [strongSelf.dataBatch addObjectsFromArray:model.data];
        NSArray *batchArray = [strongSelf.dataBatch jk_map:^id(HUZJudgeBatchDataModel *object) {
            return object.batchName;
        }];
        strongSelf.selectBatchView.dataArray = batchArray.mutableCopy;
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        
    }];
}

- (void)pppSelectViewDelegateWith:(HUZPPPSelectView *)selectView indexPath:(NSIndexPath*)indexPAth result:(NSString *)result{
    /// 选择批次
    if (selectView.tag == 1) {
        HUZTargetBatchModel *batchModel = self.batchDataModel.suitableBatch[indexPAth.row];
        _batchStr = batchModel.batchName;
        //HUZJudgeBatchDataModel *model = self.dataBatch[indexPAth.row];
        _batch = batchModel.Id;
    }
    
    [self loadRecommendMajorList];
}

#pragma mark tableView
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    return [HUZSearchMajorLikeCell cellWithTableView:tableView];
}

- (void)configureCell:(HUZSearchMajorLikeCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    [cell reloadData:object];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AutoDistance(40);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HUZRecommendUniListSectionView *sectionView = [[HUZRecommendUniListSectionView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(40))];
    sectionView.btnType.hidden = YES;
    [sectionView.btnBatch addTarget:self action:@selector(clickBatch) forControlEvents:UIControlEventTouchUpInside];
    sectionView.batch = _batchStr;
    return sectionView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HUZUlikeMajorDataListModel *model = nil;
    if (self.dataSource.count > indexPath.row) {
        model = self.dataSource[indexPath.row];
    }
    HUZMajorInfoViewController *VC = [[HUZMajorInfoViewController alloc] init];
    VC.majorId = model.majorAllId;
    [self.navigationController pushViewController:VC animated:true];
}
- (void)clickBatch{
    [self.selectBatchView show];
}

#pragma mark Lazy
- (HUZPPPSelectView *)selectBatchView{
    if (!_selectBatchView) {
        _selectBatchView = [HUZPPPSelectView new];
        _selectBatchView.headTitle = @"选择批次";
        _selectBatchView.delegate = self;
        _selectBatchView.tag = 1;
    }
    return _selectBatchView;
}

- (NSMutableArray *)dataBatch{
    if (!_dataBatch) {
        _dataBatch = [NSMutableArray new];
    }
    return _dataBatch;
}

@end

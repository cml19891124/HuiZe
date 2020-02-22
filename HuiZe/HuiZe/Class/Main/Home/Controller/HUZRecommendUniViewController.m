//
//  HUZRecommendUniViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/14.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZRecommendUniViewController.h"
#import "HUZHistoryStudentsPlanCell.h"
#import "HUZRecommendUniListSectionView.h"
#import "HUZRecommendUniModel.h"
#import "HUZUniInfoViewController.h"
#import "HUZTargetBatchModel.h"
@interface HUZRecommendUniViewController ()<HUZPPPSelectViewDelegate>{
    NSString *_batch;   /// 批次 0本科批 1专科批
    NSString *_type;    /// 冲稳保类型 (冲1,稳2,保3)
    
    NSString *_batchStr;
    NSString *_typeStr;
}

@property (nonatomic,strong) HUZPPPSelectView *selectBatchView;
@property (nonatomic,strong) HUZPPPSelectView *selectSchoolBatchView;
@property (nonatomic,strong) HUZRecommendUniListSectionView *sectionView;

@property (nonatomic,strong) NSMutableArray *dataBatch;

@end

@implementation HUZRecommendUniViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ColorS(COLOR_BG_F6F6F6);
}

-(void)setBatchDataModel:(HUZTargetBatchDataModel *)batchDataModel {
    _batchDataModel = batchDataModel;
    
    NSMutableArray *batchArr = @[].mutableCopy;
    for (HUZTargetBatchModel *model in self.batchDataModel.suitableBatch) {
        [batchArr addObject:model.batchName];
    }
    self.selectBatchView.dataArray = batchArr.copy;
    // 批次选择
    
    [self reset];
}

- (void)configComponents{
    [super configComponents];
    
    self.cellHeight = AutoDistance(110);
    [self.tableView dz_registerCell:[HUZHistoryStudentsPlanCell class]];
    
    HUZWEAK_SELF
    self.tableView.mj_header = [HUZRefreshHeader headerWithRefreshingBlock:^{
        HUZSTRONG_SELF
        strongSelf.page = 1;
        [strongSelf loadRecommendUniList];
    }];
    self.tableView.mj_footer = [HUZRefreshFooter footerWithRefreshingBlock:^{
       HUZSTRONG_SELF
        strongSelf.page ++;
        [strongSelf loadRecommendUniList];
    }];
//    [self.tableView.mj_header beginRefreshing];
    
//    [self loadJudgeBatch];
//    [self reset];
}

/// 默认排序
- (void)reset{
    _batch = self.batchDataModel.targetBatch.Id;
    _type = @"";

    _batchStr = self.batchDataModel.targetBatch.batchName;
    _typeStr = @"学校层次";
    
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark NETWork
/// 推荐院校集合
- (void)loadRecommendUniList{
    
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    par[@"batch"] = _batch;
    par[@"pageNow"] = @(self.page);
    
    HUZWEAK_SELF
    [HUZNetWorkTool huz_POST:kUrl_Voluntary_IntelligentFirst_SchoolList parameters:par success:^(id  _Nonnull responseObject) {
        HUZSTRONG_SELF
        [strongSelf stopRefresh:strongSelf.tableView];
        NSString *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([codeStr integerValue] == 0) {
            if (strongSelf.page == 1) {
                [strongSelf.dataSource removeAllObjects];
            }
            NSArray *arr = [NSArray modelArrayWithClass:[HUZRecommendUniDataModel class] json:responseObject[@"data"][@"list"]];
            [strongSelf.dataSource addObjectsFromArray:arr];
            [strongSelf configEmptyViewWithError:EMPTYDATA];
            [strongSelf.tableView reloadData];
            if (arr.count == 0) {
                [strongSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
        }else{
            [strongSelf configEmptyViewWithError:responseObject[@"msg"]];
        }

    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        HUZSTRONG_SELF
        [strongSelf configEmptyViewWithError:error];
        [strongSelf stopRefresh:strongSelf.tableView];
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

#pragma mark tableView
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    return [HUZHistoryStudentsPlanCell cellWithTableView:tableView];
}

- (void)configureCell:(HUZHistoryStudentsPlanCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    [cell reloadData:object];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AutoDistance(40);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HUZRecommendUniDataModel *dataModel = nil;
    if (self.dataSource.count > indexPath.row) {
        dataModel = self.dataSource[indexPath.row];
    }
    HUZUniInfoViewController *uniInfoVC = [HUZUniInfoViewController new];
    uniInfoVC.schoolId = dataModel.schoolId;
    [self.navigationController pushViewController:uniInfoVC animated:true];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HUZRecommendUniListSectionView *sectionView = [[HUZRecommendUniListSectionView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(40))];
    [sectionView.btnBatch addTarget:self action:@selector(clickBatch) forControlEvents:UIControlEventTouchUpInside];
    [sectionView.btnType addTarget:self action:@selector(clickSchoolBatch) forControlEvents:UIControlEventTouchUpInside];
    sectionView.batch = _batchStr;
    sectionView.type = _typeStr;
    sectionView.btnType.hidden = YES;
    self.sectionView = sectionView;
    return self.sectionView;
}

- (void)pppSelectViewDelegateWith:(HUZPPPSelectView *)selectView indexPath:(NSIndexPath*)indexPAth result:(NSString *)result{
    
    /// 选择批次
    if (selectView.tag == 1) {
        HUZTargetBatchModel *batchModel = self.batchDataModel.suitableBatch[indexPAth.row];
        _batchStr = batchModel.batchName;
//        HUZJudgeBatchDataModel *model = self.dataBatch[indexPAth.row];
        _batch = batchModel.Id;
    }
    
    /// 选择学校层次
    else if (selectView.tag == 2){
        _typeStr = result;
        _type = [NSString stringWithFormat:@"%d",(int)indexPAth.row + 1];
    }
    
    [self loadRecommendUniList];
}

- (void)clickBatch{
    [self.selectBatchView show];
}

- (void)clickSchoolBatch{
    [self.selectSchoolBatchView show];
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

- (HUZPPPSelectView *)selectSchoolBatchView{
    if (!_selectSchoolBatchView) {
        _selectSchoolBatchView = [HUZPPPSelectView new];
        _selectSchoolBatchView.headTitle = @"选择学校层次";
        _selectSchoolBatchView.dataArray = HUZDataBaseManager.dataSchoolBatch.mutableCopy;
        _selectSchoolBatchView.delegate = self;
        _selectSchoolBatchView.tag = 2;
    }
    return _selectSchoolBatchView;
}

- (NSMutableArray *)dataBatch{
    if (!_dataBatch) {
        _dataBatch = [NSMutableArray new];
    }
    return _dataBatch;
}
@end

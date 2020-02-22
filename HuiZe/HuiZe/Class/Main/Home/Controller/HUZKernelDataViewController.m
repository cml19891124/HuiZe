//
//  HUZKernelDataViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/22.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZKernelDataViewController.h"
#import "HUZKernelDataView.h"
#import "HUZDroplineTableView.h"
#import "HUZMyGkInfoViewController.h"
@interface HUZKernelDataViewController ()<HUZPPPSelectViewDelegate>
{
    NSString *_scoreSectionYear;  /// 一分一段年份
    NSString *_scoreLineYear;     /// 分数线年份
    
    NSString *_droplineYear;      /// 投档线年份
    NSString *_droplineRanking;    /// 投档线排序
    
    NSString *_enterlineYear;     /// 录取线年份
    NSString *_enterlineRankint;   /// 录取线排序
    
    int _droplineSort;     /// 投档线排序 1、投档最高位次 2、投档平均位次，3投档最低位次
    int _enterlineSort;    /// 录取线排序 1、最高分从高到低 2、最低分从高到低 3、平均分从高到低
    
}

@property (nonatomic,assign) int droplinePage;
@property (nonatomic,assign) int enterlinePage;
@property (nonatomic,assign) int size;


@property (nonatomic,strong) HUZKernelDataView *kernelDataView;
@property (nonatomic,strong) HUZDroplineTableView *droplineTableView;
@property (nonatomic,strong) HUZDroplineTableView *enterlineTableView;

@property (nonatomic,strong) HUZPPPSelectView *scoreSectionYearView;
@property (nonatomic,strong) HUZPPPSelectView *scoreLineYearView;
@property (nonatomic,strong) HUZPPPSelectView *droplineSelectYearView;
@property (nonatomic,strong) HUZPPPSelectView *droplineRankingView;
@property (nonatomic,strong) HUZPPPSelectView *enterlineSelectYearView;
@property (nonatomic,strong) HUZPPPSelectView *enterlineRankingView;

@property (nonatomic,strong) NSMutableArray *dataDropline;
@property (nonatomic,strong) NSMutableArray *dataEnterline;

@property (nonatomic, strong) NSMutableArray * scoreSectionYearViewArr;
@property (nonatomic, strong) NSMutableArray * scoreLineYearArr;
@property (nonatomic, strong) NSMutableArray * droplineSelectYearViewArr;
@property (nonatomic, strong) NSMutableArray * enterlineSelectYearViewArr;

@end

@implementation HUZKernelDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    self.navigationItem.title = @"核心数据";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateStateAction:) name:HUZVIPUpdate_State_Noti_Key object:nil];
}
-(void)updateStateAction:(NSNotification *)noti {
    self.droplineTableView.vipState = [HUZUserCenterManager.userModel.vip integerValue];
    self.enterlineTableView.vipState = [HUZUserCenterManager.userModel.vip integerValue];
    if ([HUZUserCenterManager.userModel.vip integerValue] != 0) {
        [self loadDroplineList];
        [self loadEnterlineList];
    }
}
#pragma mark Override
- (void)configComponents{
    [super configComponents];

    /// 年份
    _scoreSectionYear = @"2019";
    _scoreLineYear = @"2019";
    _droplineYear = @"2019";
    _enterlineYear = @"2018";
    
//    [HUZDataBase getYearType:1 yearBlock:^(NSArray * _Nonnull yearArr) {
//        self->_scoreSectionYear = yearArr.copy;
//    }];
    
    /// 投档线排序，录取线排序
    _droplineSort = 1;
    _enterlineSort = 1;
    
    /// 页码、每页条数
    self.droplinePage = 1;
    self.enterlinePage = 1;
    self.size = 20;
    
    self.dataSegment = @[@"投档线",@"录取线"];
    
    /// 投档线
    self.droplineTableView = [[HUZDroplineTableView alloc] init];
    self.droplineTableView.type = HUZDroplineType;
    self.droplineTableView.year = @"2019";
    self.droplineTableView.conditon = @"投档最低分位次";//HUZDataBaseManager.dataDroplineRanking[0];
    
    /// 录取线
    self.enterlineTableView = [[HUZDroplineTableView alloc] init];
    self.enterlineTableView.type = HUZEnterlineType;
    self.enterlineTableView.year = @"2018";
    self.enterlineTableView.conditon = @"录取最低分位次"; //HUZDataBaseManager.dataEnterlineRanking[0];
    
    [self.segTableView setTableViews:@[self.droplineTableView,self.enterlineTableView]];
    [self.view addSubview:self.segTableView];
    [self.segTableView setTopView:self.kernelDataView];
    
    HUZWEAK_SELF
    self.droplineTableView.mj_footer = [HUZRefreshFooter footerWithRefreshingBlock:^{
        HUZSTRONG_SELF
        strongSelf.droplinePage++;
        [strongSelf loadDroplineList];
    }];
    
    self.enterlineTableView.mj_footer = [HUZRefreshFooter footerWithRefreshingBlock:^{
        HUZSTRONG_SELF
        strongSelf.enterlinePage++;
        [strongSelf loadEnterlineList];
    }];
    
    [self loadScoreSectionData];
    [self loadScoreLineData];
    
    self.droplineTableView.vipState = [HUZUserCenterManager.userModel.vip integerValue];
    self.enterlineTableView.vipState = [HUZUserCenterManager.userModel.vip integerValue];
    if ([HUZUserCenterManager.userModel.vip integerValue] != 0) {
        [self loadDroplineList];
        [self loadEnterlineList];
    }

}

#pragma mark UIResponder
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo{
    if ([eventName isEqualToString:HUZdroplineClickyear]) {
        if (self.droplineSelectYearViewArr.count > 0) {
            self.droplineSelectYearView.dataArray = self.droplineSelectYearViewArr.copy;
            [self.droplineSelectYearView show];
        }else{
            [HUZDataBase getYearType:3 yearBlock:^(NSArray * _Nonnull yearArr) {
                self.droplineSelectYearViewArr = yearArr.copy;
                self.droplineSelectYearView.dataArray = yearArr.copy;
                [self.droplineSelectYearView show];
            }];
        }
        
    }
    else if ([eventName isEqualToString:HUZdroplineClickdrop]){
        [self.droplineRankingView show];
    }
    else if([eventName isEqualToString:HUZenterlineClickyear]){
        if (self.enterlineSelectYearViewArr.count > 0) {
            self.enterlineSelectYearView.dataArray = self.enterlineSelectYearViewArr.copy;
            [self.enterlineSelectYearView show];
        }else{
            [HUZDataBase getYearType:4 yearBlock:^(NSArray * _Nonnull yearArr) {
                self.enterlineSelectYearViewArr = yearArr.copy;
                self.enterlineSelectYearView.dataArray = yearArr.copy;
                [self.enterlineSelectYearView show];
            }];
        }
        
    }
    else if ([eventName isEqualToString:HUZenterlineClickdrop]){
        [self.enterlineRankingView show];
    }
}

#pragma mark HUZPPPSelectViewDelegate
- (void)pppSelectViewDelegateWith:(HUZPPPSelectView *)selectView indexPath:(NSIndexPath*)indexPAth result:(NSString *)result{
    /// 一分一段年份
    if (selectView.tag == 1) {
        _scoreSectionYear = result;
        [self.kernelDataView.gkInfoView.btnYear setTitle:result forState:UIControlStateNormal];
        [self loadScoreSectionData];
    }
    /// 分数线年份
    else if (selectView.tag == 2){
        _scoreLineYear = result;
        [self.kernelDataView.scorelineView.btnYear setTitle:result forState:UIControlStateNormal];
        [self loadScoreLineData];
    }
    /// 投档线选择年份
    else if (selectView.tag == 3){
        _droplineYear = result;
        self.droplineTableView.year = result;
        self.droplinePage = 1;
        [self loadDroplineList];
    }
    /// 投档线排序
    else if (selectView.tag == 4){
        self.droplineTableView.conditon = result;
        _droplineSort = (int)indexPAth.row + 1;
        self.droplinePage = 1;
        [self loadDroplineList];
    }
    ///录取线选择年份
    else if (selectView.tag == 5){
        _enterlineYear = result;
        self.enterlineTableView.year = result;
        self.enterlinePage = 1;
        [self loadEnterlineList];
    }
    ///录取线排序
    else if (selectView.tag == 6){
        self.enterlineTableView.conditon = result;
        _enterlineSort = (int)indexPAth.row + 1;
        self.enterlinePage = 1;
        [self loadEnterlineList];
    }
}


#pragma mark Action
/// 一分一段选择年份
- (void)clickScoreSectionYear{
    if (self.scoreSectionYearViewArr.count > 0) {
        self.scoreSectionYearView.dataArray = self.scoreSectionYearViewArr.copy;
        [self.scoreSectionYearView show];
    }else{
        [HUZDataBase getYearType:1 yearBlock:^(NSArray * _Nonnull yearArr) {
            self.scoreSectionYearViewArr = yearArr.copy;
            self.scoreSectionYearView.dataArray = yearArr.copy;
            [self.scoreSectionYearView show];
        }];
    }
}

/// 分数线选择年份
- (void)clickScorelineYear{
    if (self.scoreLineYearArr.count > 0) {
        self.scoreLineYearView.dataArray = self.scoreLineYearArr.copy;
        [self.scoreLineYearView show];
    }else{
        [HUZDataBase getYearType:2 yearBlock:^(NSArray * _Nonnull yearArr) {
            self.scoreLineYearArr = yearArr.copy;
            self.scoreLineYearView.dataArray = yearArr.copy;
            [self.scoreLineYearView show];
        }];
    }
}

#pragma mark NETWork
/// 一分一段
- (void)loadScoreSectionData{
    HUZWEAK_SELF
    [HUZHomeService getScoreSection:@{@"year":_scoreSectionYear} success:^(HUZKernalScoreSectionModel * model) {
        HUZSTRONG_SELF
        if (DRStringIsEmpty(model.data.score) && DRStringIsEmpty(model.data.scoreNum) && DRStringIsEmpty(model.data.cumulativeNum)) {
            [strongSelf presentErrorSheet:@"该年份暂无数据"];
        }
        strongSelf.kernelDataView.scoreSectionModel = model;
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf presentErrorSheet:errorStr];
    }];
}

/// 分数线
- (void)loadScoreLineData{
    HUZWEAK_SELF
    [HUZHomeService getScoreLine:@{@"year":_scoreLineYear} success:^(HUZKernalScoreLineModel * model) {
        HUZSTRONG_SELF
        if (DRArrayIsEmpty(model.data)) {
            [strongSelf presentErrorSheet:@"该年份暂无数据"];
        }
        strongSelf.kernelDataView.scoreLineModel = model;
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf presentErrorSheet:errorStr];
    }];
}

/// 投档线列表数据
- (void)loadDroplineList{
    HUZWEAK_SELF
    [self.droplineTableView displayOverFlowActivityView];
    [HUZHomeService getDroplineList:@{@"pageNow":@(self.droplinePage),@"pageSize":@(self.size),@"sort":@(_droplineSort),@"year":_droplineYear} success:^(HUZKernalDroplineModel * model) {
        HUZSTRONG_SELF
        [strongSelf.droplineTableView removeOverFlowActivityView];
        if (strongSelf.droplinePage == 1) {
            [strongSelf.dataDropline removeAllObjects];
        }
        [strongSelf.dataDropline addObjectsFromArray:model.data.list];
        [strongSelf.droplineTableView configEmptyViewWithError:EMPTYDATA];
        strongSelf.droplineTableView.datas = strongSelf.dataDropline;
        [strongSelf.droplineTableView.mj_footer endRefreshing];
        if (strongSelf.droplinePage >= model.data.totalPage) {
            [strongSelf.droplineTableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf.droplineTableView removeOverFlowActivityView];
        [strongSelf.droplineTableView configEmptyViewWithError:errorStr];
        [strongSelf.droplineTableView reloadData];
        [strongSelf.droplineTableView.mj_footer endRefreshing];
    }];
}

/// 录取线列表数据
- (void)loadEnterlineList{
    HUZWEAK_SELF
    [self.enterlineTableView displayOverFlowActivityView];
    [HUZHomeService getEnterlineList:@{@"pageNow":@(self.enterlinePage),@"pageSize":@(self.size),@"sort":@(_enterlineSort),@"year":_enterlineYear} success:^(HUZKernalEnterlineModel * model) {
        HUZSTRONG_SELF
        [strongSelf.enterlineTableView removeOverFlowActivityView];
        if (strongSelf.enterlinePage == 1) {
            [strongSelf.dataEnterline removeAllObjects];
        }
        [strongSelf.dataEnterline addObjectsFromArray:model.data.list];
        [strongSelf.enterlineTableView configEmptyViewWithError:EMPTYDATA];
        strongSelf.enterlineTableView.datas = strongSelf.dataEnterline;
        [strongSelf.enterlineTableView.mj_footer endRefreshing];
        if (strongSelf.enterlinePage >= model.data.totalPage) {
            [strongSelf.enterlineTableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf.enterlineTableView removeOverFlowActivityView];
        [strongSelf.enterlineTableView configEmptyViewWithError:errorStr];
        [strongSelf.enterlineTableView reloadData];
        [strongSelf.enterlineTableView.mj_footer endRefreshing];
    }];
}
#pragma mark - Lazy
- (HUZKernelDataView *)kernelDataView{
    CGFloat H = HUZSCREEN_WIDTH >= 414 ? 320 : 298;
    if (!_kernelDataView) {
        _kernelDataView = [[HUZKernelDataView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, H)];
        [_kernelDataView.gkInfoView.btnYear addTarget:self action:@selector(clickScoreSectionYear) forControlEvents:UIControlEventTouchUpInside];
        [_kernelDataView.scorelineView.btnYear addTarget:self action:@selector(clickScorelineYear) forControlEvents:UIControlEventTouchUpInside];
        [self.kernelDataView.gkInfoView.btnYear setTitle:@"2019" forState:UIControlStateNormal];
        [self.kernelDataView.scorelineView.btnYear setTitle:@"2019" forState:UIControlStateNormal];
        MJWeakSelf
        [_kernelDataView.gkInfoView.labGkInfo addTapAction:^(id  _Nonnull sender) {
            HUZMyGkInfoViewController *infoVC = [[HUZMyGkInfoViewController alloc] init];
            [weakSelf.navigationController pushViewController:infoVC animated:true];
        }];
        
    }
    return _kernelDataView;
}

- (HUZPPPSelectView *)scoreSectionYearView{
    if (!_scoreSectionYearView) {
        _scoreSectionYearView = [HUZPPPSelectView new];
        _scoreSectionYearView.headTitle = @"选择您要查看的年份";
        //_scoreSectionYearView.dataArray = HUZDataBaseManager.dataYear.mutableCopy;
        _scoreSectionYearView.delegate = self;
        _scoreSectionYearView.tag = 1;
    }
    return _scoreSectionYearView;
}

- (HUZPPPSelectView *)scoreLineYearView{
    if (!_scoreLineYearView) {
        _scoreLineYearView = [HUZPPPSelectView new];
        _scoreLineYearView.headTitle = @"选择您要查看的年份";
        //_scoreLineYearView.dataArray = HUZDataBaseManager.dataYear.mutableCopy;
        _scoreLineYearView.delegate = self;
        _scoreLineYearView.tag = 2;
    }
    return _scoreLineYearView;
}

- (HUZPPPSelectView *)droplineSelectYearView{
    if (!_droplineSelectYearView) {
        _droplineSelectYearView = [HUZPPPSelectView new];
        _droplineSelectYearView.headTitle = @"选择您要查看的年份";
        _droplineSelectYearView.dataArray = HUZDataBaseManager.dataYear.mutableCopy;
        _droplineSelectYearView.delegate = self;
        _droplineSelectYearView.tag = 3;
    }
    return _droplineSelectYearView;
}

- (HUZPPPSelectView *)droplineRankingView{
    if (!_droplineRankingView) {
        _droplineRankingView = [HUZPPPSelectView new];
        _droplineRankingView.headTitle = @"选择排序方式";
        _droplineRankingView.dataArray = HUZDataBaseManager.dataDroplineRanking.mutableCopy;
        _droplineRankingView.delegate = self;
        _droplineRankingView.tag = 4;
    }
    return _droplineRankingView;
}

- (HUZPPPSelectView *)enterlineSelectYearView{
    if (!_enterlineSelectYearView) {
        _enterlineSelectYearView = [HUZPPPSelectView new];
        _enterlineSelectYearView.headTitle = @"选择您要查看的年份";
        _enterlineSelectYearView.dataArray = HUZDataBaseManager.dataYear.mutableCopy;
        _enterlineSelectYearView.delegate = self;
        _enterlineSelectYearView.tag = 5;
    }
    return _enterlineSelectYearView;
}

- (HUZPPPSelectView *)enterlineRankingView{
    if (!_enterlineRankingView) {
        _enterlineRankingView = [HUZPPPSelectView new];
        _enterlineRankingView.headTitle = @"选择排序方式";
        _enterlineRankingView.dataArray = HUZDataBaseManager.dataEnterlineRanking.mutableCopy;
        _enterlineRankingView.delegate = self;
        _enterlineRankingView.tag = 6;
    }
    return _enterlineRankingView;
}

- (NSMutableArray *)dataDropline{
    if (!_dataDropline) {
        _dataDropline = [NSMutableArray new];
    }
    return _dataDropline;
}

- (NSMutableArray *)dataEnterline{
    if (!_dataEnterline) {
        _dataEnterline = [NSMutableArray new];
    }
    return _dataEnterline;
}

-(NSMutableArray *)scoreSectionYearViewArr {
    if (!_scoreSectionYearViewArr) {
        _scoreSectionYearViewArr = [NSMutableArray array];
    }
    return _scoreSectionYearViewArr;
}

-(NSMutableArray *)scoreLineYearArr {
    if (!_scoreLineYearArr) {
        _scoreLineYearArr = [NSMutableArray array];
    }
    return _scoreLineYearArr;
}
-(NSMutableArray *)droplineSelectYearViewArr {
    if (!_droplineSelectYearViewArr) {
        _droplineSelectYearViewArr = [NSMutableArray array];
    }
    return _droplineSelectYearViewArr;
}
-(NSMutableArray *)enterlineSelectYearViewArr {
    if (!_enterlineSelectYearViewArr) {
        _enterlineSelectYearViewArr = [NSMutableArray array];
    }
    return _enterlineSelectYearViewArr;
}
@end

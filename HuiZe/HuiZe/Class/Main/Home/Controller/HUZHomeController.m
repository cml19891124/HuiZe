//
//  HUZHomeSearchView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/18.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZHomeController.h"
#import "FSScrollContentView.h"
#import "HUZTableView.h"
#import "HUZHomeSearchView.h"
#import "HUZHomeBannerView.h"
#import "HUZHomeFunctionCell.h"
#import "HUZHomeServiceCell.h"
#import "HUZHomeRecommendCell.h"
#import "HUZInfoSectionView.h"
#import "HUZGkinfoCell.h"
#import "HUZLoginModel.h"
#import "HUZGkInfoListViewController.h"
#import "HUZNewGkSubjectViewController.h"
#import "HUZMyVipCardViewController.h"
#import "HUZAgreementViewController.h"
@interface HUZHomeController ()<FSPageContentViewDelegate,FSSegmentTitleViewDelegate,UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

@property (nonatomic,strong) HUZTableView *tableView;
@property (nonatomic,strong) HUZHomeSearchView *searchView;
@property (nonatomic,strong) HUZHomeBannerView *bannerView;

@property (nonatomic,strong) FSSegmentTitleView *titleView;
@property (nonatomic,strong) HUZGkinfoCell *gkInfoCell;
@property (nonatomic, assign) BOOL canScroll;


@property (nonatomic,strong) NSMutableArray *dataFunction;
@property (nonatomic,strong) NSArray *dataInfo;
@property (nonatomic,strong) NSMutableArray *dataRecommendUni;
@property (nonatomic,strong) NSMutableArray *dataRecommendMajor;

@end


@implementation HUZHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self removeUIPanGestureRecognizer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:@"leaveTop" object:nil];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self getUserInfoData];
    
    
}

//更新本地缓存
-(void)getUserInfoData {
    [HUZNetWorkTool huz_POST:kUrl_query_userInfo parameters:nil success:^(id  _Nonnull responseObject) {
        HUZWEAK_SELF;
        NSString *code = responseObject[@"code"];
        if ([code integerValue] == 0) {
//            model.data.userEntity.token = model.data.token;
            HUZUser *model = [HUZUser modelWithJSON:responseObject[@"data"]];
            HUZUserCenterManager.userModel = model;
//            HUZUserCenterManager.userModel.vip = @"3";
            [HUZUserCenterManager saveToCache];
            NSLog(@"token: %@",HUZUserCenterManager.userModel.token);
        } else {
        }
    } failure:^(NSUInteger statusCode, NSString *error) {
        
    }];
}

#pragma mark notify 改变主视图状态
- (void)changeScrollStatus{
    self.canScroll = YES;
    self.gkInfoCell.cellCanScroll = NO;
}

- (void)configComponents{
    [super configComponents];
    
    self.canScroll = YES;
    
    self.dataFunction = [NSMutableArray new];
    NSArray *array1 = @[@"志愿填写",@"核心数据",@"招生计划",@"报考指南",@"查大学",@"查专业",@"高考动态",@"生涯规划"];
    NSArray *array2 = @[@"ic_function1",@"ic_function2",@"ic_function3",@"ic_function4",@"ic_function5",@"ic_function6",@"ic_function7",@"ic_function8"];
    for (int i = 0; i < array1.count; i ++) {
        NSMutableDictionary *dic = [NSMutableDictionary new];
        [dic setValue:array1[i] forKey:@"name"];
        [dic setValue:array2[i] forKey:@"icon"];
        [self.dataFunction addObject:dic];
    }
    self.dataInfo = @[@"热门推荐",@"独家解析",@"资讯头条",@"报考指南",@"备考经验",@"大学导航"];
    self.dataRecommendUni = [NSMutableArray new];
    self.dataRecommendMajor = [NSMutableArray new];
    
    
    self.navigationItem.titleView = self.searchView;
    self.searchView.intrinsicContentSize = CGSizeMake(HUZSCREEN_WIDTH, HUZNAVIGATION_BAR_HEIGHT);
    self.tableView.tableHeaderView = self.bannerView;
    
    [self.tableView dz_registerCell:[HUZHomeFunctionCell class]];
    [self.tableView dz_registerCell:[HUZHomeServiceCell class]];
    [self.tableView dz_registerCell:[HUZHomeRecommendCell class]];
//    [self.tableView dz_registerCell:[HUZGkinfoCell class]];
    
    [self.tableView reloadData];
    
    self.gkInfoCell.currentTagStr = self.dataInfo[self.titleView.selectIndex];
    self.gkInfoCell.isRefresh = YES;
    
    HUZWEAK_SELF
    self.tableView.mj_header = [HUZRefreshHeader headerWithRefreshingBlock:^{
        HUZSTRONG_SELF
        [strongSelf loadBanner];
        [strongSelf loadRecommendUni];
        [strongSelf loadRecommednMajor];
    }];
    [self.tableView.mj_header beginRefreshing];
}

/// 新高考政策
- (void)clickgkSubject{
    HUZNewGkSubjectViewController *newGkSubjectVC = [HUZNewGkSubjectViewController new];
    [self.navigationController pushViewController:newGkSubjectVC animated:YES];
}

/// 我的Vip卡
- (void)clickMyVipCard{
    HUZMyVipCardViewController *myVipCardVC = [HUZMyVipCardViewController new];
    [self.navigationController pushViewController:myVipCardVC animated:YES];
}

#pragma mark NETWork
/// banner图
- (void)loadBanner{
    HUZWEAK_SELF
    [HUZHomeService getBanner:@{@"type":@"0"} success:^(HUZBannerModel * model) {
        HUZSTRONG_SELF
        strongSelf.bannerView.banners = model.data;
        [strongSelf.tableView.mj_header endRefreshing];
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf presentErrorSheet:errorStr];
        [strongSelf.tableView.mj_header endRefreshing];
    }];
}
/// 推荐院校
- (void)loadRecommendUni{
    HUZWEAK_SELF
    [HUZHomeService getRecommendUni:@{} success:^(HUZRecommendUniModel * _Nonnull model) {
        HUZSTRONG_SELF
        [strongSelf.dataRecommendUni removeAllObjects];
        [strongSelf.dataRecommendUni addObjectsFromArray:model.data.admissionDetailsEntityList];
        [strongSelf.tableView reloadData];
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf presentErrorSheet:errorStr];
    }];
}

/// 推荐专业
- (void)loadRecommednMajor{
    HUZWEAK_SELF
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    par[@"recruitAddress"] = HUZUserCenterManager.userModel.examinationProvince;
    par[@"leMinScore"] = HUZUserCenterManager.userModel.estimateScore;
    par[@"grade"] = HUZUserCenterManager.userModel.grade;

    [HUZHomeService getRecommendMajor:par success:^(HUZRecommendMajorModel * _Nonnull model) {
        HUZSTRONG_SELF
        [strongSelf.dataRecommendMajor removeAllObjects];
        [strongSelf.dataRecommendMajor addObjectsFromArray:model.data];
        [strongSelf.tableView reloadData];
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf presentErrorSheet:errorStr];
    }];
}

#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 4 : 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ? 0 : 80;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) return nil;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, 80)];
    headerView.backgroundColor = COLOR_BG_WHITE;
    UILabel *labGk = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_17)];
    labGk.frame = CGRectMake(15, 12, 100, 24);
    labGk.text = @"大家都在看";
    [headerView addSubview:labGk];
    
    self.titleView = [[FSSegmentTitleView alloc] initWithFrame:CGRectMake(10, 50, HUZSCREEN_WIDTH-10, 30) titles:self.dataInfo delegate:self indicatorType:FSIndicatorTypeEqualTitle];
    self.titleView.backgroundColor = COLOR_BG_WHITE;
    self.titleView.titleFont = FontS(FONT_14);
    self.titleView.titleSelectFont = FontS(FONT_14);
    self.titleView.titleNormalColor = ColorS(COLOR_989898);
    self.titleView.titleSelectColor = ColorS(COLOR_2E86FF);
    self.titleView.indicatorColor = [UIColor clearColor];
    self.titleView.itemMargin = 18;
    [headerView addSubview:self.titleView];
    return headerView;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return [HUZHomeFunctionCell calculateHeightWithEntity:nil];
        }else if(indexPath.row == 1 || indexPath.row == 4){
            return [HUZHomeServiceCell calculateHeightWithEntity:nil];
        }else{
            return [HUZHomeRecommendCell calculateHeightWithEntity:nil];
        }
    }else{
        return HUZSCREEN_HEIGHT-HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT-80-HUZTAB_BAR_HEIGHT;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /// 分区一
    if (indexPath.section == 0) {
        /// 功能按钮区域
        if (indexPath.row == 0) {
            HUZHomeFunctionCell *cell = [HUZHomeFunctionCell cellWithTableView:tableView];
            cell.dataFunction = self.dataFunction;
            return cell;
        }
        
        /// 新高考、服务、广告位
        else if(indexPath.row == 1 || indexPath.row == 4){
            HUZHomeServiceCell *cell = [HUZHomeServiceCell cellWithTableView:tableView];
            cell.type = indexPath.row == 1 ? HUZHomeServiceFunctionType : HUZHomeServiceAdtype;
            [cell.serviceView1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickgkSubject)]];
            [cell.serviceView2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMyVipCard)]];
            return cell;
        }
        /// 推荐院校、推荐专业
        else{
            HUZHomeRecommendCell *cell = [HUZHomeRecommendCell cellWithTableView:tableView];
            cell.type = indexPath.row == 2 ? HUZHomeRecommendUni : HUZHomeRecommendMajor;
            if (indexPath.row == 2) {
                if (!DRArrayIsEmpty(self.dataRecommendUni)) {
                    cell.datasUni = self.dataRecommendUni.copy;
                }
            }else{
                if (!DRArrayIsEmpty(self.dataRecommendMajor)) {
                    cell.datasMajor = self.dataRecommendMajor.copy;
                }
            }
            return cell;
        }
    }
    
    /// 分区二
    else{
        self.gkInfoCell = [tableView dequeueReusableCellWithIdentifier:@"HUZGkinfoCell"];
        if (!self.gkInfoCell) {
            self.gkInfoCell = [[HUZGkinfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HUZGkinfoCell"];
            NSMutableArray *contentVCs = [NSMutableArray array];
            for (int i = 0 ; i < self.dataInfo.count; i ++) {
                HUZGkInfoListViewController *gkInfoListVC = [HUZGkInfoListViewController new];
                gkInfoListVC.listId = i;  /// 设置列表查询id
                gkInfoListVC.title = self.dataInfo[i];
                gkInfoListVC.str = self.dataInfo[i];
                [contentVCs addObject:gkInfoListVC];
            }
            self.gkInfoCell.viewControllers = contentVCs;
            self.gkInfoCell.pageContentView = [[FSPageContentView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT-HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT-80-HUZTAB_BAR_HEIGHT) childVCs:contentVCs parentVC:self delegate:self];
            [self.gkInfoCell.contentView addSubview:self.gkInfoCell.pageContentView];
        }
        return self.gkInfoCell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
#pragma mark UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat bottomCellOffset = [self.tableView rectForSection:1].origin.y ;
    if (scrollView.contentOffset.y >= bottomCellOffset) {
        scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        if (self.canScroll) {
            self.canScroll = NO;
            self.gkInfoCell.cellCanScroll = YES;
        }
    }else{
        if (!self.canScroll) {//子视图没到顶部
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        }
    }
    self.tableView.showsVerticalScrollIndicator = _canScroll?YES:NO;
}

#pragma mark FSSegmentTitleViewDelegate
- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex{
    self.titleView.selectIndex = endIndex;
    self.tableView.scrollEnabled = YES;//此处其实是监测scrollview滚动，pageView滚动结束主tableview可以滑动，或者通过手势监听或者kvo，这里只是提供一种实现方式
}

- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex{
    self.gkInfoCell.pageContentView.contentViewCurrentIndex = endIndex;
}

- (void)FSContentViewDidScroll:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex progress:(CGFloat)progress{
    self.tableView.scrollEnabled = NO;//pageView开始滚动主tableview禁止滑动
}

#pragma mark - Lazy
- (HUZHomeSearchView *)searchView{
    if (!_searchView) {
        _searchView = [[HUZHomeSearchView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, HUZNAVIGATION_BAR_HEIGHT)];
    }
    return _searchView;
}

- (HUZHomeBannerView *)bannerView{
    if (!_bannerView) {
        _bannerView = [[HUZHomeBannerView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, (HUZSCREEN_WIDTH - 30) * 0.412 + 20)];
        _bannerView.cycleScrollView.delegate = self;
    }
    return _bannerView;
}

- (HUZTableView *)tableView{
    if (!_tableView) {
        _tableView = [[HUZTableView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT-HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT-HUZTAB_BAR_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    HUZBannerDataModel *model = nil;
    if (self.bannerView.banners.count > index) {
        model = self.bannerView.banners[index];
    }
    
    HUZAgreementViewController *agreementVC = [[HUZAgreementViewController alloc] init];
    agreementVC.url = model.jumpUrl;
    [self.navigationController pushViewController:agreementVC animated:true];
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

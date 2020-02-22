//
//  HUZSearchAllUniViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/24.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZSearchAllUniViewController.h"
#import "HUZSearchNavView.h"
#import "TYTabPagerBar.h"
#import "TYPagerController.h"
#import "HUZSearchUniListViewController.h"
#import "HUZSearchViewController.h"
#import "HUZDressUniView.h"
#import "HUZLoginService.h"

@interface HUZSearchAllUniViewController ()
<
TYTabPagerBarDataSource,
TYTabPagerBarDelegate,
TYPagerControllerDataSource,
TYPagerControllerDelegate
>

@property (nonatomic,strong) HUZSearchNavView *searchNavView;
@property (nonatomic,strong) UIView *ivRadio;
@property (nonatomic, weak) TYTabPagerBar *tabBar;
@property (nonatomic, weak) TYPagerController *pagerController;
@property (nonatomic,strong) HUZDressUniView *dressView;

@property (nonatomic,strong) NSMutableArray *contentVcs;
@property (nonatomic,strong) NSArray *datas;
@property (nonatomic,strong) NSMutableArray *dataProvince;

@end

@implementation HUZSearchAllUniViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ColorS(COLOR_BG_F6F6F6);
}

- (void)configComponents{
    [super configComponents];
    
    self.navigationItem.titleView = self.searchNavView;
    self.searchNavView.intrinsicContentSize = CGSizeMake(HUZSCREEN_WIDTH-58, 30);
    [self.view addSubview:self.ivRadio];
    
    [self addTabPageBar];
    [self addPagerController];
    
    _tabBar.frame = CGRectMake(AutoDistance(90), 0, HUZSCREEN_WIDTH - AutoDistance(90) - AutoDistance(35), AutoDistance(44));
    _pagerController.view.frame = CGRectMake(0, AutoDistance(52), HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT-AutoDistance(52));
    
    self.datas = HUZDataBaseManager.dataSchoolType;

    /// 控制器数据
    self.contentVcs = [NSMutableArray new];
    for (int i = 0; i < self.datas.count; i++) {
        HUZSearchUniListViewController *VC  = [HUZSearchUniListViewController new];
        VC.type = (self.searchType == 1) ? 0 : 1;
        [self.contentVcs addObject:VC];
    }
   
    [_tabBar reloadData];
    [_pagerController reloadData];
    
    
    /// 加载省份
    [self loadProvince];
}

- (void)addTabPageBar{
    TYTabPagerBar *tabBar = [[TYTabPagerBar alloc]init];
    tabBar.layout.barStyle = TYPagerBarStyleProgressElasticView;
    tabBar.layout.normalTextFont = FontS(FONT_14);
    tabBar.layout.selectedTextFont = FontS(FONT_14);
    tabBar.layout.normalTextColor = ColorS(COLOR_989898);
    tabBar.layout.selectedTextColor = ColorS(COLOR_2E86FF);
    tabBar.layout.progressColor = [UIColor clearColor];
    tabBar.layout.progressHeight = 0;
    tabBar.layout.cellEdging = AutoDistance(8);
    tabBar.dataSource = self;
    tabBar.delegate = self;
    [tabBar registerClass:[TYTabPagerBarCell class] forCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier]];
    [self.ivRadio addSubview:tabBar];
    _tabBar = tabBar;
}

- (void)addPagerController {
    TYPagerController *pagerController = [[TYPagerController alloc]init];
    pagerController.layout.addVisibleItemOnlyWhenScrollAnimatedEnd = YES;
    pagerController.view.backgroundColor = COLOR_BG_WHITE;
    pagerController.dataSource = self;
    pagerController.delegate = self;
    pagerController.scrollView.bounces = NO;
    [self addChildViewController:pagerController];
    [self.view addSubview:pagerController.view];
    _pagerController = pagerController;
}

#pragma mark NETWork
/// 获取省份
- (void)loadProvince{
    self.dataProvince = [NSMutableArray new];
    HUZWEAK_SELF
    [HUZLoginService getProvinceSuccess:^(HUZProvinceModel * _Nonnull object) {
        HUZSTRONG_SELF
        [strongSelf.dataProvince addObjectsFromArray:object.data];
        HUZProvince *province = [HUZProvince new];
        province.Id = @"-1";
        province.title = @"不限";
        [strongSelf.dataProvince insertObject:province atIndex:0];
        [strongSelf.dressView loadData:strongSelf.dataProvince];
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
    }];
}

/// 显示筛选弹窗
- (void)showDressView{
    [self.dressView show];
    HUZWEAK_SELF
    self.dressView.sendBlock = ^(int category, int address, int keyone, int schoolPrivate, int schoolType) {
        HUZSTRONG_SELF
        //strongSelf.pagerController.curIndex = 1;//schoolType + 1;
        //strongSelf.pagerController.curIndex = 1;
        [strongSelf.pagerController scrollToControllerAtIndex:schoolType+1 animate:YES];
        HUZSearchUniListViewController *VC = strongSelf.contentVcs[schoolType+1];
        [VC reloadDataWithCategory:category address:address keyOne:keyone schoolPrivate:schoolPrivate schoolType:schoolType];
    };
}

#pragma mark - TYTabPagerBarDataSource
//标题数量
- (NSInteger)numberOfItemsInPagerTabBar{
    return self.datas.count;
}

//标题text
- (UICollectionViewCell<TYTabPagerBarCellProtocol> *)pagerTabBar:(TYTabPagerBar *)pagerTabBar cellForItemAtIndex:(NSInteger)index {
    UICollectionViewCell<TYTabPagerBarCellProtocol> *cell = [pagerTabBar dequeueReusableCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier] forIndex:index];
    cell.titleLabel.text = self.datas[index];
    return cell;
}

#pragma mark - TYTabPagerBarDelegate
//标题宽
- (CGFloat)pagerTabBar:(TYTabPagerBar *)pagerTabBar widthForItemAtIndex:(NSInteger)index {
    NSString *title = _datas[index];
    return [pagerTabBar cellWidthForTitle:title];
}
//点击标题回调
- (void)pagerTabBar:(TYTabPagerBar *)pagerTabBar didSelectItemAtIndex:(NSInteger)index {
    [_pagerController scrollToControllerAtIndex:index animate:YES];
}
#pragma mark - TYPagerControllerDataSource
- (NSInteger)numberOfControllersInPagerController {
    return self.datas.count;
}
- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching {
    HUZSearchUniListViewController *searchUniListVC = self.contentVcs[index];
    searchUniListVC.category = -1;
    searchUniListVC.address = -1;
    searchUniListVC.keyOne = -1;
    searchUniListVC.schoolPrivate = -1;
    searchUniListVC.schoolType = (int)index -1;
    searchUniListVC.examinationProvince = self.searchType == HUZSearchAllUni ? @"" : HUZUserCenterManager.userModel.examinationProvince;
    [self.contentVcs addObject:searchUniListVC];
    return searchUniListVC;
}
#pragma mark - TYPagerControllerDelegate
- (void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex animated:(BOOL)animated {
    [_tabBar scrollToItemFromIndex:fromIndex toIndex:toIndex animate:animated];
}
-(void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress {
    [_tabBar scrollToItemFromIndex:fromIndex toIndex:toIndex progress:progress];
}

#pragma mark - Lazy
- (HUZSearchNavView *)searchNavView{
    if (!_searchNavView) {
        _searchNavView = [[HUZSearchNavView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH-58, 30)];
        _searchNavView.tfKeyword.placeholder = @"搜索学校";
        _searchNavView.tfKeyword.userInteractionEnabled = NO;
        HUZWEAK_SELF
        [_searchNavView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            HUZSTRONG_SELF
            HUZSearchViewController *searchVC = [HUZSearchViewController new];
            [strongSelf.navigationController pushViewController:searchVC animated:YES];
        }];
    }
    return _searchNavView;
}

- (UIView *)ivRadio{
    if (!_ivRadio) {
        _ivRadio = [[UIView alloc] initWithFrame:CGRectMake(0, AutoDistance(8), HUZSCREEN_WIDTH, AutoDistance(44))];
        _ivRadio.backgroundColor = COLOR_BG_WHITE;
        [self.view addSubview:_ivRadio];
        [UIView huz_bezierPathWithRoundedRect:_ivRadio];
        UILabel *labType = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_17)];
        labType.frame = CGRectMake(AutoDistance(15), AutoDistance(9), AutoDistance(70), AutoDistance(24));
        labType.text = self.searchType == HUZSearchAllUni ? @"全部高校" : @"本省高校";
        [_ivRadio addSubview:labType];
        UIView *ivbg = [[UIView alloc] initWithFrame:CGRectMake(HUZSCREEN_WIDTH-AutoDistance(35), 0, AutoDistance(35), AutoDistance(44))];
        ivbg.backgroundColor = COLOR_BG_WHITE;
        [_ivRadio addSubview:ivbg];
        UIImageView *ivSearchConditon = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_search_condition")];
        ivSearchConditon.userInteractionEnabled = YES;
        ivSearchConditon.frame = CGRectMake(AutoDistance(8), AutoDistance(14), AutoDistance(14), AutoDistance(14));
        HUZWEAK_SELF
        [ivSearchConditon jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            HUZSTRONG_SELF
            [strongSelf showDressView];
        }];
        [ivbg addSubview:ivSearchConditon];
    }
    return _ivRadio;
}

#pragma mark Lazy
- (HUZDressUniView *)dressView{
    if (!_dressView) {
        _dressView = [[HUZDressUniView alloc] initWithFrame:CGRectMake(HUZSCREEN_WIDTH, 0, HUZSCREEN_WIDTH-AutoDistance(55), HUZSCREEN_HEIGHT)];
        if (self.searchType == HUZSearchProvinceUni) {
            _dressView.type = 1;
        }
    }
    return _dressView;
}


@end

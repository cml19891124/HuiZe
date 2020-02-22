//
//  HUZSearchUniViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/23.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZSearchUniViewController.h"
#import "HUZSearchNavView.h"
#import "HUZSearchUniHeaderView.h"
#import "HUZSearchUniLikeTableView.h"
#import "HUZSearchAllUniViewController.h"
#import "HUZUniRankingViewController.h"
#import "HUZUniPkListViewController.h"
#import "HUZSearchViewController.h"
#import "SDCycleScrollView.h"
#import "HUZHomeBannerView.h"
#import "HUZAgreementViewController.h"
@interface HUZSearchUniViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic,strong) HUZSearchNavView *searchNavView;
@property (nonatomic,strong) HUZSearchUniHeaderView *searchUniHeaderView;
@property (nonatomic,strong) HUZSearchUniLikeTableView *searchUniLikeTableView;
//@property (nonatomic,strong) HUZSearchUniLikeTableView *searchUniHotTableView;
@end

@implementation HUZSearchUniViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)configComponents{
    [super configComponents];
    
    self.navigationItem.titleView = self.searchNavView;
    self.searchNavView.intrinsicContentSize = CGSizeMake(HUZSCREEN_WIDTH-AutoDistance(58), 30);
    
    self.dataSegment = @[@"猜你喜欢"];//,@"名企热招"
    self.progressW = self.view.width;
    /// 猜你喜欢
    self.searchUniLikeTableView = [[HUZSearchUniLikeTableView alloc] init];
    self.searchUniLikeTableView.type = HUZSearchUniLike;
    self.searchUniLikeTableView.datasType = HUZDataBaseManager.dataSchoolType.mutableCopy;
    
    /// 名企热招
//    self.searchUniHotTableView = [[HUZSearchUniLikeTableView alloc] init];
//    self.searchUniHotTableView.type = HUZSearchUniHot;
//    self.searchUniHotTableView.datasType = @[@"全部",@"腾讯",@"万科",@"中石化",@"工商银行"];
    
    [self.segTableView setTableViews:@[self.searchUniLikeTableView]];//,self.searchUniHotTableView
    [self.view addSubview:self.segTableView];
    [self.segTableView setTopView:self.searchUniHeaderView];
    
    [self.searchUniHeaderView.ivAllUni addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickFunction:)]];
    [self.searchUniHeaderView.ivProvinceUni addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickFunction:)]];
    [self.searchUniHeaderView.ivUniList addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickFunction:)]];
    [self.searchUniHeaderView.ivUniPK addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickFunction:)]];
    
    [self loadBanner];
}

- (void)clickFunction:(UITapGestureRecognizer *)tap{
    NSInteger tag = tap.view.tag;
    HUZViewController *VC = nil;
    
    /// 全部高校
    if (tag == 1) {
        HUZSearchAllUniViewController *searchAllUniVC = [HUZSearchAllUniViewController new];
        searchAllUniVC.searchType = HUZSearchAllUni;
        VC = searchAllUniVC;
    }
    
    /// 本省高校
    else if (tag == 2){
        HUZSearchAllUniViewController *searchProvinceUniVC = [HUZSearchAllUniViewController new];
        searchProvinceUniVC.searchType = HUZSearchProvinceUni;
        VC = searchProvinceUniVC;
    }
    
    /// 高校榜单
    else if (tag == 3){
        HUZUniRankingViewController *uniRankingVC = [HUZUniRankingViewController new];
        uniRankingVC.type = HUZUniRankingType;
        VC = uniRankingVC;
    }
    
    /// 高校PK
    else{
//        HUZUniPkListViewController *uniPkListVC = [HUZUniPkListViewController new];
//        VC = uniPkListVC;
        NSString *jumpUrl = [NSString stringWithFormat:@"http://47.107.101.26/huize/index.html#/school/pkList?token=%@",HUZUserCenterManager.userModel.token];
        HUZAgreementViewController *agreementVC = [[HUZAgreementViewController alloc] init];
        agreementVC.url = jumpUrl;
        [self.navigationController pushViewController:agreementVC animated:true];
    }

    if (VC != nil) {
        [self.navigationController pushViewController:VC animated:YES];
    }
}

#pragma mark NETWork
/// banner图
- (void)loadBanner{
    HUZWEAK_SELF
    [HUZHomeService getBanner:@{@"type":@"1"} success:^(HUZBannerModel * model) {
        HUZSTRONG_SELF
        strongSelf.searchUniHeaderView.bannerView.banners = model.data;
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf presentErrorSheet:errorStr];
    }];
}

#pragma mark - Lazy
- (HUZSearchNavView *)searchNavView{
    if (!_searchNavView) {
        _searchNavView = [[HUZSearchNavView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH-AutoDistance(58), 30)];
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

- (HUZSearchUniHeaderView *)searchUniHeaderView{
    CGFloat totalH = HUZSCREEN_WIDTH >= 414 ? 310 : 277;
    if (!_searchUniHeaderView) {
        _searchUniHeaderView = [[HUZSearchUniHeaderView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, totalH)];
        _searchUniHeaderView.bannerView.cycleScrollView.delegate = self;
        _searchUniHeaderView.type = HUZSearchUni;
    }
    return _searchUniHeaderView;
}


/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    HUZBannerDataModel *model = self.searchUniHeaderView.bannerView.banners[index];
    HUZAgreementViewController *agreementVC = [[HUZAgreementViewController alloc] init];
    agreementVC.url = model.jumpUrl;
    [self.navigationController pushViewController:agreementVC animated:true];
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {}
@end

//
//  HUZSearchMajorViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/26.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZSearchMajorViewController.h"
#import "HUZSearchNavView.h"
#import "HUZSearchUniHeaderView.h"
#import "HUZSearchMajorLikeTableView.h"
#import "HUZUniRankingViewController.h"
#import "HUZAllMajorViewController.h"
#import "HUZSearchViewController.h"
#import "HUZAgreementViewController.h"
#import "HUZSearchMajorAllAssessVC.h"
@interface HUZSearchMajorViewController ()<SDCycleScrollViewDelegate>
@property (nonatomic,strong) HUZSearchNavView *searchNavView;
@property (nonatomic,strong) HUZSearchUniHeaderView *searchMajorHeaderView;
@property (nonatomic,strong) HUZSearchMajorLikeTableView *searchMajorLikeTableView;
//@property (nonatomic,strong) HUZSearchMajorLikeTableView *searchMajorHotTableView;

@end

@implementation HUZSearchMajorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)configComponents{
    [super configComponents];
    
    self.navigationItem.titleView = self.searchNavView;
    self.searchNavView.intrinsicContentSize = CGSizeMake(HUZSCREEN_WIDTH-AutoDistance(58), 30);
    self.progressW = self.view.width;
    self.dataSegment = @[@"猜你喜欢"];//,@"名企热招"
    
    /// 猜你喜欢
    self.searchMajorLikeTableView = [[HUZSearchMajorLikeTableView alloc] init];
    self.searchMajorLikeTableView.type = HUZSearchMajorUlike;
    
    /// 名企热招
//    self.searchMajorHotTableView = [[HUZSearchMajorLikeTableView alloc] init];
//    self.searchMajorHotTableView.type = HUZSearchMajorHot;

    [self.segTableView setTableViews:@[self.searchMajorLikeTableView]];//,self.searchMajorHotTableView
    [self.view addSubview:self.segTableView];
    [self.segTableView setTopView:self.searchMajorHeaderView];
    
    
    [self.searchMajorHeaderView.ivAllUni addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickFunction:)]];
    [self.searchMajorHeaderView.ivProvinceUni addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickFunction:)]];
    
    
    [self loadBanner];
}

- (void)clickFunction:(UITapGestureRecognizer *)tap{
    NSInteger tag = tap.view.tag;
    /// 所有专业
    if (tag == 1) {
        HUZAllMajorViewController *allMajorVC = [HUZAllMajorViewController new];
        [self.navigationController pushViewController:allMajorVC animated:YES];
    }
    /// 专业排行榜
    else{
        HUZSearchMajorAllAssessVC *majorRankingVC = [HUZSearchMajorAllAssessVC new];
        [self.navigationController pushViewController:majorRankingVC animated:YES];
//        HUZUniRankingViewController *majorRankingVC = [HUZUniRankingViewController new];
//        majorRankingVC.type = HUZMajorRankingType;
//        [self.navigationController pushViewController:majorRankingVC animated:YES];
    }
}

#pragma mark NETWork
/// banner图
- (void)loadBanner{
    HUZWEAK_SELF
    [HUZHomeService getBanner:@{@"type":@"2"} success:^(HUZBannerModel * model) {
        HUZSTRONG_SELF
        strongSelf.searchMajorHeaderView.bannerView.banners = model.data;
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf presentErrorSheet:errorStr];
    }];
}

#pragma mark - Lazy
- (HUZSearchNavView *)searchNavView{
    if (!_searchNavView) {
        _searchNavView = [[HUZSearchNavView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH-AutoDistance(58), 30)];
        _searchNavView.tfKeyword.placeholder = @"搜索专业";
        _searchNavView.tfKeyword.userInteractionEnabled = NO;
        HUZWEAK_SELF
        [_searchNavView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            HUZSTRONG_SELF
//            HUZSearchViewController *searchVC = [HUZSearchViewController new];
//            [strongSelf.navigationController pushViewController:searchVC animated:YES];
            HUZAllMajorViewController *allMajorVC = [HUZAllMajorViewController new];
            [strongSelf.navigationController pushViewController:allMajorVC animated:YES];
        }];
    }
    return _searchNavView;
}

- (HUZSearchUniHeaderView *)searchMajorHeaderView{
    CGFloat totalH = HUZSCREEN_WIDTH >= 414 ? 310 : 277;
    if (!_searchMajorHeaderView) {
        _searchMajorHeaderView = [[HUZSearchUniHeaderView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, totalH)];
        _searchMajorHeaderView.bannerView.cycleScrollView.delegate = self;
        _searchMajorHeaderView.type = HUZSearchMajor;
    }
    return _searchMajorHeaderView;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    HUZBannerDataModel *model = nil;
    if (self.searchMajorHeaderView.bannerView.banners.count > index) {
        model = self.searchMajorHeaderView.bannerView.banners[index];
    }
    
    HUZAgreementViewController *agreementVC = [[HUZAgreementViewController alloc] init];
    agreementVC.url = model.jumpUrl;
    [self.navigationController pushViewController:agreementVC animated:true];
}
@end

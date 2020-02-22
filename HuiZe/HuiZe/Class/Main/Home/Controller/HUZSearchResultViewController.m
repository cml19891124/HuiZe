//
//  HUZSearchResultViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/19.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZSearchResultViewController.h"
#import "TYTabPagerBar.h"
#import "TYPagerController.h"
#import "HUZSearchMajorResultViewController.h"
#import "HUZSearchSchoolResultViewController.h"

@interface HUZSearchResultViewController ()<TYTabPagerBarDataSource,TYTabPagerBarDelegate,TYPagerControllerDataSource,TYPagerControllerDelegate>

@property (nonatomic,strong) UIView *ivRadioBg;
@property (nonatomic, weak) TYTabPagerBar *tabBar;
@property (nonatomic, weak) TYPagerController *pagerController;
@property (nonatomic,strong) HUZSearchSchoolResultViewController *searchSchooleResultVC;
@property (nonatomic,strong) HUZSearchMajorResultViewController *searchMajorResultVC;

@property (nonatomic,strong) NSArray *datas;
@end

@implementation HUZSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ColorS(COLOR_BG_F6F6F6);
}


- (void)configComponents{
    [super configComponents];
    
    self.datas = @[@"学校",@"专业"];
    
    [self addivRadioBg];
    [self addTabPageBar];
    [self addPagerController];

    _tabBar.frame = CGRectMake(0, AutoDistance(8), HUZSCREEN_WIDTH, AutoDistance(44));
    _pagerController.view.frame = CGRectMake(0, AutoDistance(52), HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT-AutoDistance(52));
    _pagerController.view.backgroundColor = [UIColor redColor];

    [_tabBar reloadData];
    [_pagerController reloadData];

    
}

- (void)addivRadioBg{
    self.ivRadioBg = [[UIView alloc] initWithFrame:CGRectMake(0, AutoDistance(8), HUZSCREEN_WIDTH, AutoDistance(44))];
    self.ivRadioBg.backgroundColor  = COLOR_BG_WHITE;
    [self.view addSubview:self.ivRadioBg];
    [UIView huz_bezierPathWithRoundedRect:self.ivRadioBg];
    UIView *ivDiviceline = [[UIView alloc] initWithFrame:CGRectMake(0, AutoDistance(42), HUZSCREEN_WIDTH, AutoDistance(2))];
    ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    [self.ivRadioBg addSubview:ivDiviceline];
}

- (void)addTabPageBar{
    TYTabPagerBar *tabBar = [[TYTabPagerBar alloc]init];
    tabBar.layout.barStyle = TYPagerBarStyleProgressView;
    tabBar.layout.cellWidth = HUZSCREEN_WIDTH/2.0;
    tabBar.layout.cellEdging = 0;
    tabBar.layout.cellSpacing = 0;
    tabBar.layout.normalTextFont = FontS(FONT_15);
    tabBar.layout.selectedTextFont = FontS(FONT_15);;
    tabBar.layout.normalTextColor = ColorS(COLOR_989898);
    tabBar.layout.selectedTextColor = ColorS(COLOR_2E86FF);
    tabBar.layout.progressColor = ColorS(COLOR_2E86FF);
    tabBar.dataSource = self;
    tabBar.delegate = self;
    [tabBar registerClass:[TYTabPagerBarCell class] forCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier]];
    [self.view addSubview:tabBar];
    _tabBar = tabBar;
}

- (void)addPagerController{
    TYPagerController *pagerController = [[TYPagerController alloc]init];
    pagerController.layout.prefetchItemCount = 1;
    pagerController.layout.addVisibleItemOnlyWhenScrollAnimatedEnd = YES;
    pagerController.dataSource = self;
    pagerController.delegate = self;
    pagerController.scrollView.bounces = NO;
    [self addChildViewController:pagerController];
    [self.view addSubview:pagerController.view];
    _pagerController = pagerController;
}

- (void)clickSearchWithKeyword:(NSString *)keyword{
    self.keyword = keyword;
    [self.searchSchooleResultVC searchUniWithKeyword:keyword];
    [self.searchMajorResultVC searchMajorWithkeyword:keyword];
}

#pragma mark - TYTabPagerBarDataSource
- (NSInteger)numberOfItemsInPagerTabBar{
    return _datas.count;
}

- (UICollectionViewCell<TYTabPagerBarCellProtocol> *)pagerTabBar:(TYTabPagerBar *)pagerTabBar cellForItemAtIndex:(NSInteger)index{
    UICollectionViewCell<TYTabPagerBarCellProtocol> *cell = [pagerTabBar dequeueReusableCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier] forIndex:index];
    cell.titleLabel.text = _datas[index];
    return cell;
}

#pragma mark - TYTabPagerBarDelegate

- (CGFloat)pagerTabBar:(TYTabPagerBar *)pagerTabBar widthForItemAtIndex:(NSInteger)index {
    NSString *title = _datas[index];
    return [pagerTabBar cellWidthForTitle:title];
}

- (void)pagerTabBar:(TYTabPagerBar *)pagerTabBar didSelectItemAtIndex:(NSInteger)index {
    [_pagerController scrollToControllerAtIndex:index animate:YES];
}

#pragma mark - TYPagerControllerDataSource

- (NSInteger)numberOfControllersInPagerController {
    return _datas.count;
}

- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching {
    if (index == 0) {
        self.searchSchooleResultVC  = [HUZSearchSchoolResultViewController new];
        if (self.keyword) {
            [self.searchSchooleResultVC searchUniWithKeyword:self.keyword];
        }
        return self.searchSchooleResultVC;
    }else{
        self.searchMajorResultVC = [HUZSearchMajorResultViewController new];
        self.searchMajorResultVC.isGotoMajor = self.isGotoMajor;
        if (self.keyword) {
            [self.searchMajorResultVC searchMajorWithkeyword:self.keyword];
            [self.pagerController scrollToControllerAtIndex:1 animate:true];
        }
        return self.searchMajorResultVC;
    }
}

#pragma mark - TYPagerControllerDelegate

- (void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex animated:(BOOL)animated {
    [_tabBar scrollToItemFromIndex:fromIndex toIndex:toIndex animate:animated];
}

-(void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress {
    [_tabBar scrollToItemFromIndex:fromIndex toIndex:toIndex progress:progress];
}
@end

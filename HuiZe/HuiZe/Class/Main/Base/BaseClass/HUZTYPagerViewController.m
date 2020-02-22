//
//  HUZTYPagerViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/24.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZTYPagerViewController.h"

@interface HUZTYPagerViewController ()

@end

@implementation HUZTYPagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    return [UIViewController new];
}
#pragma mark - TYPagerControllerDelegate
- (void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex animated:(BOOL)animated {
    [_tabBar scrollToItemFromIndex:fromIndex toIndex:toIndex animate:animated];
}
-(void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress {
    [_tabBar scrollToItemFromIndex:fromIndex toIndex:toIndex progress:progress];
}
@end

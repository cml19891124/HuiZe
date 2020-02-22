//
//  HUZAllMajorViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/29.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZAllMajorViewController.h"
#import "HUZPkListHeaderView.h"
#import "TYTabPagerBar.h"
#import "TYPagerController.h"
#import "HUZMajorListViewController.h"

@interface HUZAllMajorViewController ()<TYTabPagerBarDataSource,TYTabPagerBarDelegate,TYPagerControllerDataSource,TYPagerControllerDelegate,UITextFieldDelegate>{
    int _type;   /// 1专科 2本科
}

@property (nonatomic,strong) HUZPkListHeaderView *headerView;
@property (nonatomic,strong) UIView *ivRadioBg;
@property (nonatomic, weak) TYTabPagerBar *tabBar;
@property (nonatomic, weak) TYPagerController *pagerController;
@property (nonatomic,strong) HUZMajorListViewController *searchMajorListVC;

@property (nonatomic,strong) NSArray *datas;


@end

@implementation HUZAllMajorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"所有专业";
    self.view.backgroundColor = ColorS(COLOR_BG_F6F6F6);

}

- (void)configComponents{
    [super configComponents];
    
    self.datas = @[@"本科",@"专科"];
    
    [self.view addSubview:self.headerView];
    [self addivRadioBg];
    [self addTabPageBar];
    [self addPagerController];
    
    self.tabBar.frame = CGRectMake(0, AutoDistance(0), HUZSCREEN_WIDTH, AutoDistance(44));
    self.pagerController.view.frame = CGRectMake(0, AutoDistance(96), HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT-AutoDistance(96) );
    
    [self.tabBar reloadData];
    [self.pagerController reloadData];
    
    [self addChildViewController:self.searchMajorListVC];
    [self.view addSubview:self.searchMajorListVC.view];
    [self.searchMajorListVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(AutoDistance(44));
        make.left.bottom.right.equalTo(self.view);
    }];
    self.searchMajorListVC.view.hidden = YES;
    
    if (!DRStringIsEmpty(self.keyStr)) {
        self.headerView.tfKeyword.text = self.keyStr;
        self.tabBar.hidden = YES;
        self.pagerController.view.hidden = YES;
        self.searchMajorListVC.view.hidden = NO;
        [self.searchMajorListVC clickSearchMajorWithKeyword:self.keyStr type:_type];
    }
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
    HUZMajorListViewController *VC = [HUZMajorListViewController new];
    VC.type = index == 0 ? @"2" : @"1"; //1-专科 2-本科
    return VC;
}

#pragma mark - TYPagerControllerDelegate

- (void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex animated:(BOOL)animated {
    [_tabBar scrollToItemFromIndex:fromIndex toIndex:toIndex animate:animated];
    if (toIndex == 0) {
        self.headerView.tfKeyword.placeholder = @"搜索专业(本科)";
        _type = 2;
    }else{
        self.headerView.tfKeyword.placeholder = @"搜索专业(专科)";
        _type = 1;
    }
}

-(void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress {
    [_tabBar scrollToItemFromIndex:fromIndex toIndex:toIndex progress:progress];
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    self.tabBar.hidden = YES;
    self.pagerController.view.hidden = YES;
    self.searchMajorListVC.view.hidden = NO;
    [self.searchMajorListVC clickSearchMajorWithKeyword:textField.text type:_type];
    return YES;
}

- (void)tfKeywordChange:(UITextField *)tf{
    if (DRStringIsEmpty(tf.text)) {
        self.tabBar.hidden = NO;
        self.pagerController.view.hidden = NO;
        self.searchMajorListVC.view.hidden = YES;
    }else{
        self.tabBar.hidden = YES;
        self.pagerController.view.hidden = YES;
        self.searchMajorListVC.view.hidden = NO;
    }
    [self.searchMajorListVC clickSearchMajorWithKeyword:tf.text type:_type];
}


#pragma mark - UI
- (HUZPkListHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[HUZPkListHeaderView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(52))];
        _headerView.tfKeyword.delegate = self;
        [_headerView.tfKeyword addTarget:self action:@selector(tfKeywordChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _headerView;
}

- (HUZMajorListViewController *)searchMajorListVC{
    if (!_searchMajorListVC) {
        _searchMajorListVC = [HUZMajorListViewController new];
        _searchMajorListVC.isSearch = YES;
    }
    return _searchMajorListVC;
}

- (void)addivRadioBg{
    self.ivRadioBg = [[UIView alloc] initWithFrame:CGRectMake(0, AutoDistance(52), HUZSCREEN_WIDTH, AutoDistance(44))];
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
    [self.ivRadioBg addSubview:tabBar];
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

-(void)setKeyStr:(NSString *)keyStr {
    _keyStr = [keyStr copy];
}
@end

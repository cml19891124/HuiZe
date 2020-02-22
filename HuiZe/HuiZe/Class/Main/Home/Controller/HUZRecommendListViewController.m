//
//  HUZRecommendListViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/14.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZRecommendListViewController.h"
#import "HUZRecommendUniViewController.h"
#import "HUZRecommendMajorViewController.h"

@interface HUZRecommendListViewController (){
    NSInteger _index;  // 下标 0推荐院校 1推荐专业
}

@property (nonatomic,strong) HUZRecommendUniViewController *recommendUniVC;
@property (nonatomic,strong) HUZRecommendMajorViewController *recommendMajorVC;

@end

@implementation HUZRecommendListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"推荐列表";
    [self showBarButton:NAV_RIGHT title:@"默认排序" fontColor:ColorS(COLOR_2E86FF)];
}

- (void)rightButtonTouch{
    if (_index == 0) {
        [self.recommendUniVC reset];
    }else{
        [self.recommendMajorVC reset];
    }
}

- (void)configComponents{
    [super configComponents];
    
    self.datas = @[@"推荐学校",@"推荐专业"];
    
    [self addivRadioBg];
    [self addTabPageBar];
    [self addPagerController];
    
    self.tabBar.frame = CGRectMake(0, AutoDistance(8), HUZSCREEN_WIDTH, AutoDistance(44));
    self.pagerController.view.frame = CGRectMake(0, AutoDistance(52), HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT-AutoDistance(52));
    self.pagerController.view.backgroundColor = [UIColor redColor];
    
    [self.tabBar reloadData];
    [self.pagerController reloadData];
    
    if (self.type == 2) {
        [self.pagerController scrollToControllerAtIndex:1 animate:NO];
    }
    HUZWEAK_SELF;
    [self getVoluntaryTargetBatch:^(HUZTargetBatchDataModel * _Nonnull batchDataModel) {
        weakSelf.recommendUniVC.batchDataModel = batchDataModel;
        weakSelf.recommendMajorVC.batchDataModel = batchDataModel;
    }];
    
}


- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching {
    if (index == 0) {
        //self.recommendUniVC = [HUZRecommendUniViewController new];
        return self.recommendUniVC;
    }
    //self.recommendMajorVC = [HUZRecommendMajorViewController new];
    return self.recommendMajorVC;
}

#pragma mark - TYPagerControllerDelegate
- (void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex animated:(BOOL)animated {
    _index = toIndex;
    [self.tabBar scrollToItemFromIndex:fromIndex toIndex:toIndex animate:animated];
}
- (void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress {
    [self.tabBar scrollToItemFromIndex:fromIndex toIndex:toIndex progress:progress];
}

-(HUZRecommendUniViewController *)recommendUniVC {
    if (!_recommendUniVC) {
        _recommendUniVC = [[HUZRecommendUniViewController alloc] init];
    }
    return _recommendUniVC;
}
        
-(HUZRecommendMajorViewController *)recommendMajorVC {
    if (!_recommendMajorVC) {
        _recommendMajorVC = [[HUZRecommendMajorViewController alloc] init];
    }
    return _recommendMajorVC;
}
@end

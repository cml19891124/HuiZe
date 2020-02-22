//
//  HUZStudentPlanViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/23.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZStudentPlanViewController.h"
#import "HUZHomeBannerView.h"
#import "HUZCurrentStudentsPlanTableView.h"
#import "HUZHistoryStudentsPlanTableView.h"
#import "HUZAgreementViewController.h"

@interface HUZStudentPlanViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic,strong) HUZHomeBannerView *topView;
@property (nonatomic,strong) HUZCurrentStudentsPlanTableView *currentStudenetsPlanTableView;
@property (nonatomic,strong) HUZHistoryStudentsPlanTableView *historyStudentsPlanTableView;

@end

@implementation HUZStudentPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    self.navigationItem.title = @"招生计划";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateStateAction:) name:HUZVIPUpdate_State_Noti_Key object:nil];
}

-(void)updateStateAction:(NSNotification *)noti {
    self.currentStudenetsPlanTableView.vipState = [HUZUserCenterManager.userModel.vip integerValue];
    self.historyStudentsPlanTableView.vipState = [HUZUserCenterManager.userModel.vip integerValue];
}

- (void)configComponents{
    [super configComponents];
    
    self.dataSegment = @[@"2019招生计划",@"历年招生计划"];
    
    self.currentStudenetsPlanTableView = [[HUZCurrentStudentsPlanTableView alloc] init];

    self.historyStudentsPlanTableView = [[HUZHistoryStudentsPlanTableView alloc] init];
    
    [self.segTableView setTableViews:@[self.currentStudenetsPlanTableView,self.historyStudentsPlanTableView]];
    [self.view addSubview:self.segTableView];
    [self.segTableView setTopView:self.topView];
    
    [self loadBanner];
    [self updateStateAction:nil];
}

/// banner图
- (void)loadBanner{
    HUZWEAK_SELF
    [HUZHomeService getBanner:@{@"type":@"4"} success:^(HUZBannerModel * model) {
        HUZSTRONG_SELF
        strongSelf.topView.banners = model.data;
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf presentErrorSheet:errorStr];
    }];
}


#pragma mark - Lazy
- (HUZHomeBannerView *)topView{
    CGFloat H = HUZSCREEN_WIDTH >= 414 ? 195 : 172;
    if (!_topView) {
        _topView = [[HUZHomeBannerView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, H)];
        _topView.cycleScrollView.delegate = self;
    }
    return _topView;
}


/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    HUZBannerDataModel *model = nil;
    if (self.topView.banners.count > index) {
        model = self.topView.banners[index];
    }
    
    HUZAgreementViewController *agreementVC = [[HUZAgreementViewController alloc] init];
    agreementVC.url = model.jumpUrl;
    [self.navigationController pushViewController:agreementVC animated:true];
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    
}
@end

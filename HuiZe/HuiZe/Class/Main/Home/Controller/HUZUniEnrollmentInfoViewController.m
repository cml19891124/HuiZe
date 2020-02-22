//
//  HUZUniEnrollmentInfoViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/26.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniEnrollmentInfoViewController.h"
#import "HUZUniMajorHeaderView.h"
#import "HUZAllMajorTableView.h"
#import "HUZNewestEnrollmentPlanTableView.h"
#import "HUZUniInfoGeneralizeModel.h"

#import "HUZUninfoHistoryEnrollmentTableView.h"
#import "HUZUninfoNewestEnrollmentPlanTableView.h"

@interface HUZUniEnrollmentInfoViewController ()

@property (nonatomic,strong) HUZUniMajorHeaderView *enrollmentHedaerView;

@property (nonatomic,strong) HUZUninfoHistoryEnrollmentTableView *historyEnrollmentTableView;
//@property (nonatomic,strong) HUZNewestEnrollmentPlanTableView *newestEnrollmentPlanTableView;
@property (nonatomic,strong) HUZUninfoNewestEnrollmentPlanTableView *newestEnrollmentPlanTableView;
@end


@implementation HUZUniEnrollmentInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"具体招录情况";
}

- (void)configComponents{
    [super configComponents];
    
    self.dataSegment = @[@"专业历年录取",@"最新招生计划"];
    
    /// 专业历年录取
    self.historyEnrollmentTableView = [[HUZUninfoHistoryEnrollmentTableView alloc] init];
    //self.historyEnrollmentTableView.type = 3;
    self.historyEnrollmentTableView.schoolId = self.schoolId;
    
//    self.historyEnrollmentTableView.datas = @[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"];

    /// 最新招生计划
//    self.newestEnrollmentPlanTableView = [[HUZNewestEnrollmentPlanTableView alloc] init];
//    self.newestEnrollmentPlanTableView.datas = @[@"1",@"1",@"1"];
    self.newestEnrollmentPlanTableView = [[HUZUninfoNewestEnrollmentPlanTableView alloc] init];
    //self.newestEnrollmentPlanTableView.type = 1;
    self.newestEnrollmentPlanTableView.schoolId = self.schoolId;
    
    

    [self.segTableView setTableViews:@[self.historyEnrollmentTableView,self.newestEnrollmentPlanTableView]];
    [self.view addSubview:self.segTableView];
    [self.segTableView setTopView:self.uniMajorHeaderView];
    [self loadHeaderInfo];
}

- (void)loadHeaderInfo{
    HUZWEAK_SELF
    
    [HUZNetWorkTool huz_GET:[NSString stringWithFormat:@"%@/%@",KUrl_UniInfo,self.schoolId] parameters:@{} success:^(id  _Nonnull responseObject) {
        HUZSTRONG_SELF
        NSString *codeStr = [responseObject valueForKey:@"code"];
        if ([codeStr integerValue] == 0) {
            HUZUniInfoGeneralizeDataModel *model = [HUZUniInfoGeneralizeDataModel modelWithJSON:responseObject[@"data"]];
            self.uniMajorHeaderView.infoModel = model;
        }else{
            [strongSelf presentErrorSheet:responseObject[@"msg"]];
        }
        [strongSelf removeOverFlowActivityView];
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        [strongSelf presentErrorSheet:error];
    }];
}

#pragma mark - Lazy
- (HUZUniMajorHeaderView *)uniMajorHeaderView{
    CGFloat H = HUZSCREEN_WIDTH >= 414 ? 105 : 90;
    if (!_enrollmentHedaerView) {
        _enrollmentHedaerView = [[HUZUniMajorHeaderView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, H)];
    }
    return _enrollmentHedaerView;
}

@end

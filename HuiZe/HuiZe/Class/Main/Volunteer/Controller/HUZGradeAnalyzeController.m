//
//  HUZGradeAnalyzeController.m
//  HuiZe
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZGradeAnalyzeController.h"
#import "HUZGradeAnalyzeHeadView.h"
#import "HUZVolunteerService.h"

@interface HUZGradeAnalyzeController ()<HUZPPPSelectViewDelegate>
{
        NSString *_scoreSectionYear;  /// 一分一段年份
}
@property (strong, nonatomic)HUZGradeAnalyzeHeadView *headView;
@property (nonatomic,strong) HUZPPPSelectView *scoreSectionYearView;

@end

@implementation HUZGradeAnalyzeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的成绩分析";

}

- (void)configComponents{
    [super configComponents];
    
    /// 年份
    _scoreSectionYear = HUZDataBaseManager.dataYear[0];
    self.tableView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    self.tableView.tableHeaderView = self.headView;
}

- (void)configDatas {
    [super configDatas];
    [self loadScoreSectionData];
    [self loadAnalysisData];
}

- (HUZGradeAnalyzeHeadView *)headView {
    if (!_headView) {
        _headView = [[HUZGradeAnalyzeHeadView alloc]initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT * 1.5)];
        [_headView.gkInfoView.btnYear addTarget:self action:@selector(clickScoreSectionYear) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headView;
}

#pragma mark NETWork
/// 一分一段
- (void)loadScoreSectionData{
    HUZWEAK_SELF
    [self displayOverFlowActivityView];
    [HUZHomeService getScoreSection:@{@"year":_scoreSectionYear} success:^(HUZKernalScoreSectionModel * model) {
        [weakSelf removeOverFlowActivityView];
        weakSelf.headView.gkInfoView.scoreSectionModel = model;
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        [weakSelf removeOverFlowActivityView];
        [weakSelf presentErrorSheet:errorStr];
    }];
}
/// 我的成绩分析
- (void)loadAnalysisData{
    HUZWEAK_SELF
    [self displayOverFlowActivityView];
    [HUZVolunteerService getVolunteerScoreAnalysisWithParamters:@{@"year":_scoreSectionYear} success:^(HUZGradeAnalyzeModel * _Nonnull model) {
        [weakSelf removeOverFlowActivityView];
        weakSelf.headView.model = model;
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        [weakSelf removeOverFlowActivityView];
        [weakSelf presentErrorSheet:errorStr];
        
    }];
}
#pragma mark HUZPPPSelectViewDelegate
- (void)pppSelectViewDelegateWith:(HUZPPPSelectView *)selectView indexPath:(NSIndexPath*)indexPAth result:(NSString *)result{
    /// 一分一段年份
    _scoreSectionYear = result;
    [self.headView.gkInfoView.btnYear setTitle:result forState:UIControlStateNormal];
    [self loadScoreSectionData];
    [self loadAnalysisData];
}

#pragma mark Action
/// 一分一段选择年份
- (void)clickScoreSectionYear{
    [self.scoreSectionYearView show];
}

- (HUZPPPSelectView *)scoreSectionYearView{
    if (!_scoreSectionYearView) {
        _scoreSectionYearView = [HUZPPPSelectView new];
        _scoreSectionYearView.headTitle = @"选择您要查看的年份";
        _scoreSectionYearView.dataArray = HUZDataBaseManager.dataYear.mutableCopy;
        _scoreSectionYearView.delegate = self;
        _scoreSectionYearView.tag = 1;
    }
    return _scoreSectionYearView;
}

@end

//
//  HUZUniMajorInfoVC.m
//  HuiZe
//
//  Created by tbb on 2019/11/18.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZUniMajorInfoVC.h"
#import "HUZUniInfoCommonCell.h"
#import "HUZUniMajorHeaderView.h"
#import "HUZUniInfoGeneralizeModel.h"
#import "HUZMajorInfoViewController.h"
@interface HUZUniMajorInfoVC ()
@property (nonatomic,strong) HUZUniMajorHeaderView *uniMajorHeaderView;
@end

@implementation HUZUniMajorInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"该校专业详情";
    self.style = UITableViewStyleGrouped;
    [self.tableView registerClass:[HUZUniInfoCommonCell class] forCellReuseIdentifier:@"HUZUniInfoCommonCell"];
    self.tableView.tableHeaderView = self.uniMajorHeaderView;
    self.uniMajorHeaderView.infoModel = self.infoModel;
    [self setupRefresh:self.tableView];
    [self onStartRefresh];
}

-(void)onStartRefresh {
    self.page = 1;
    [self getSubjectMajorList];
}

-(void)onStartLoadMore {
    self.page ++;
    [self getSubjectMajorList];
}

-(void)getSubjectMajorList{
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    par[@"schoolId"] = self.infoModel.schoolId;
    par[@"pageSize"] = @"10";
    par[@"pageNow"] = @(self.page);
//    [self displayOverFlowActivityView];
    [HUZNetWorkTool huz_POSTWithForm:kUrl_subject_majorList parameters:par success:^(id  _Nonnull responseObject) {
        [self stopRefresh:self.tableView];
//        [self removeOverFlowActivityView];
        NSString *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([codeStr integerValue] == 0) {
            if (self.page == 1) {
                [self.dataSource removeAllObjects];
            }
            NSArray *arr = [NSArray modelArrayWithClass:[HUZUniInfoGeneralizeMajorModel class] json:responseObject[@"data"][@"list"]];
            [self.dataSource addObjectsFromArray:arr];
            [self.tableView reloadData];
        }else{
            [self presentErrorSheet:responseObject[@"msg"]];
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
//        [self removeOverFlowActivityView];
        [self stopRefresh:self.tableView];
        [self presentErrorSheet:error];
    }];
}


#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HUZUniInfoCommonCell *cell = [HUZUniInfoCommonCell cellWithTableView:tableView];
    HUZUniInfoGeneralizeMajorModel * majorModel = nil;
    if (indexPath.row < self.dataSource.count) {
        majorModel = self.dataSource[indexPath.row];
    }
    [cell reloadData:majorModel indexPath:indexPath];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [HUZUniInfoCommonCell calculateHeightWithEntity:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HUZUniInfoGeneralizeMajorModel * majorModel = nil;
    if (indexPath.row < self.dataSource.count) {
        majorModel = self.dataSource[indexPath.row];
    }
    
    HUZMajorInfoViewController *majorInfoVC = [HUZMajorInfoViewController new];
    majorInfoVC.majorId = majorModel.majorAllId;
    [[UIViewController currentViewController].navigationController pushViewController:majorInfoVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}
#pragma mark - UITableViewDelegate, UITableViewDataSource end

#pragma mark - Lazy
- (HUZUniMajorHeaderView *)uniMajorHeaderView{
    CGFloat H = HUZSCREEN_WIDTH >= 414 ? 105 : 90;
    if (!_uniMajorHeaderView) {
        _uniMajorHeaderView = [[HUZUniMajorHeaderView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, H)];
    }
    return _uniMajorHeaderView;
}
#pragma mark - Lazy end

@end

//
//  HUZSearchMajorAllAssessVC.m
//  HuiZe
//
//  Created by tbb on 2019/11/13.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZSearchMajorAllAssessVC.h"
#import "HUZSearchMajorAllAssessCell.h"
#import "HUZSearchMajorAllAssessHeader.h"
#import "HUZSearchMajorAllAssessModel.h"
#import "HUZMajorRankingListViewController.h"
@interface HUZSearchMajorAllAssessVC ()

@end

@implementation HUZSearchMajorAllAssessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"所有学科";
    [self.tableView registerNib:[UINib nibWithNibName:@"HUZSearchMajorAllAssessCell" bundle:nil] forCellReuseIdentifier:@"HUZSearchMajorAllAssessCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HUZSearchMajorAllAssessHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"HUZSearchMajorAllAssessHeader"];
    
    
    UIAlertController *alterCV = [UIAlertController alertControllerWithTitle:@"" message:@"学科评估是教育部学位与研究生教育发展中心对全国具有博士或硕士学位授予权的一级学科开展的整体水平评估。第四轮学科评估结果按“分档”方式呈现，具体方法是按“学科整体水平得分”的位次百分位，将前70%的学科分9档公布：前2%（或前2名）为A+，2%～5%为A（不含2%，下同），5%～10%为A-，10%～20%为B+，20%～30%为B，30%～40%为B-，40%～50%为C+，50%～60%为C，60%～70%为C-。评估结果旨在为学生选报学科、专业提供参考。" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okBtn = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alterCV addAction:okBtn];
    [self presentViewController:alterCV animated:YES completion:nil];
    [self getAssessData];
}

-(void)getAssessData {
    [HUZNetWorkTool huz_GET:kUrl_Assess_List parameters:nil success:^(id  _Nonnull responseObject) {
        NSString *codeStr = responseObject[@"code"];
        if ([codeStr integerValue] == 0) {
            [self.dataSource removeAllObjects];
            NSArray *arr = [NSArray modelArrayWithClass:[HUZSearchMajorAllAssessModel class] json:responseObject[@"data"]];
            [self.dataSource addObjectsFromArray:arr];
            [self.tableView reloadData];
        }else{
            [self presentErrorSheet:responseObject[@"msg"]];
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        [self presentErrorSheet:error];
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    HUZSearchMajorAllAssessModel *assessModel = nil;
    if (section < self.dataSource.count) {
        assessModel = self.dataSource[section];
    }
    if (assessModel.isOpen) {
        return assessModel.child.count;
    }else{
        return 0;
    }
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HUZSearchMajorAllAssessModel *assessModel = nil;
    if (indexPath.section < self.dataSource.count) {
        assessModel = self.dataSource[indexPath.section];
    }
    
    HUZSearchMajorAllAssessChildModel *childModel = nil;
    if (indexPath.row < assessModel.child.count) {
        childModel = assessModel.child[indexPath.row];
    }
    
    HUZSearchMajorAllAssessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HUZSearchMajorAllAssessCell"];
    cell.categoryLb.text = childModel.category;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HUZSearchMajorAllAssessModel *assessModel = nil;
    if (indexPath.section < self.dataSource.count) {
        assessModel = self.dataSource[indexPath.section];
    }
    
    HUZSearchMajorAllAssessChildModel *childModel = nil;
    if (indexPath.row < assessModel.child.count) {
        childModel = assessModel.child[indexPath.row];
    }
    
    HUZMajorRankingListViewController *majorRankingListVC = [HUZMajorRankingListViewController new];
    majorRankingListVC.navTitle = childModel.category;
    majorRankingListVC.assessMajorId = childModel.Id;
    [self.navigationController pushViewController:majorRankingListVC animated:YES];

}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    HUZSearchMajorAllAssessModel *assessModel = nil;
    if (section < self.dataSource.count) {
        assessModel = self.dataSource[section];
    }
    
    HUZSearchMajorAllAssessHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HUZSearchMajorAllAssessHeader"];
    header.titleLb.text = assessModel.category;
    header.leftBtn.selected = assessModel.isOpen;
    HUZWEAK_SELF;
    [header addTapAction:^(id  _Nonnull sender) {
        assessModel.isOpen = !assessModel.isOpen;
        [weakSelf.tableView reloadData];
    }];
    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}
#pragma mark - UITableViewDelegate, UITableViewDataSource end

@end

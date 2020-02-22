//
//  HUZNewestEnrollmentPlanTableView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/26.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZNewestEnrollmentPlanTableView.h"
#import "HUZCurrentStudentsPlanSectionView.h"
#import "HUZNewestEnrollmentPlanCell.h"

@implementation HUZNewestEnrollmentPlanTableView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.rowHeight = AutoDistance(82);
        [self dz_registerCell:[HUZNewestEnrollmentPlanCell class]];
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HUZNewestEnrollmentPlanCell *cell = [HUZNewestEnrollmentPlanCell cellWithTableView:tableView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AutoDistance(44);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HUZCurrentStudentsPlanSectionView *newestEnrollmentPlanSecionView = [[HUZCurrentStudentsPlanSectionView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(44))];
    return newestEnrollmentPlanSecionView;
}
@end

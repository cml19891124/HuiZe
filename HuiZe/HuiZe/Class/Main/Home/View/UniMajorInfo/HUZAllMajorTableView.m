//
//  HUZAllMajorTableView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/26.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZAllMajorTableView.h"
#import "HUZHistoryStudentsPlanSectionView.h"
#import "HUZUniEnrollmentDataThirdCell.h"
#import "HUZUniInfoGeneralizeModel.h"
#import "HUZMajorInfoViewController.h"
//#import "HUZUniInfoGeneralizeMajorModel.h"
@implementation HUZAllMajorTableView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.rowHeight = AutoDistance(82);
        [self dz_registerCell:[HUZUniEnrollmentDataThirdCell class]];
        
    }
    return self;
}
-(void)setSchoolId:(NSString *)schoolId {
    _schoolId = [schoolId copy];
    [self getSubjectData];
}
-(void)getSubjectData{
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    par[@"schoolId"] = self.schoolId;
    par[@"pageSize"] = @"1000";
    par[@"pageNow"] = @"1";
    par[@"characteristic"] = (self.type == HUZSpecialMajor) ? @"0" : @"1";
    
    HUZWEAK_SELF;
    [HUZNetWorkTool huz_POST:kUrl_subject_query parameters:par success:^(id  _Nonnull responseObject) {
        self.datas = [NSArray modelArrayWithClass:[HUZUniInfoGeneralizeMajorModel class] json:responseObject[@"data"][@"list"]];
        [weakSelf reloadData];
    } failure:^(NSUInteger statusCode, NSString *error) {
        
    }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HUZUniEnrollmentDataThirdCell *cell = [HUZUniEnrollmentDataThirdCell cellWithTableView:tableView];
    
    HUZUniInfoGeneralizeMajorModel *majorModel = nil;
    if (self.datas.count > indexPath.row) {
        majorModel = self.datas[indexPath.row];
    }
    cell.majorModel = majorModel;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AutoDistance(80);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HUZUniInfoGeneralizeMajorModel *majorModel = nil;
    if (self.datas.count > indexPath.row) {
        majorModel = self.datas[indexPath.row];
    }
    
    HUZMajorInfoViewController *VC = [[HUZMajorInfoViewController alloc] init];
    VC.majorId = majorModel.majorAllId;
    [self.YQViewController.navigationController pushViewController:VC animated:true];
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return AutoDistance(44);
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    HUZHistoryStudentsPlanSectionView *historyStudentsPlanSectionView = [[HUZHistoryStudentsPlanSectionView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(44))];
//    return historyStudentsPlanSectionView;
//}


@end

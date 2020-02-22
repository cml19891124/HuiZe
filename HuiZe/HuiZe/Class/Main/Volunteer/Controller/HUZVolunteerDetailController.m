//
//  HUZVolunteerDetailController.m
//  HuiZe
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZVolunteerDetailController.h"
#import "HUZVolunteerDetailView.h"
#import "HUZUniMajorCell.h"
#import "HUZVolunteerAnalyzeController.h"
#import "HUZIntelligenceDetailModel.h"
#import "HUZVolunteerService.h"
#import "HUZUniEnrollmentInfoViewController.h"
#import "HUZFillVolunteerController.h"
@interface HUZVolunteerDetailController ()
{
    NSArray *sectionArray;
}
@property (strong, nonatomic) HUZVolunteerDetailView *headView;
@property (nonatomic, strong) HUZIntelligenceDetailDataModel * dataModel;

@property (nonatomic, strong) NSMutableDictionary * showDict;

@property (nonatomic, copy) NSArray * letterArr;
@end

@implementation HUZVolunteerDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.volatileTitle;
    
    [self showBarButton:NAV_RIGHT title:@"修改" fontColor:ColorS(COLOR_2E86FF)];
    self.letterArr = @[@"A.",@"B.",@"C.",@"D.",@"E.",@"F.",@"G.",@"H.",
    @"I.",@"J.",@"K.",@"L.",@"M.",@"N.",@"O.",@"P.",
    @"Q.",@"R.",@"S.",@"T.",@"U.",@"V.",@"W.",@"X.",
    @"Y.",@"Z."];
}

- (void)rightButtonTouch{
    NSMutableArray *batchUniversity1Arr = [NSMutableArray array];
    NSMutableArray *batchUniversity2Arr = [NSMutableArray array];
    NSMutableArray *batchUniversity3Arr = [NSMutableArray array];
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    
    for(NSInteger i = 0; i < self.dataSource.count; i++) {
        NSArray *schoolArr = self.dataSource[i];
        for (HUZDetailDataVolunteerSchoolEntityModel *selectSchoolModel in schoolArr) {
            HUZSchoolModel *schoolModel = [HUZSchoolModel modelWithJSON:[selectSchoolModel modelToJSONString]];
            NSLog(@"");
            NSMutableArray *selectMajorArr = [NSMutableArray array];
            for (HUZDetailDataVolunteerMajorAllEntitiesModel *subjctModel in selectSchoolModel.majorAllEntities) {
                HUZUniInfoGeneralizeMajorModel *majorModel = [HUZUniInfoGeneralizeMajorModel new];
                majorModel.majIntroduce = subjctModel.category;
                majorModel.majorAllId = subjctModel.majorAllId;
                //majorModel.alternativeMajorId = subjctModel.alternativeMajorId;
                [selectMajorArr addObject:majorModel];
            }
            schoolModel.major = selectMajorArr.copy;
            if ([schoolModel.batch integerValue] == 1) {
                [batchUniversity1Arr addObject:schoolModel];
            }else if ([schoolModel.batch integerValue] == 2) {
                [batchUniversity2Arr addObject:schoolModel];
            }else{
                [batchUniversity3Arr addObject:schoolModel];
            }
        }
        
    }
    if (batchUniversity1Arr.count > 0) {
        par[@"1"] = batchUniversity1Arr;
    }
    if (batchUniversity2Arr.count > 0) {
        par[@"2"] = batchUniversity2Arr;
    }
    
    if (batchUniversity3Arr.count > 0) {
        par[@"4"] = batchUniversity3Arr;
    }
    
    HUZFillVolunteerController *packet = [HUZFillVolunteerController new];
    packet.volunteerDict = par.copy;
    packet.volunteerNmae = self.headView.dataModel.volunteerName;
    packet.volunteerId = self.ID;
    [self.navigationController pushViewController:packet animated:YES];
}

- (void)configComponents {
    [super configComponents];
    
    self.shouldMultiSections = YES;
    sectionArray = @[@"本科一批", @"本科二批", @"专科(高职批)"];
//    sectionArray = @[@"填报学校"];
//    self.dataSource = @[@[@"1", @"1", @"1", @"1"], @[@"1"]].mutableCopy;
//    self.cellHeight = AutoDistance(144);
    self.tableView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    [self.tableView dz_registerCell:[HUZUniMajorCell class]];
    self.tableView.tableHeaderView = self.headView;
}

- (void)configDatas {
    [super configDatas];
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:self.ID forKey:@"id"]; // 男女比例 self.ID
    HUZWEAK_SELF;
    [self displayOverFlowActivityView];
    [HUZVolunteerService getVolunteerIntelligenceTestFormDetailWithParamters:postDic success:^(HUZIntelligenceDetailModel *_Nonnull detailModel) {
        
        [self.dataSource removeAllObjects];
        self.dataModel = detailModel.data;
        weakSelf.headView.dataModel = detailModel.data;
        [weakSelf removeOverFlowActivityView];
//        [self.dataSource addObject:self.dataModel.volunteerSchoolEntity];
//        [self.dataSource addObjectsFromArray:self.dataModel.volunteerSchoolEntity];
        NSMutableArray *batch1Arr = [NSMutableArray array];
        NSMutableArray *batch2Arr = [NSMutableArray array];
        NSMutableArray *batch4Arr = [NSMutableArray array]; //专科
//        NSMutableArray *otherArr = [NSMutableArray array]; //其它
        
        for(HUZDetailDataVolunteerSchoolEntityModel *model in detailModel.data.volunteerSchoolEntity) {
            if (model.batch == 1) {
                [batch1Arr addObject:model];
            }else if (model.batch == 2){
                [batch2Arr addObject:model];
            } else if (model.batch == 4) {
                [batch4Arr addObject:model];
            }
        }
        [self.dataSource addObject:batch1Arr];
        [self.dataSource addObject:batch2Arr];
        [self.dataSource addObject:batch4Arr];
//        if (batch1Arr.count > 0) {
//            [self.dataSource addObject:batch1Arr];
//        }
//
//        if(batch2Arr.count > 0) {
//            [self.dataSource addObject:batch1Arr];
//        }
//
//        if (batch4Arr.count > 0) {
//            [self.dataSource addObject:batch4Arr];
//        }
        
        if (DRArrayIsEmpty(weakSelf.dataSource)) {
            [weakSelf configEmptyViewWithError:EMPTYDATA];
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        [weakSelf removeOverFlowActivityView];
        [weakSelf presentErrorSheet:errorStr];
    }];
}

- (void)configStyle{
    self.style = UITableViewStyleGrouped;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return sectionArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataSource.count > section) {
        NSArray *arr = self.dataSource[section];
        NSString *key = [NSString stringWithFormat:@"%zd",section];
        if (![self.showDict.allKeys containsObject:key] || [self.showDict[key] isEqualToString:@"0"]) {
            return 0;
        }
        return arr.count;
    }else{
        return 0;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AutoDistance(58);
}

/// dequeueReusableCell
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    HUZUniMajorCell *cell = [HUZUniMajorCell cellWithTableView:tableView];
    NSArray *arr = nil;
    if (indexPath.section < self.dataSource.count) {
        arr = self.dataSource[indexPath.section];
    }
    HUZDetailDataVolunteerSchoolEntityModel *schoolModel = nil;
    if (indexPath.row < arr.count) {
        schoolModel = arr[indexPath.row];
    }
    cell.schoolModel = schoolModel;
    cell.iLab.text = self.letterArr[indexPath.row];//[NSString stringWithFormat:@"%zd",indexPath.row + 1];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *arr = nil;
    if (indexPath.section < self.dataSource.count) {
        arr = self.dataSource[indexPath.section];
    }
    HUZDetailDataVolunteerSchoolEntityModel *schoolModel = nil;
    if (indexPath.row < arr.count) {
        schoolModel = arr[indexPath.row];
    }
    if (schoolModel.majorAllEntities.count > 3) {
            return AutoDistance(144);
    }
    return AutoDistance(144) - AutoDistance(44);
}

/// configure cell data
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *arr = nil;
    if (indexPath.section < self.dataSource.count) {
        arr = self.dataSource[indexPath.section];
    }
    HUZDetailDataVolunteerSchoolEntityModel *schoolModel = nil;
    if (indexPath.row < arr.count) {
        schoolModel = arr[indexPath.row];
    }
    
    HUZUniEnrollmentInfoViewController *uniEnrollmentInfoVC = [HUZUniEnrollmentInfoViewController new];
    uniEnrollmentInfoVC.schoolId = schoolModel.schoolId;
    [[UIViewController currentViewController].navigationController pushViewController:uniEnrollmentInfoVC animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(58))];
    view.backgroundColor = COLOR_BG_WHITE;
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(AutoDistance(15), AutoDistance(17), AutoDistance(175), AutoDistance(25))];
    lab.text = sectionArray[section];
    [view addSubview:lab];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(HUZSCREEN_WIDTH - AutoDistance(175) - AutoDistance(20), AutoDistance(14), AutoDistance(175), AutoDistance(30))];
    NSString *key = [NSString stringWithFormat:@"%zd",section];
    if (![self.showDict.allKeys containsObject:key] || [self.showDict[key] isEqualToString:@"0"]) {
        [button setImage:ImageNamed(@"ic_btn_down") forState:UIControlStateNormal];
    }else{
        [button setImage:ImageNamed(@"ic_btn_top") forState:UIControlStateNormal];
    }
    
    CGFloat spacing = 8.0;
    CGSize imageSize = button.imageView.frame.size;
    button.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, 0.0, imageSize.width + spacing);
    CGSize titleSize = button.titleLabel.frame.size;
    button.imageEdgeInsets = UIEdgeInsetsMake(0.0, titleSize.width + spacing, 0.0, - titleSize.width);
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    button.tag = 110000 + section;
    [button addTarget:self action:@selector(sectionClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
//    NSArray *arr = nil;
//    if (section < self.dataSource.count) {
//        arr = self.dataSource[section];
//    }
//    if (arr) {
//        <#statements#>
//    }
    
    return view;
}

- (void)sectionClick:(UIButton*)btn {
    NSString *key = [NSString stringWithFormat:@"%zd",btn.tag - 110000];
    if (![self.showDict.allKeys containsObject:key] || [self.showDict[key] isEqualToString:@"0"]) {
        self.showDict[key] = @"1";
    }else{
        self.showDict[key] = @"0";
    }
    [self.tableView reloadData];
}

- (HUZVolunteerDetailView *)headView {
    __weak typeof(self)weakSelf = self;
    if (!_headView) {
        _headView = [[HUZVolunteerDetailView alloc]initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(131)-AutoDistance(45)+10)];
        _headView.detailBlock = ^{
            HUZVolunteerAnalyzeController *analyze = [HUZVolunteerAnalyzeController new];
            analyze.volunteerId = weakSelf.ID;
            analyze.reasonable = self.dataModel.reasonable;
            [weakSelf.navigationController pushViewController:analyze animated:YES];
        };
    }
    return _headView;
}

-(NSMutableDictionary *)showDict {
    if (!_showDict) {
        _showDict = [NSMutableDictionary dictionary];
        _showDict[@"0"] = @"1";
        _showDict[@"1"] = @"1";
        _showDict[@"2"] = @"1";
    }
    return _showDict;
}

@end

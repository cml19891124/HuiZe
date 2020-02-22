//
//  HUZManualFillVolunteerController.m
//  HuiZe
//
//  Created by mac on 2019/5/5.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZManualFillVolunteerController.h"
#import "HUZVolunteerBottomView.h"
#import "HUZUniFillCell.h"
#import "HUZVolUniDetailViewController.h"
#import "HUZUniMajorViewController.h"
#import "HUZVolunteerSelectController.h"
#import "HUZVolFillResultController.h"
#import "HUZUniSelectController.h"
#import "HUZMyGkInfoViewController.h"

#import "HUZHomeService.h"

#import "HUZSchoolListDataModel.h"

#import <sqlite3.h>

#import "BGFMDB.h"

#import "HUZPacketVolModel.h"

#define DBNAME @"schoolinfo.sqlite"

#define LogoUrl @"logoUrl"

#define UniCity @"uniCity"

#define Batch @"batch"

#define SchoolName @"schoolName"

#define SchoolId @"schoolId"

#define TABLENAME @"SCHOOLINFO"

@interface HUZManualFillVolunteerController ()
{
    NSArray *sectionArray;
    sqlite3 *db;
    
}
@property (nonatomic,strong) HUZVolunteerBottomView *viewBotm;
@property (nonatomic,copy) NSString *name;

@property (strong, nonatomic) NSMutableArray *dataBatch;

@property (strong, nonatomic) NSMutableArray *headSectionArray;

@property (strong, nonatomic) NSMutableArray *cellStates;

@property (strong, nonatomic) NSMutableDictionary *cellHeightDict;

@property (strong, nonatomic) HUZSchoolModel *model;

@property (strong, nonatomic) NSMutableArray *majorArray;

@end

@implementation HUZManualFillVolunteerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"填报";
    self.name = @"请输入志愿表名称";

}

- (void)deleteSchoolData:(UIButton *)button
{
    [NSArray bg_deleteObjectWithName:@"schoolArray" Index:button.tag - 20000];
    HUZJudgeBatchDataModel *batchModel = self.dataSource[button.tag - 20000];
    [batchModel setValue:nil forKey:@"schoolArray"];

    [self exqerySchoolInfo];

}

- (void)SelectSchoolData
{
    [self.dataSource removeAllObjects];

    NSString *sqlQuery = @"SELECT * FROM SCHOOLINFO";
    
    sqlite3_stmt * statement;
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            char *logoName = (char*)sqlite3_column_text(statement, 1);
            NSString *logoUrl = [[NSString alloc]initWithUTF8String:logoName];
            
            char *cityName = (char*)sqlite3_column_text(statement, 2);
            NSString *uniCity = [[NSString alloc]initWithUTF8String:cityName];

            char *batchName = (char*)sqlite3_column_text(statement, 3);
            NSString *batch = [[NSString alloc]initWithUTF8String:batchName];
            
            char *schoolStr = (char*)sqlite3_column_text(statement, 4);
            NSString *schoolName = [[NSString alloc]initWithUTF8String:schoolStr];
            
            char *schoolID = (char*)sqlite3_column_text(statement, 5);
            NSString *schoolId = [[NSString alloc]initWithUTF8String:schoolID];
            NSLog(@"LogoUrl:%@ UniCity:%@, Batch:%@, SchoolName:%@, SchoolId:%@",logoUrl,uniCity,batch,schoolName,schoolId);
            
            HUZSchoolModel *model = [HUZSchoolModel new];
            model.logoUrl = logoUrl;
            model.uniCity = uniCity;
            model.batch = batch;
            model.schoolName = schoolName;
            model.schoolId = schoolId;
            [self.dataSource addObject:model];

            }
        [self.tableView reloadData];

        }
    
    sqlite3_close(db);
}

- (void)configComponents{
    
    [super configComponents];
    
    self.headSectionArray = [NSMutableArray array];
    
    self.dataSource = [NSMutableArray array];
    
    self.majorArray = [NSMutableArray array];

    self.cellStates = [NSMutableArray array];

    [self exqerySchoolInfo];
    
    [self loadData];
    self.tableView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    self.view.backgroundColor = self.tableView.backgroundColor;
    self.shouldMultiSections = YES;
//    self.name = @"志愿表01";

    [self setDataSourceConfig];
    
    self.viewBotm = [[HUZVolunteerBottomView alloc]initWithFrame:CGRectMake(0, HUZSCREEN_HEIGHT - HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT - AutoDistance(49), HUZSCREEN_WIDTH, AutoDistance(49))];
    self.viewBotm.viewBotm.backgroundColor = ColorS(COLOR_2E86FF);
    [self.viewBotm.btnSelected setTitleColor:COLOR_BG_WHITE forState:UIControlStateNormal];
    [self.viewBotm.btnSelected setTitle:@"保存并审核" forState:UIControlStateNormal];
    [self.viewBotm.btnSelected addTarget:self action:@selector(saveAndCheck) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.viewBotm];
}

#pragma mark - 查询批次下学校信息
- (void)exqerySchoolInfo
{
    [self.headSectionArray removeAllObjects];
    NSArray* schoolArray = [NSArray bg_arrayWithName:@"schoolArray"];
    
    self.headSectionArray = self.dataSource.mutableCopy;
    
    for (int j = 0; j < self.headSectionArray.count; j++) {
        HUZJudgeBatchDataModel *batchModel = self.headSectionArray[j];
        
        for (int i = 0; i < schoolArray.count; i++) {
            HUZSchoolModel *schoolModel = schoolArray[i];
            if ([schoolModel.batch isEqualToString:batchModel.ID]) {
                [batchModel setValue:schoolArray forKey:@"schoolArray"];
            }
        }
    }
    
    [self.tableView reloadData];
}

#pragma mark - 添加学校后赋值信息
- (void)addSchoolModelInfo
{
    NSMutableArray *schoolArr = [NSMutableArray array];

    HUZSchoolModel *model = [HUZSchoolModel new];
    model.logoUrl = self.model.logoUrl;
    model.uniCity = self.model.uniCity;
    model.batch = self.model.batch;
    model.schoolName = self.model.schoolName;
    model.schoolId = self.model.schoolId;
    [model setValue:self.majorArray forKey:@"major"];
    [schoolArr addObject:model];
    [schoolArr bg_saveArrayWithName:@"schoolArray"];
    
    for (int i = 0; i < self.headSectionArray.count; i++) {
        HUZJudgeBatchDataModel *batchModel = self.headSectionArray[i];
        if ([model.batch isEqualToString:batchModel.ID]) {
            [batchModel setValue:schoolArr forKey:@"schoolArray"];
        }

    }
    
}

#pragma mark - 添加学校后赋值信息
- (void)addSchoolModelContainMajorInfo:(HUZPacketVolListModel *)selectmodel
{
    NSMutableArray *schoolArr = [NSMutableArray array];
    
    HUZSchoolModel *model = [HUZSchoolModel new];
    model.logoUrl = selectmodel.logoUrl;
    model.uniCity = selectmodel.uniCity;
    model.batch = selectmodel.batch;
    model.schoolName = selectmodel.schoolName;
    model.schoolId = selectmodel.schoolId;
    [model setValue:selectmodel.subjectVoList forKey:@"major"];
    [schoolArr addObject:model];
    [schoolArr bg_saveArrayWithName:@"schoolArray"];
    
    for (int i = 0; i < self.headSectionArray.count; i++) {
        HUZJudgeBatchDataModel *batchModel = self.headSectionArray[i];
        if ([model.batch isEqualToString:batchModel.ID]) {
            [batchModel setValue:schoolArr forKey:@"schoolArray"];
        }

    }
}

- (void)setDataSourceConfig
{

    self.tableView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    [self.tableView dz_registerCell:[UITableViewCell class]];
    [self.tableView dz_registerCell:[HUZUniFillCell class]];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(AutoDistance(8));
        make.left.right.equalTo(self.view);
        make.bottom.mas_offset(-AutoDistance(49));
    }];

}

#pragma mark- 专业
- (void)loadData
{
    HUZWEAK_SELF
    [HUZHomeService getBatch:@{} success:^(HUZJudgeBatchModel * _Nonnull model) {
        HUZJudgeBatchDataModel *batchModel = model.data.firstObject;
//        weakSelf.name = batchModel.batchName;
        HUZSTRONG_SELF
        [strongSelf.headSectionArray addObjectsFromArray:model.data];
        
        strongSelf.dataSource = [strongSelf.headSectionArray copy];
        NSArray* schoolArray = [NSArray bg_arrayWithName:@"schoolArray"];

        for (int j = 0; j < strongSelf.headSectionArray.count; j++) {
            HUZJudgeBatchDataModel *batchModel = strongSelf.headSectionArray[j];
            
            for (int i = 0; i < schoolArray.count; i++) {
                HUZSchoolModel *schoolModel = schoolArray[i];
                if ([schoolModel.batch isEqualToString:batchModel.ID]) {
                    [batchModel setValue:schoolArray forKey:@"schoolArray"];
                }
            }
        }
        
        
        [strongSelf.tableView reloadData];

    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        
    }];
}

- (NSMutableArray *)dataBatch{
    if (!_dataBatch) {
        _dataBatch = [NSMutableArray new];
    }
    return _dataBatch;
}

- (void)configStyle{
    self.style = UITableViewStylePlain;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.headSectionArray.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"section:%ld ",section);

    if (section == 0) {
        return 2;
    }else{
    
    HUZJudgeBatchDataModel *batchModel = self.headSectionArray[section - 1];
    NSArray *arr = batchModel.schoolArray;//self.dataSource;
        return  arr.count;//batchModel.isOpen?arr.count:0;
    }
//    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        return AutoDistance(58);
    }else{
        HUZJudgeBatchDataModel *batchModel = self.headSectionArray[indexPath.section - 1];
        HUZSchoolModel *schoolModel = batchModel.schoolArray[indexPath.row];

//        if (schoolModel.major.count && [schoolModel.batch isEqualToString:batchModel.ID]) {
            return  AutoDistance(158);
//        }else{
//            return  0.001;
//        }
    }

    return  AutoDistance(158);

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section > 0) {
        return AutoDistance(45);
    }
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section > 0) {
        return AutoDistance(58);
    }
    return 0.0001;
}

/// dequeueReusableCell
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {

    static NSString *defaultCell = @"defaultCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:defaultCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        
        UITableViewCell *cell = [self setUpSectionHeaderTitle:tableView withIndexpath:indexPath];
        
        return cell;
    }else{
        HUZUniFillCell *cell = [self setUpSchoolDataSource:tableView withIndexpath:indexPath];
        
        return cell;
            }
    
    return cell;
}

#pragma mark - 第一组-----标题
- (UITableViewCell *)setUpSectionHeaderTitle:(UITableView *)tableView withIndexpath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    cell.textLabel.text = indexPath.row == 0 ? @"我的高考信息" : @"我的志愿表名称";
    cell.textLabel.textColor = ColorS(COLOR_414141);
    cell.textLabel.font = FontS(FONT_17);
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, AutoDistance(175), AutoDistance(30))];
    NSString *string = indexPath.row == 0 ? HUZUserCenterManager.gkInfo : @"请输入志愿表名称";
    [button setTitle:string forState:UIControlStateNormal];
    button.titleLabel.font = FontS(FONT_15);
    [button setTitleColor:ColorS(COLOR_989898) forState:UIControlStateNormal];
    [button setImage:ImageNamed(@"ic_more_arrow") forState:UIControlStateNormal];
    CGFloat spacing = 4.0;
    CGSize imageSize = button.imageView.frame.size;
    button.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, 0.0, imageSize.width + spacing);
    CGSize titleSize = button.titleLabel.frame.size;
    button.imageEdgeInsets = UIEdgeInsetsMake(0.0, titleSize.width + spacing, 0.0, - titleSize.width);
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    button.userInteractionEnabled = NO;
    cell.accessoryView = button;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

#pragma mark - 第二组------本地操作数据源的增删改查
- (HUZUniFillCell *)setUpSchoolDataSource:(UITableView *)tableView withIndexpath:(NSIndexPath *)indexPath
{
    HUZJudgeBatchDataModel *batchModel = self.headSectionArray[indexPath.section - 1];
    HUZSchoolModel *dataModel = batchModel.schoolArray[indexPath.row];//self.dataSource[indexPath.row];
    
    HUZUniFillCell *cell = [HUZUniFillCell cellWithTableView:tableView];
    cell.model = dataModel;
    HUZWEAK_SELF
    cell.addBlock = ^(NSIndexPath * _Nonnull indexPath) {
        [weakSelf majorDetailIndexPath:indexPath];
    };

    __block HUZUniFillCell *weakCell = cell;
    cell.dBtn.tag = 20000 + indexPath.row;
    cell.deleteBlock = ^{
        [weakSelf deleteSchoolData:weakCell.dBtn];
    };
    return cell;
}

/// configure cell data
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            HUZMyGkInfoViewController *gaokao = [HUZMyGkInfoViewController new];
            [self.navigationController pushViewController:gaokao animated:YES];
        }
        else if (indexPath.row == 1) { // 我的志愿表名称
            
            ZJAnimationPopView *popView = [[ZJAnimationPopView alloc] initWithPopStyle:ZJAnimationPopStyleShake dismissStyle:ZJAnimationDismissStyleNO];
            [popView popInputAlertWithTitle:@"编辑志愿表名称" placeholder:self.name];
            HUZWEAK_SELF
            popView.inputViewBlock = ^(NSString *str) {
                HUZSTRONG_SELF
                strongSelf->_name = str;
                [strongSelf.tableView reloadData];
            };
        }
    }
    else {
        HUZVolUniDetailViewController *volUni = [HUZVolUniDetailViewController new];
        [self.navigationController pushViewController:volUni animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(58))];
    view.backgroundColor = COLOR_BG_WHITE;
    if (section==0) {
        return view;
    }
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(AutoDistance(15), AutoDistance(17), AutoDistance(175), AutoDistance(25))];
    HUZJudgeBatchDataModel *dataModel = self.headSectionArray[section - 1];
    lab.text = dataModel.batchName;
    [view addSubview:lab];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(HUZSCREEN_WIDTH - AutoDistance(175) - AutoDistance(20), AutoDistance(14), AutoDistance(175), AutoDistance(30))];
    [button setTitle:section == 0 ? self.name : @"" forState:UIControlStateNormal];
    button.titleLabel.font = FontS(FONT_15);
    [button setTitleColor:ColorS(COLOR_989898) forState:UIControlStateNormal];
    [button setImage:section == 0 ? ImageNamed(@"ic_more_arrow") : ImageNamed(@"ic_btn_down") forState:UIControlStateNormal];
    CGFloat spacing = 8.0;
    CGSize imageSize = button.imageView.frame.size;
    button.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, 0.0, imageSize.width + spacing);
    CGSize titleSize = button.titleLabel.frame.size;
    button.imageEdgeInsets = UIEdgeInsetsMake(0.0, titleSize.width + spacing, 0.0, - titleSize.width);
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    button.tag = 100 + section;
    for (int i = 0; i < self.headSectionArray.count; i++) {
        NSNumber *state = [NSNumber numberWithBool:NO];
        HUZJudgeBatchDataModel *batchModel = self.headSectionArray[i];
        [batchModel setValue:state forKey:@"isOpen"];
        //默认都是折叠的
    }
    [button addTarget:self action:@selector(sectionClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(58))];
    view.backgroundColor = COLOR_BG_WHITE;
    if (section == 0) {
        return view;
    }
    UIButton *btn = [[UIButton alloc] initWithTitle:@"继续添加学校" textColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15)];
    btn.frame = CGRectMake(AutoDistance(15), AutoDistance(12), AutoDistance(200), AutoDistance(21));
    [view addSubview:btn];
    btn.tag = 10000 + section;
    [btn addTarget:self action:@selector(addSchool:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(HUZSCREEN_WIDTH - AutoDistance(18) - AutoDistance(12), AutoDistance(14), AutoDistance(18), AutoDistance(18))];
    [button setImage: ImageNamed(@"ic_btn_add_circle") forState:UIControlStateNormal];
    button.tag = 10000 + section;

    [button addTarget:self action:@selector(addSchool:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    return view;
}

- (void)sectionClick:(UIButton*)btn {
    btn.selected = !btn.selected;
    HUZJudgeBatchDataModel *batchModel = self.headSectionArray[btn.tag - 100];
    if (btn.selected) {
        [btn setImage:ImageNamed(@"ic_btn_top") forState:UIControlStateNormal];
//        batchModel.isOpen = YES;
    }else{
        [btn setImage:ImageNamed(@"ic_btn_down") forState:UIControlStateNormal];
//        batchModel.isOpen = NO;

    }
//    [self.tableView reloadData];
}

/// 专业详情
/// 专业详情 HUZUniInfoGeneralizeDataModel
- (void)majorDetailIndexPath:(NSIndexPath *)indexPath{
    HUZJudgeBatchDataModel *batchModel = self.headSectionArray[indexPath.section - 1];
    HUZSchoolModel *dataModel = batchModel.schoolArray[indexPath.row];
    HUZUniInfoGeneralizeDataModel *infoModel = [[HUZUniInfoGeneralizeDataModel alloc] init];
    infoModel.schoolId = dataModel.schoolId;
    infoModel.schoolName = dataModel.schoolName;
    infoModel.category = [dataModel.batch integerValue];
    infoModel.uniCity = dataModel.uniCity;
    infoModel.logoUrl = dataModel.logoUrl;
    
    HUZUniMajorViewController *uniMajorVC = [HUZUniMajorViewController new];
    uniMajorVC.infoModel = infoModel;
    [[UIViewController currentViewController].navigationController pushViewController:uniMajorVC animated:YES];
}

/// 继续添加学校
- (void)addSchool:(UIButton*)btn{
    HUZJudgeBatchDataModel *batchModel = self.headSectionArray[btn.tag - 10001];
    HUZUniSelectController *uniSel = [HUZUniSelectController new];
    HUZWEAK_SELF
    uniSel.selectBlock = ^(HUZSchoolModel * _Nonnull model) {
        NSLog(@"添加的学校");
        HUZSTRONG_SELF
        weakSelf.model = model;
        [strongSelf addSchoolModelInfo];
        [strongSelf exqerySchoolInfo];
    };
    
    uniSel.allBlock = ^(NSDictionary * _Nullable postDic, HUZPacketVolListModel * _Nullable model) {
        NSLog(@"postDic:%@",postDic);
        HUZSTRONG_SELF
        
        [strongSelf.majorArray addObjectsFromArray:postDic[@"volunteerSchoolEntities"]];
        [strongSelf addSchoolModelContainMajorInfo:model];
        [strongSelf exqerySchoolInfo];
    };
    uniSel.batch = batchModel.ID;
    [self.navigationController pushViewController:uniSel animated:YES];
}
/// 保存并审核
- (void)saveAndCheck {
    HUZVolFillResultController *result = [HUZVolFillResultController new];
    [self.navigationController pushViewController:result animated:YES];
}

@end

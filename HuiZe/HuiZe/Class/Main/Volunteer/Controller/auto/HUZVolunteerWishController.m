//
//  HUZVolunteerWishController.m
//  HuiZe
//
//  Created by mac on 2019/5/5.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZVolunteerWishController.h"
#import "HUZAutoDetailTableViewCell.h"
#import "HUZPPPSelectView.h"
#import "HUZSchoolAreaFiltrateView.h"

#import "HUZMajorFiltrateView.h"

#import "HUZCharacterFiltrateView.h"

#import "HUZLoginService.h"

#import "HUZProvinceModel.h"

#import "HUZMajorListDataModel.h"

@interface HUZVolunteerWishController ()<HUZPPPSelectViewDelegate>
{
    NSArray *titleArr;
    NSMutableArray *detailArr;
}
@property (copy, nonatomic) NSString *schoolStr;
@property (copy, nonatomic) NSString *genderStr;
@property (copy, nonatomic) NSString *majorStr;
@property (copy, nonatomic) NSString *characterStr;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (nonatomic,strong) HUZSchoolAreaFiltrateView *schoolFiltrateView;
@property (nonatomic,strong) HUZMajorFiltrateView *majorFiltrateView;
@property (nonatomic,strong) HUZCharacterFiltrateView *characterFiltrateView;
@property (nonatomic,strong) UIView *rightfullView;

@property (strong, nonatomic) HUZProvinceModel *provinceModel;

@property (strong, nonatomic) NSMutableArray *provinceArray;

@property (strong, nonatomic) NSMutableArray *majorEntitiesArray;

@property (strong, nonatomic) NSMutableArray *selectedArray;

@property (strong, nonatomic) NSMutableArray *selectedIdsArray;

@property (strong, nonatomic) NSMutableArray *selectedMajorIdsArray;

@end

@implementation HUZVolunteerWishController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"意愿设置";
    
    self.provinceArray = [NSMutableArray array];

    self.selectedArray = [NSMutableArray array];
    
    self.selectedIdsArray = [NSMutableArray array];

    self.selectedMajorIdsArray = [NSMutableArray array];

    self.majorEntitiesArray = [NSMutableArray array];

}

- (void)configComponents {
    [super configComponents];
    
    titleArr = @[@[@"学校地区"], @[@"专业类别"]];
    
    if (self.schoolProvinceNames.length == 0) {
        self.schoolProvinceNames = @"可进行多选";
    }
    
    if (self.majorEntitiesIdsNames.length == 0) {
        self.majorEntitiesIdsNames = @"可进行多选";
    }
    
    detailArr = @[@[self.schoolProvinceNames].mutableCopy, @[self.majorEntitiesIdsNames].mutableCopy].mutableCopy;
    
    self.shouldMultiSections = YES;
    self.dataSource = @[@[@[@"1"]], @[@[@"1"]]].mutableCopy;
    self.cellHeight = AutoDistance(157);
    self.tableView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    [self.tableView dz_registerCell:[HUZAutoDetailTableViewCell class]];
    
    [self loadProvinceData];
    
    [self loadMajorData];

}

#pragma mark - 加载专业数据
- (void)loadMajorData
{
    [self displayOverFlowActivityView];

    [HUZLoginService getMajorEntitiesSuccess:^(HUZMajorListDataModel * _Nonnull dataModel) {
        [self removeOverFlowActivityView];
        [self.majorEntitiesArray addObjectsFromArray:dataModel.data];

    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        [self removeOverFlowActivityView];
        [self presentErrorSheet:errorStr];
    }];
}

#pragma mark - 加载省份数据
- (void)loadProvinceData
{
    [self displayOverFlowActivityView];

    [HUZLoginService getProvinceSuccess:^(HUZProvinceModel * _Nonnull object) {
        [self removeOverFlowActivityView];

        [self.provinceArray addObjectsFromArray:object.data];
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        [self removeOverFlowActivityView];
        [self presentErrorSheet:errorStr];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    HUZAutoDetailTableViewCell *cell = [HUZAutoDetailTableViewCell cellWithTableView:tableView];
    cell.lab.text = titleArr[indexPath.section][indexPath.row];
    [cell.btn setTitle:detailArr[indexPath.section][indexPath.row] forState:UIControlStateNormal];
    cell.btn.userInteractionEnabled = NO;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.indexPath = indexPath;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) { // 学校地区
            [self filterAreaClick];
        }
        else {  // 男女比例
            [self pppGenderView];
        }
    }
    else {
        if (indexPath.row == 0) { // 专业类别
            [self filterMajorClick];
        }
        else {  // 性格兴趣
            [self filterCharacterClick];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return AutoDistance(58.0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return AutoDistance(8.0);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = self.tableView.backgroundColor;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return AutoDistance(20);
    }
    return AutoDistance(4);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = self.tableView.backgroundColor;
    return view;
}

- (void)filterAreaClick { // 学校地区
    
    UIView *rightfullView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT)];
    self.rightfullView = rightfullView;
    rightfullView.backgroundColor=[UIColor colorWithWhite:0 alpha:0.3];
    [[UIApplication sharedApplication].keyWindow addSubview:rightfullView];
    UIView *leftfullView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, AutoDistance(55), HUZSCREEN_HEIGHT)];
    leftfullView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [leftfullView addGestureRecognizer:tap];
    [rightfullView addSubview:leftfullView];
    __weak typeof(rightfullView) weakrightfullView = rightfullView;
    
    HUZWEAK_SELF
    self.schoolFiltrateView.sendBlock = ^(NSString *selectedTitle,NSString *selectIdArrStr){
//        for (int i = 0; i< selectedArray.count; i++) {
//            NSMutableDictionary *model = selectedArray[i];
//            [weakSelf.selectedIdsArray addObject:model[@"id"]];
//        }
        HUZSTRONG_SELF
        if (strongSelf.provinceIdsBlock) {
            if (selectIdArrStr.length == 0 || [selectIdArrStr isEqualToString:@"0"]) {
                strongSelf.provinceIdsBlock(nil,selectedTitle);
            }else{
                strongSelf.provinceIdsBlock(selectIdArrStr,selectedTitle);
            }
        }
        if (selectIdArrStr.length == 0 || [selectIdArrStr isEqualToString:@"0"]) {
            strongSelf->detailArr[strongSelf.indexPath.section][strongSelf.indexPath.row] = @"可进行多选";
        }else{
            strongSelf->detailArr[strongSelf.indexPath.section][strongSelf.indexPath.row] = selectedTitle;
        }

        
        [strongSelf.tableView reloadData];
        [weakrightfullView removeFromSuperview];
    };
    [rightfullView addSubview:self.schoolFiltrateView];
}

- (HUZSchoolAreaFiltrateView *)schoolFiltrateView {
    if (!_schoolFiltrateView) {
        _schoolFiltrateView = [[HUZSchoolAreaFiltrateView alloc]initWithFrame:CGRectMake(HUZSCREEN_WIDTH, 0, HUZSCREEN_WIDTH-AutoDistance(55), HUZSCREEN_HEIGHT)];
//        NSArray *array = @[@"不限", @"江西省", @"广东省", @"甘肃省", @"山东省", @"福建省", @"广东省", @"甘肃省", @"山东省", @"福建省"];
//        NSMutableArray *provinceArray = [NSMutableArray array];
//
//        for (int i = 0; i < self.provinceArray.count; i++) {
//            HUZProvince *provinceModel = self.provinceArray[i];
//            [provinceArray addObject:provinceModel.title];
//        }
        HUZProvince *provinceModel = [HUZProvince new];
        provinceModel.title = @"不限";
        provinceModel.Id = @"0";
        provinceModel.isSelected = @"1";
        
        if (self.provinceArray.count > 0) {
            [self.provinceArray insertObject:provinceModel atIndex:0];
        }
        
        if(self.schoolProvinceIds.length > 0) {
            NSArray *Ids =  [self.schoolProvinceIds componentsSeparatedByString:@","];//其中"-"号为分隔符
            for (HUZProvince *model in self.provinceArray) {
                if ([Ids containsObject:model.Id]) {
                    model.isSelected = @"1";
                    provinceModel.isSelected = @"0";
                }
            }
        }

        [_schoolFiltrateView loadDataWithSectionArr:@[@"学校地区"] array:self.provinceArray];
        [UIView animateWithDuration:0.5 animations:^{
            self.schoolFiltrateView.frame = CGRectMake(50, 0, HUZSCREEN_WIDTH-AutoDistance(55), HUZSCREEN_HEIGHT);
        }];
    }
    return _schoolFiltrateView;
}

- (void)pppGenderView {
    HUZPPPSelectView *ppp = [HUZPPPSelectView new];
    ppp.headTitle = @"根据男女比例选择";
    ppp.dataArray = @[@"不限",@"男生比例 > 女生比例", @"男生比例 < 女生比例", @"男生比例 = 女生比例"].mutableCopy;
    ppp.delegate = self;
    [self.view addSubview:ppp];
    [ppp show];
}

- (void)filterMajorClick { // 专业类别
    
    UIView *rightfullView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT)];
    self.rightfullView = rightfullView;
    rightfullView.backgroundColor=[UIColor colorWithWhite:0 alpha:0.3];
    [[UIApplication sharedApplication].keyWindow addSubview:rightfullView];
    UIView *leftfullView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, AutoDistance(55), HUZSCREEN_HEIGHT)];
    leftfullView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [leftfullView addGestureRecognizer:tap];
    [rightfullView addSubview:leftfullView];
    __weak typeof(rightfullView) weakrightfullView = rightfullView;
    
    HUZWEAK_SELF
    self.majorFiltrateView.sendBlock = ^(NSString *selectedTitle,NSString *selectedIdArrStr){
//        for (int i = 0; i< selectedArray.count; i++) {
//            NSMutableDictionary *model = selectedArray[i];
//            [weakSelf.selectedMajorIdsArray addObject:model[@"id"]];
//        }
        HUZSTRONG_SELF
        if (strongSelf.majorIdsBlock) {
//            strongSelf.majorIdsBlock(selectedIdArrStr,selectedTitle);
            
            if (selectedIdArrStr.length == 0 || [selectedIdArrStr isEqualToString:@"0"]) {
                strongSelf.majorIdsBlock(nil,selectedTitle);
            }else{
                strongSelf.majorIdsBlock(selectedIdArrStr,selectedTitle);
            }
        }
        
//        strongSelf->detailArr[strongSelf.indexPath.section][strongSelf.indexPath.row] = selectedTitle;
        
        if (selectedIdArrStr.length == 0 || [selectedIdArrStr isEqualToString:@"0"]) {
            strongSelf->detailArr[strongSelf.indexPath.section][strongSelf.indexPath.row] = @"可进行多选";
        }else{
            strongSelf->detailArr[strongSelf.indexPath.section][strongSelf.indexPath.row] = selectedTitle;
        }
        
        [strongSelf.tableView reloadData];
        
        [weakrightfullView removeFromSuperview];
    };
    [rightfullView addSubview:self.majorFiltrateView];
 
}

- (HUZMajorFiltrateView *)majorFiltrateView {
    if (!_majorFiltrateView) {
        _majorFiltrateView = [[HUZMajorFiltrateView alloc]initWithFrame:CGRectMake(HUZSCREEN_WIDTH, 0, HUZSCREEN_WIDTH-AutoDistance(55), HUZSCREEN_HEIGHT)];
//        NSArray *array = @[@"农学", @"医学", @"工学", @"教育学", @"山东省", @"艺术学", @"文学", @"法学", @"哲学", @"理学", @"经济学", @"历史学", @"管理学"];
        HUZMajorDataListModel *majorModel = [HUZMajorDataListModel new];
        majorModel.category = @"不限";
        majorModel.majorAllId = @"0";
        majorModel.isSelected = @"1";
        
        if (self.majorEntitiesArray.count > 0) {
            [self.majorEntitiesArray insertObject:majorModel atIndex:0];
        }
        
        if(self.majorEntitiesIds.length > 0) {
            NSArray *Ids =  [self.majorEntitiesIds componentsSeparatedByString:@","];//其中"-"号为分隔符
            for (HUZMajorDataListModel *provinceModel in self.majorEntitiesArray) {
                if ([Ids containsObject:provinceModel.majorAllId]) {
                    provinceModel.isSelected = @"1";
                    majorModel.isSelected = @"0";
                }
            }
        }
        
        [_majorFiltrateView loadDataWithSectionArr:@[@"专业类别"] array:self.majorEntitiesArray];
        [UIView animateWithDuration:0.5 animations:^{
            self.majorFiltrateView.frame = CGRectMake(50, 0, HUZSCREEN_WIDTH-AutoDistance(55), HUZSCREEN_HEIGHT);
        }];
    }
    return _majorFiltrateView;
}

- (void)filterCharacterClick { // 性格兴趣
    UIView *rightfullView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT)];
    self.rightfullView = rightfullView;
    rightfullView.backgroundColor=[UIColor colorWithWhite:0 alpha:0.3];
    [[UIApplication sharedApplication].keyWindow addSubview:rightfullView];
    UIView *leftfullView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, AutoDistance(55), HUZSCREEN_HEIGHT)];
    leftfullView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [leftfullView addGestureRecognizer:tap];
    [rightfullView addSubview:leftfullView];
    __weak typeof(rightfullView) weakrightfullView = rightfullView;
    [rightfullView addSubview:self.characterFiltrateView];
//    self.characterFiltrateView.sendBlock = ^(){
//        [weakrightfullView removeFromSuperview];
//    };
    HUZWEAK_SELF
    self.characterFiltrateView.sendBlock = ^(NSString *selectedTitle,NSString *selectIdArrStr) {
        HUZSTRONG_SELF
        
        if (strongSelf.selectCharactersBlock) {
            strongSelf.selectCharactersBlock(selectIdArrStr);
        }
        
        strongSelf->detailArr[strongSelf.indexPath.section][strongSelf.indexPath.row] = selectedTitle;
        [strongSelf.tableView reloadData];
        [weakrightfullView removeFromSuperview];
    };
}

- (HUZCharacterFiltrateView *)characterFiltrateView {
    if (!_characterFiltrateView) {
        _characterFiltrateView = [[HUZCharacterFiltrateView alloc]initWithFrame:CGRectMake(HUZSCREEN_WIDTH, 0, HUZSCREEN_WIDTH-AutoDistance(55), HUZSCREEN_HEIGHT)];
        NSArray *array = @[@"匹配性格测试推荐专业", @"匹配兴趣测试推荐专业"];
        [_characterFiltrateView loadDataWithSectionArr:@[@"性格兴趣"] array:array];
        [UIView animateWithDuration:0.5 animations:^{
            self.characterFiltrateView.frame = CGRectMake(50, 0, HUZSCREEN_WIDTH-AutoDistance(55), HUZSCREEN_HEIGHT);
        }];
    }
    return _characterFiltrateView;
}

- (void)tapClick:(UITapGestureRecognizer *)tap {
    [self.rightfullView removeFromSuperview];
}

#pragma mark - HUZPPPSelectViewDelegate
- (void)pppSelectViewDelegateWith:(HUZPPPSelectView *)selectView result:(NSString *)result {
    NSLog(@"%@", result);
    detailArr[self.indexPath.section][self.indexPath.row] = result;
    self.genderStr = result;
    NSString *menId;
    if ([result isEqualToString:@"男生比例 > 女生比例"]) {
        menId = @"1";
    }else if ([result isEqualToString:@"男生比例 < 女生比例"]) {
        menId = @"2";
    }else if ([result isEqualToString:@"男生比例 = 女生比例"]) {
        menId = @"3";
    }
    
    if (self.menIdBlock) {
        self.menIdBlock(menId);
    }
    [self.tableView reloadData];
}

@end

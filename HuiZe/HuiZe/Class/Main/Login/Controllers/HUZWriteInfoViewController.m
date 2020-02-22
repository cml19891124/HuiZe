//
//  HUZWriteInfoViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/22.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZWriteInfoViewController.h"
#import "HUZWriteInfoHeaderView.h"
#import "HUZWriteInfoFirstCell.h"
#import "HUZWriteInfoSecondCell.h"
#import "HUZWriteInfoFooterView.h"
#import "HUZLoginService.h"
#import "HUZProvinceModel.h"

@interface HUZWriteInfoViewController ()<HUZWriteInfoSecondDelegate,HUZPPPSelectViewDelegate>{
    NSString *_character; // 角色
    NSString *_provice;   // 省份
    NSString *_year;      // 年份
    NSString *_subject;   // 科目
    NSString *_mark;      // 预估分数
    NSString *_rank;      // 预估排名
}

@property (nonatomic,strong) HUZPushUpWindow *pushUpWindow;
@property (nonatomic,strong) UIButton *btnBack;
@property (nonatomic,strong) UIButton *btnJump;
@property (nonatomic,strong) UIButton *btnEnter;
@property (nonatomic,strong) HUZPPPSelectView *selectProvinceView;
@property (nonatomic,strong) HUZPPPSelectView *selectYearView;
@property (nonatomic,strong) HUZProvinceModel *provinceModel;
@property (nonatomic,strong) HUZProvince *provinceSelected;
@end

@implementation HUZWriteInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _character = @"学生";
    _subject = @"理科";
}

- (void)configComponents{
    [super configComponents];
    
    NSArray *array = @[@[@"学生",@"家长",@"老师"],@[@""],@[@"理科",@"文科",@"新高考"],@[@"预估高考分数",@"预估高考排名"]];
    self.dataSource = [array mutableCopy];
    
    self.btnBack = [[UIButton alloc] initWithTitle:@"完善信息" textColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_24)];
    if (!self.isLoginTo) {
        [self.btnBack setImage:ImageNamed(NAV_BACK_BLACK) forState:UIControlStateNormal];
        [self.btnBack LeftImageRightTitleWithSpace:AutoDistance(15)];
        [self.btnBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.btnJump = [[UIButton alloc] initWithTitle:@"跳过此步" textColor:ColorS(COLOR_2E86FF) autoTextFont:FontS(FONT_15)];
    [self.btnJump addTarget:self action:@selector(nextJump) forControlEvents:UIControlEventTouchUpInside];
    
    self.btnJump.hidden = self.isLoginTo;
    
    self.btnEnter = [[UIButton alloc] initWithNormalColor:ColorS(COLOR_989898) selectColor:ColorS(COLOR_2E86FF)];
    [self.btnEnter setTitle:@"进入慧择高考" forState:UIControlStateNormal];
    [self.btnEnter addTarget:self action:@selector(nextEnter) forControlEvents:UIControlEventTouchUpInside];
    self.btnEnter.enabled = NO;
    ViewRadius(self.btnEnter, AutoDistance(22));
    
    [self.view addSubview:self.btnBack];
    [self.view addSubview:self.btnJump];
    [self.view addSubview:self.btnEnter];
    
    [self.btnBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT));
        make.left.mas_offset(AutoDistance(15));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(120),AutoDistance(33)));
    }];
    
    [self.btnJump mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.btnBack);
        make.right.mas_offset(-AutoDistance(15));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(65), 21));
    }];

    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(HUZSTATUS_BAR_NAVIGATION_BAR_HEIGHT + AutoDistance(60));
        make.left.right.equalTo(self.view);
        make.bottom.mas_offset(-HUZTAB_BAR_SAFE_BOTTOM_MARGIN - AutoDistance(70));
    }];
    
    [self.btnEnter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.mas_offset(-HUZTAB_BAR_SAFE_BOTTOM_MARGIN - AutoDistance(21));
        make.size.mas_equalTo(CGSizeMake(HUZSCREEN_WIDTH-AutoDistance(76), AutoDistance(44)));
    }];
    
    self.edg = UIEdgeInsetsMake(0, AutoDistance(38), 0, AutoDistance(38));
    self.minimumLineSpacing = AutoDistance(17);
    self.shouldMultiSections = YES;
    [self.collectionView dz_registerView:[HUZWriteInfoHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader];
    [self.collectionView dz_registerView:[HUZWriteInfoFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter];
    [self.collectionView dz_registerCell:[HUZWriteInfoFirstCell class]];
    [self.collectionView dz_registerCell:[HUZWriteInfoSecondCell class]];
    
}

- (void)nextJump {
    [self performBlock:^{
        [HUZTools gotohell];
    } afterDelay:1.5f];
}

- (void)nextEnter {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setValue:_rank forKey:@"estimateRanking"]; // 预估排名
    [postDic setValue:_mark forKey:@"estimateScore"]; // 预估分数
    [postDic setValue:self.provinceSelected.Id forKey:@"examinationProvince"]; // 高考省份
    [postDic setValue:_year forKey:@"examinationYear"]; //  高考年份
    NSString *grade = @"0";
    if ([_subject isEqualToString:@"理科"]) {
        grade = @"1";
    }
    else if ([_subject isEqualToString:@"新高考"]) {
        grade = @"2";
    }
    [postDic setValue:grade forKey:@"grade"]; // 文理科：0文科 1理科,2综合
    NSString *userRole = @"0";
    if ([_character isEqualToString:@"家长"]) {
        userRole = @"1";
    }
    else if ([_character isEqualToString:@"老师"]) {
        userRole = @"2";
    }
    [postDic setValue:userRole forKey:@"userRole"]; // 用户角色：0学生 1家长 2老师

    NSLog(@"完善信息 postDic = %@",postDic);
    HUZWEAK_SELF;
    [weakSelf displayOverFlowActivityView];
    [HUZLoginService getUpdateDetailWithParameters:postDic success:^(NSString *success) {
        [weakSelf removeOverFlowActivityView];
        [weakSelf presentSuccessSheet:@"欢迎进入慧择高考"];
        
        
        HUZUserCenterManager.userModel.haveUserInfo = @"1";
        [weakSelf getUserInfoData];
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        [weakSelf removeOverFlowActivityView];
        [weakSelf presentErrorSheet:errorStr];

    }];
}
//
//更新本地缓存
-(void)getUserInfoData {
    [HUZNetWorkTool huz_POST:kUrl_query_userInfo parameters:nil success:^(id  _Nonnull responseObject) {
        HUZWEAK_SELF;
        HUZLoginModel *model = [HUZLoginModel modelWithJSON:responseObject];
        if ([model isSuccess]) {
            model.data.userEntity.token = model.data.token;
            HUZUserCenterManager.userModel = model.data.userEntity;
            [HUZUserCenterManager saveToCache];

        } else {
        }
        [weakSelf performBlock:^{
            [HUZTools gotohell];
        } afterDelay:1.5f];
    } failure:^(NSUInteger statusCode, NSString *error) {
        
    }];
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)reloadData{
    [self.collectionView reloadData];
}

/// 按钮是否可以点击
- (void)bindData{
    if (DRStringIsNotEmpty(_character) && DRStringIsNotEmpty(_provice) && DRStringIsNotEmpty(_year) && DRStringIsNotEmpty(_subject) && DRStringIsNotEmpty(_mark) && DRStringIsNotEmpty(_rank)) {
        self.btnEnter.enabled = YES;
    }else{
        self.btnEnter.enabled = NO;
    }
}

#pragma mark - HUZWriteInfoSecondDelegate
- (void)clickInfoType:(NSInteger)type{
    /// 省份
    if (type == 1) {
        // 获取省份接口
        [self displayOverFlowActivityView];
        [HUZLoginService getProvinceSuccess:^(HUZProvinceModel * _Nonnull object) {
            [self removeOverFlowActivityView];
            self.provinceModel = [HUZProvinceModel new];
            self.provinceModel = object;
            [self.selectProvinceView show];
        } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
            [self removeOverFlowActivityView];
            [self presentErrorSheet:errorStr];
        }];

    }
    /// 年份
    else{
        [self.selectYearView show];
    }
}

#pragma mark HUZPPPSelectViewDelegate
- (void)pppSelectViewDelegateWith:(HUZPPPSelectView *)selectView indexPath:(NSIndexPath*)indexPAth result:(NSString *)result {
    if (selectView.tag == 1) {
        self.provinceSelected = [HUZProvince new];
        self.provinceSelected = self.provinceModel.data[indexPAth.row];
        _provice = result;
    }else{
        _year = result;
    }
    [self reloadData];
    [self bindData];
}


#pragma mark - collectionView
/// cell
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 || indexPath.section == 2) {
        return CGSizeMake((HUZSCREEN_WIDTH- AutoDistance(110))/3.0, AutoDistance(38));
    }
    
    else if (indexPath.section == 1){
        return CGSizeMake(HUZSCREEN_WIDTH - AutoDistance(76), AutoDistance(38));
    }
    
    else{
        return CGSizeMake((HUZSCREEN_WIDTH- AutoDistance(93))/2.0, AutoDistance(38));

    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        HUZWriteInfoSecondCell *cell = [HUZWriteInfoSecondCell cellWithCollectionView:collectionView forIndexPath:indexPath];
        cell.delegate = self;
        [cell reloadProvice:_provice year:_year];
        return cell;
    }else{
        HUZWriteInfoFirstCell *cell = [HUZWriteInfoFirstCell cellWithCollectionView:collectionView forIndexPath:indexPath];
        NSString *str = self.dataSource[indexPath.section][indexPath.row];
        [cell reloadData:str indexPath:indexPath character:_character subject:_subject mark:_mark rank:_rank];
        return cell;
        
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    /// 选中
    if (indexPath.section == 0) {
        _character = self.dataSource[indexPath.section][indexPath.row];
        [self reloadData];
        [self bindData];
    }
    
    else if (indexPath.section == 2){
        _subject = self.dataSource[indexPath.section][indexPath.row];
        [self reloadData];
        [self bindData];
    }
    
    else if(indexPath.section == 3){
        if (indexPath.row == 0) {
            ZJAnimationPopView *popView = [[ZJAnimationPopView alloc] initWithPopStyle:ZJAnimationPopStyleShake dismissStyle:ZJAnimationDismissStyleNO];
            [popView popInputAlertWithTitle:@"高考成绩预估分数" placeholder:@"请输入分数"];
            HUZWEAK_SELF
            popView.inputViewBlock = ^(NSString *str) {
                HUZSTRONG_SELF
                strongSelf->_mark = str;
                [strongSelf reloadData];
                [strongSelf bindData];
            };
        }else{
            ZJAnimationPopView *popView = [[ZJAnimationPopView alloc] initWithPopStyle:ZJAnimationPopStyleShake dismissStyle:ZJAnimationDismissStyleNO];
            [popView popInputAlertWithTitle:@"高考排名预估" placeholder:@"请输入排名"];
            HUZWEAK_SELF
            popView.inputViewBlock = ^(NSString *str) {
                HUZSTRONG_SELF
                strongSelf->_rank = str;
                [strongSelf reloadData];
                [strongSelf bindData];
            };
        }
    }
}


/// 头部，尾部
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(HUZSCREEN_WIDTH-AutoDistance(76), AutoDistance(49));
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(HUZSCREEN_WIDTH-AutoDistance(76), AutoDistance(40));
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        HUZWriteInfoHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HUZWriteInfoHeaderView" forIndexPath:indexPath];
        headerView.indexPath = indexPath;
        reusableView = headerView;
    }else{
        HUZWriteInfoFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"HUZWriteInfoFooterView" forIndexPath:indexPath];
        reusableView = footerView;
    }
    return reusableView;
}


#pragma mark - Lzay
- (HUZPushUpWindow *)pushUpWindow{
    if (!_pushUpWindow) {
        _pushUpWindow = [HUZPushUpWindow new];
    }
    return _pushUpWindow;
}

- (HUZPPPSelectView *)selectProvinceView {
    if (!_selectProvinceView) {
        _selectProvinceView = [HUZPPPSelectView new];
        _selectProvinceView.headTitle = @"选择省份";
        NSMutableArray *marr = [NSMutableArray array];
        for (HUZProvince *province in self.provinceModel.data) {
            [marr addObject:province.title];
        }
        _selectProvinceView.dataArray = marr;
        _selectProvinceView.delegate = self;
        _selectProvinceView.tag = 1;
        [self.view addSubview:_selectProvinceView];
    }
    return _selectProvinceView;
}

- (HUZPPPSelectView *)selectYearView{
    if (!_selectYearView) {
        _selectYearView = [HUZPPPSelectView new];
        _selectYearView.headTitle = @"选择年份";
        _selectYearView.dataArray = @[@"2020",@"2021",@"2022"].mutableCopy;
        _selectYearView.delegate = self;
        _selectYearView.tag = 2;
        [self.view addSubview:_selectYearView];
    }
    return _selectYearView;
}
-(void)setIsLoginTo:(BOOL)isLoginTo {
    _isLoginTo = isLoginTo;
    self.btnJump.hidden = isLoginTo;
    
}
- (void)dealloc{
    NSLog(@"dealloc");
}
@end


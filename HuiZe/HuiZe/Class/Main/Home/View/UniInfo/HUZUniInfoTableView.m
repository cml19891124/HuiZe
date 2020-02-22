//
//  HUZUniInfoTableView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/24.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniInfoTableView.h"
#import "HUZUniInfoSectionView.h"
#import "HUZUniInfoAblumCell.h"
#import "HUZUniInfoVideoCell.h"
#import "HUZUniIntrodutionCell.h"
#import "HUZUniInfoCommonCell.h"
#import "HUZUniSexRatioTableViewCell.h"
#import "HUZUniContinueStudyCell.h"
#import "HUZUniInfoFooterView.h"
#import "HUZUniInfoAssessModel.h"
#import "HUZUniMajorViewController.h"
#import "HUZMajorInfoViewController.h"
#import "HUZUniInfoGeneralizeModel.h"
#import "HUZMajorRankingListCell.h"
#import "HUZMajorRankingModel.h"
#import "HUZUniInfoTableViewAssessMoreFooter.h"
#import "HUZUniMajorInfoVC.h"
@interface HUZUniInfoTableView ()

@property (nonatomic,strong) NSMutableArray *dataMajor;  /// 专业数据源
@property (nonatomic,strong) HUZUniInfoGeneralizeDataModel *uniInfoModel;  /// 大学信息对象

@property (nonatomic,assign) BOOL isOpen;  /// 是否展开

@property (nonatomic,assign) BOOL isOpenAssess;  /// 是否展开学科评估

@property (nonatomic, strong) NSMutableArray * assessMajorList;

@end

@implementation HUZUniInfoTableView


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataMajor = [NSMutableArray new];
        
        self.dataHeader = @[@"校园风光",@"校园视频",@"校园简介",@"",@"学科评估",@"开设专业"];//,@"男女比例",@"深造情况",
        
        [self dz_registerCell:[HUZUniInfoAblumCell class]];
        [self dz_registerCell:[HUZUniInfoVideoCell class]];
        [self dz_registerCell:[HUZUniIntrodutionCell class]];
        [self dz_registerCell:[HUZUniInfoCommonCell class]];
        [self dz_registerCell:[HUZUniSexRatioTableViewCell class]];
        [self dz_registerCell:[HUZUniContinueStudyCell class]];
        [self dz_registerCell:[HUZMajorRankingListCell class]];
        self.isOpenAssess = NO;
    }
    return self;
}

- (void)setSchoolId:(NSString *)schoolId{
    _schoolId = schoolId;
    [self loadUniInfoGeneralze];
    [self getSubjectMajorList];
    [self getAssessResultListMajorList];
}

#pragma mark NETWork
/// 学校概况
- (void)loadUniInfoGeneralze{
    HUZWEAK_SELF
    [HUZHomeService getUniInfoGeneralize:_schoolId success:^(HUZUniInfoGeneralizeModel * _Nonnull model) {
        HUZSTRONG_SELF
        strongSelf.uniInfoModel = model.data;
//        [strongSelf.dataMajor addObjectsFromArray:model.data.majorAllHomeVoList];
        [strongSelf reloadData];
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        
    }];
}

-(void)getSubjectMajorList{
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    par[@"schoolId"] = self.schoolId;
    par[@"pageSize"] = @"5";
    par[@"pageNow"] = @"1";
    
    [HUZNetWorkTool huz_POSTWithForm:kUrl_subject_majorList parameters:par success:^(id  _Nonnull responseObject) {
        NSString *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([codeStr integerValue] == 0) {
            [self.dataMajor removeAllObjects];
            NSArray *arr = [NSArray modelArrayWithClass:[HUZUniInfoGeneralizeMajorModel  class] json:responseObject[@"data"][@"list"]];
            [self.dataMajor addObjectsFromArray:arr];
            [self reloadData];
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        
    }];
}

-(void)getAssessResultListMajorList {
    
    [HUZNetWorkTool huz_GET:[NSString stringWithFormat:@"%@%@",kUrl_Assess_Result_school,self.schoolId] parameters:nil success:^(id  _Nonnull responseObject) {
        NSString *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([codeStr integerValue] == 0) {
            [self.dataMajor removeAllObjects];
            NSArray *arr = [NSArray modelArrayWithClass:[HUZUniInfoAssessModel class] json:responseObject[@"data"]];
            [self.assessMajorList addObjectsFromArray:arr];
            [self reloadData];
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        
    }];
    
}

- (void)openAll{
    self.isOpen = self.isOpen ? NO : YES;
    [self reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataHeader.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 3){
        return 2;
    }else if (section == 4){
        if (self.assessMajorList.count > 5) {
            if (self.isOpenAssess) {
                return self.assessMajorList.count;
            }
            return 5;
        }else{
            return self.assessMajorList.count;
        }
    }else if (section == 5) {
        return self.dataMajor.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    if (section == 0) return [HUZUniInfoAblumCell calculateHeightWithEntity:nil];
    else if (section == 1) return [HUZUniInfoVideoCell calculateHeightWithEntity:nil];
    else if (section == 2) return [HUZUniIntrodutionCell calculateHeightWithEntity:self.uniInfoModel isOpen:self.isOpen];
//    else if (section == 4) return [HUZUniSexRatioTableViewCell calculateHeightWithEntity:nil];
//    else if (section == 5) return [HUZUniContinueStudyCell calculateHeightWithEntity:nil];
    return [HUZUniInfoCommonCell calculateHeightWithEntity:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    /// 校园风光
    if (section == 0) {
        HUZUniInfoAblumCell *cell = [HUZUniInfoAblumCell cellWithTableView:tableView];
        cell.dataUniPhoto = self.uniInfoModel.schoolpicVos;;
        return cell;
    }
    
    /// 校园视频
    else if (section == 1){
        HUZUniInfoVideoCell *cell = [HUZUniInfoVideoCell cellWithTableView:tableView];
        cell.uniInfoModel = self.uniInfoModel;
        return cell;
    }
    
    /// 校园简介
    else if (section == 2){
        HUZUniIntrodutionCell *cell = [HUZUniIntrodutionCell cellWithTableView:tableView];
        [cell setUniInfoModel:self.uniInfoModel isOpen:self.isOpen];
        /// 展开
        [cell.btnAll addTarget:self action:@selector(openAll) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
//    /// 男女比例
//    else if (section == 4){
//        HUZUniSexRatioTableViewCell *cell = [HUZUniSexRatioTableViewCell cellWithTableView:tableView];
//        cell.uniInfoModel = self.uniInfoModel;
//        return cell;
//    }
//
//    /// 深造情况
//    else if (section == 5){
//        HUZUniContinueStudyCell *cell = [HUZUniContinueStudyCell cellWithTableView:tableView];
//        cell.uniInfoModel = self.uniInfoModel;
//        return cell;
//    }
    
    /// 校园官网、招生电话、特色专业
    else if(indexPath.section == 4){
        HUZUniInfoAssessModel *assessModel = nil;
        if (indexPath.row < self.assessMajorList.count) {
            assessModel = self.assessMajorList[indexPath.row];
        }
        HUZMajorRankingListCell * cell = [HUZMajorRankingListCell cellWithTableView:tableView];
        cell.indexPath = indexPath;
        cell.assessModel = assessModel;
        [cell reloadData:nil indexPath:indexPath];
        cell.backgroundColor = ColorS(COLOR_BG_F6F6F6);
        cell.contentView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
        return cell;
    }else{
        HUZUniInfoCommonCell *cell = [HUZUniInfoCommonCell cellWithTableView:tableView];
        if (section == 3) {  ///校园官网、招生电话
            [cell reloadData:self.uniInfoModel indexPath:indexPath];
        }else{///特色专业
            HUZUniInfoGeneralizeMajorModel *majorModel = nil;
            if (indexPath.row < self.dataMajor.count) {
                majorModel = self.dataMajor[indexPath.row];
            }
            //cell.labContent.text = majorModel.category;
            [cell reloadData:majorModel indexPath:indexPath];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 3) return 0.000001f;
    return AutoDistance(51);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 5){
        return AutoDistance(47);
    }else if (section == 4) {
        if (self.assessMajorList.count > 5) {
            return AutoDistance(47)+8;
        }
        return 8;
    }
    return 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        return [UIView new];
    } else{
        HUZUniInfoSectionView *sectionView = [[HUZUniInfoSectionView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(51))];
        sectionView.labSection.text = self.dataHeader[section];
        return sectionView;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 5) {
        HUZUniInfoFooterView *footer = [[HUZUniInfoFooterView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(47))];
        [footer.btnMore addTarget:self action:@selector(clickMore) forControlEvents:UIControlEventTouchUpInside];
        return footer;
    }else if(section == 4){
        if (self.assessMajorList.count > 5) {
            HUZUniInfoTableViewAssessMoreFooter *moreFooter = [[HUZUniInfoTableViewAssessMoreFooter alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(51))];
            [moreFooter.btnMore addTarget:self action:@selector(assessMoreAction:) forControlEvents:UIControlEventTouchUpInside];
            moreFooter.btnMore.selected = self.isOpenAssess;
            return moreFooter;
        }else{
            return [UIView new];
        }
    }else{
        return [UIView new];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 5) {
        HUZUniInfoGeneralizeMajorModel *majorModel = nil;
        if (indexPath.row < self.dataMajor.count) {
            majorModel = self.dataMajor[indexPath.row];
        }
        
        HUZMajorInfoViewController *majorInfoVC = [HUZMajorInfoViewController new];
        majorInfoVC.majorId = majorModel.majorAllId;
        [[UIViewController currentViewController].navigationController pushViewController:majorInfoVC animated:YES];
    }else if(indexPath.section == 3){
        if (indexPath.row == 1) {
            NSString *telephoneNumber=self.uniInfoModel.recrPhone;
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",telephoneNumber];
            UIApplication *application = [UIApplication sharedApplication];
            NSURL *URL = [NSURL URLWithString:str];
            [application openURL:URL options:@{} completionHandler:^(BOOL success) {
                //OpenSuccess=选择 呼叫 为 1  选择 取消 为0
                NSLog(@"OpenSuccess=%d",success);
                
            }];
        }
    }else if (indexPath.section == 4) {
        HUZUniInfoAssessModel *assessModel = nil;
        if (indexPath.row < self.assessMajorList.count) {
            assessModel = self.assessMajorList[indexPath.row];
        }
    }
}

/// 专业 HUZUniInfoGeneralizeMajorModel
- (void)clickMore{
//    HUZUniMajorViewController *uniMajorVC = [HUZUniMajorViewController new];
//    uniMajorVC.infoModel = self.uniInfoModel;
//    [[UIViewController currentViewController].navigationController pushViewController:uniMajorVC animated:YES];
    HUZUniMajorInfoVC *uniMajorVC = [HUZUniMajorInfoVC new];
    uniMajorVC.infoModel = self.uniInfoModel;
    [[UIViewController currentViewController].navigationController pushViewController:uniMajorVC animated:YES];
}

-(void)assessMoreAction:(UIButton *)sender{
    self.isOpenAssess = !self.isOpenAssess;
    [self reloadData];
}

-(NSMutableArray *)assessMajorList {
    if (!_assessMajorList) {
        _assessMajorList = [NSMutableArray array];
    }
    return _assessMajorList;
}


@end


//
//  HUZMajorBasicInfoTableView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/28.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZMajorBasicInfoTableView.h"
#import "HUZUniIntrodutionCell.h"
#import "HUZUniSexRatioTableViewCell.h"
#import "HUZUniInfoCommonCell.h"
#import "HUZOpenAllFooterView.h"
#import "HUZMajorInterestHeaderView.h"
#import "HUZUniInfoSectionView.h"
#import "HUZMajorInfoModel.h"
#import "HUZUniInfoGeneralizeModel.h"
#import "HUZUniInfoCommonTextCell.h"
#import "HUZMajorInfoModel.h"
#import "HUZMajorInfoViewController.h"
@interface HUZMajorBasicInfoTableView ()
@property (nonatomic, assign) BOOL isOpen;

@property (nonatomic, copy) NSString * curriculum;
@property (nonatomic, strong) NSMutableArray * majorInterestedArr;
@end

@implementation HUZMajorBasicInfoTableView

-(void)setInfoModel:(HUZMajorInfoModel *)infoModel {
    _infoModel = infoModel;
    [self reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.isOpen = NO;
        self.dataHeader = @[@"专业介绍",@"开设课程",@""];//,@"文理比例",@"男女比例",
        [self registerNib:[UINib nibWithNibName:@"HUZUniInfoCommonTextCell" bundle:nil] forCellReuseIdentifier:@"HUZUniInfoCommonTextCell"];
        [self dz_registerCell:[HUZUniIntrodutionCell class]];
        [self dz_registerCell:[HUZUniSexRatioTableViewCell class]];
        [self dz_registerCell:[HUZUniInfoCommonCell class]];
        
    }
    return self;
}

-(void)setMajorId:(NSString *)majorId {
    _majorId = majorId;
    [self loadCurriculum];
    [self loadMajorInterested];
}

-(void)loadCurriculum {
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    par[@"majorId"] = self.majorId;
//    par[@""] = ;
//    par[@""] = ;
    HUZWEAK_SELF;
    [HUZNetWorkTool huz_POST:kUrl_major_curriculum parameters:par success:^(id  _Nonnull responseObject) {
        NSString *codeStr = responseObject[@"code"];
        if ([codeStr integerValue] == 0) {
            NSArray *arr = responseObject[@"data"][@"list"];
            NSDictionary *dict = arr.firstObject;
            self.curriculum = dict[@"curriculum"];
            [self reloadData];
        }else{
            [self presentErrorSheet:responseObject[@"msg"]];
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        [weakSelf presentErrorSheet:error];
    }];
}

-(void)loadMajorInterested {
    HUZWEAK_SELF;
    [HUZNetWorkTool huz_POSTWithForm:kUrl_major_interested parameters:@{@"majorAllId":self.majorId} success:^(id  _Nonnull responseObject) {
        NSString *codeStr = responseObject[@"code"];
        
        if ([codeStr integerValue] == 0) {
            [weakSelf.majorInterestedArr removeAllObjects];
            NSArray *arr = [NSArray modelArrayWithClass:[HUZMajorInfoModel class] json:responseObject[@"data"]];
            [weakSelf.majorInterestedArr addObjectsFromArray:arr];
            [self reloadData];
        }else{
            [self presentErrorSheet:responseObject[@"msg"]];
        }
        
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        [weakSelf presentErrorSheet:error];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataHeader.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section <= 1) return 1;
    else return self.majorInterestedArr.count;
}
//HUZUniInfoGeneralizeDataModel *)entity
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        HUZUniInfoGeneralizeDataModel *model = [[HUZUniInfoGeneralizeDataModel alloc] init];
        model.introduce = self.infoModel.majorIntroduce;
         return [HUZUniIntrodutionCell calculateHeightWithEntity:model isOpen:self.isOpen];
    }else if (indexPath.section == 1) {
        HUZUniInfoGeneralizeDataModel *model = [[HUZUniInfoGeneralizeDataModel alloc] init];
        model.introduce = self.curriculum;
        return [HUZUniIntrodutionCell calculateHeightWithEntity:model isOpen:YES];
    }
    /*
    else if (indexPath.section == 1 || indexPath.section == 2){
        return [HUZUniSexRatioTableViewCell calculateHeightWithEntity:nil];
    }else if(indexPath.section == 3) {
        HUZUniInfoGeneralizeDataModel *model = [[HUZUniInfoGeneralizeDataModel alloc] init];
        model.introduce = self.curriculum;
        return [HUZUniIntrodutionCell calculateHeightWithEntity:model isOpen:YES];
    }
     */
    return AutoDistance(60);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    /// 专业介绍
    if (indexPath.section == 0) {
        HUZUniIntrodutionCell *cell = [HUZUniIntrodutionCell cellWithTableView:tableView];
        HUZUniInfoGeneralizeDataModel *model = [[HUZUniInfoGeneralizeDataModel alloc] init];
        model.introduce = self.infoModel.majorIntroduce;
        [cell setUniInfoModel:model isOpen:self.isOpen];
        HUZWEAK_SELF;
         cell.btnAll.hidden = NO;
        [cell.btnAll addTapAction:^(id  _Nonnull sender) {
            weakSelf.isOpen = !self.isOpen;
            [weakSelf reloadData];
        }];
        return cell;
    }else if (indexPath.section == 1) {
        //        HUZUniInfoCommonTextCell *textCell = [tableView dequeueReusableCellWithIdentifier:@"HUZUniInfoCommonTextCell"];
        //        return textCell;
                HUZUniIntrodutionCell *cell = [HUZUniIntrodutionCell cellWithTableView:tableView];
                HUZUniInfoGeneralizeDataModel *model = [[HUZUniInfoGeneralizeDataModel alloc] init];
                model.introduce = self.curriculum;
                cell.btnAll.hidden = YES;
                [cell setUniInfoModel:model isOpen:YES];
                HUZWEAK_SELF;
                [cell.btnAll addTapAction:^(id  _Nonnull sender) {
                    weakSelf.isOpen = !self.isOpen;
                    [weakSelf reloadData];
                }];
                cell.contentView.backgroundColor = UIColor.whiteColor;
                return cell;
    }else{
        HUZMajorInfoModel *infoModel = nil;
        if (indexPath.row < self.majorInterestedArr.count) {
            infoModel = self.majorInterestedArr[indexPath.row];
        }
        
        HUZUniInfoCommonCell *cell = [HUZUniInfoCommonCell cellWithTableView:tableView];
        cell.infoModel = infoModel;
        cell.labContent.text = infoModel.category;
        return cell;
    }
    
    /*
    else if (indexPath.section == 1 || indexPath.section == 2){
        HUZUniSexRatioTableViewCell *cell = [HUZUniSexRatioTableViewCell cellWithTableView:tableView];
        if (indexPath.section == 1) {
            cell.ivMale.image = [UIImage imageNamed:@"ic_ranking_wen"];
            cell.ivFemale.image = [UIImage imageNamed:@"ic_ranking_li"];
            cell.labMale.text = [NSString stringWithFormat:@"%.1lf",self.infoModel.liberalProportion];
            cell.labFemale.text = [NSString stringWithFormat:@"%.1lf",self.infoModel.scienceProportion];
            cell.lineProgressView.progress = self.infoModel.liberalProportion /100;
        }else{
            cell.ivMale.image = [UIImage imageNamed:@"ic_male"];
            cell.ivFemale.image = [UIImage imageNamed:@"ic_female"];
            cell.labMale.text = [NSString stringWithFormat:@"%.1lf",self.infoModel.boyProportion];
            cell.labFemale.text = [NSString stringWithFormat:@"%.1lf",self.infoModel.girlProportion];
            cell.lineProgressView.progress = self.infoModel.boyProportion /100;
        }
        return cell;
    }
    
    /// 开设课程、你可能感兴趣的专业
    else if (indexPath.section == 3) {
//        HUZUniInfoCommonTextCell *textCell = [tableView dequeueReusableCellWithIdentifier:@"HUZUniInfoCommonTextCell"];
//        return textCell;
        HUZUniIntrodutionCell *cell = [HUZUniIntrodutionCell cellWithTableView:tableView];
        HUZUniInfoGeneralizeDataModel *model = [[HUZUniInfoGeneralizeDataModel alloc] init];
        model.introduce = self.curriculum;
        cell.btnAll.hidden = YES;
        [cell setUniInfoModel:model isOpen:YES];
        HUZWEAK_SELF;
        [cell.btnAll addTapAction:^(id  _Nonnull sender) {
            weakSelf.isOpen = !self.isOpen;
            [weakSelf reloadData];
        }];
        cell.contentView.backgroundColor = UIColor.whiteColor;
        return cell;
    }else{
        
        HUZMajorInfoModel *infoModel = nil;
        if (indexPath.row < self.majorInterestedArr.count) {
            infoModel = self.majorInterestedArr[indexPath.row];
        }
        
        HUZUniInfoCommonCell *cell = [HUZUniInfoCommonCell cellWithTableView:tableView];
        cell.infoModel = infoModel;
        cell.labContent.text = infoModel.category;
        return cell;
    }
     */
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) return AutoDistance(45);
    return AutoDistance(48);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        HUZMajorInterestHeaderView *interestHeaderView = [[HUZMajorInterestHeaderView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(45))];
        return interestHeaderView;
    }else{
        HUZUniInfoSectionView *majorInfoSectionView = [[HUZUniInfoSectionView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(48))];
        majorInfoSectionView.labSection.text = self.dataHeader[section];
        return majorInfoSectionView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if (section == 3) return AutoDistance(41);
    return AutoDistance(8);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    if (section == 3) {
//        HUZOpenAllFooterView *openAllFooterView = [[HUZOpenAllFooterView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(41))];
//        return openAllFooterView;
//    }
    return [UIView new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        HUZMajorInfoModel *infoModel = nil;
        if (indexPath.row < self.majorInterestedArr.count) {
            infoModel = self.majorInterestedArr[indexPath.row];
        }
        HUZMajorInfoViewController *infoVC = [[HUZMajorInfoViewController alloc] init];
        infoVC.majorId = infoModel.majorAllId;
        [self.YQViewController.navigationController pushViewController:infoVC animated:true];
    }
}

#pragma mark -- lazy
-(NSMutableArray *)majorInterestedArr {
    if (!_majorInterestedArr) {
        _majorInterestedArr = [NSMutableArray array];
    }
    return _majorInterestedArr;
}
#pragma mark -- lazy end
@end


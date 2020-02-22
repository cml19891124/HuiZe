//
//  HUZFillVolunteerController.m
//  HuiZe
//
//  Created by tbb on 2019/10/28.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZFillVolunteerController.h"
#import "HUZFillVolunteerBatchCell.h"
#import "HUZFillVolunteerAddSchoolCell.h"
#import "HUZFillVolunteerUniversityCell.h"
#import "HUZJudgeBatchModel.h"
#import "HUZUniSelectController.h"

#import "HUZFillVolunteerSelectMarjorVC.h"
#import "HUZVolUniDetailViewController.h"
#import "HUZMineVolunteerListController.h"
@interface HUZFillVolunteerController ()<HUZFillVolunteerUniversityCellDelegate>
@property (nonatomic,copy) NSString *name;

@property (nonatomic, strong) NSMutableArray * batchArr;

@property (nonatomic, strong) UIButton * savaBtn;
@end

@implementation HUZFillVolunteerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.style = UITableViewStyleGrouped;
    self.navigationItem.title = @"填报";
    self.tableView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    [self.tableView registerNib:[UINib nibWithNibName:@"HUZFillVolunteerBatchCell" bundle:nil] forCellReuseIdentifier:@"HUZFillVolunteerBatchCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HUZFillVolunteerAddSchoolCell" bundle:nil] forCellReuseIdentifier:@"HUZFillVolunteerAddSchoolCell"];
    [self.tableView registerClass:[HUZFillVolunteerUniversityCell class] forCellReuseIdentifier:@"HUZFillVolunteerUniversityCell"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(-(HUZTAB_BAR_SAFE_BOTTOM_MARGIN + 50));
    }];
    [self.view addSubview:self.savaBtn];
    [self.savaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-HUZTAB_BAR_SAFE_BOTTOM_MARGIN);
        make.height.mas_equalTo(50);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    self.name = self.volunteerNmae;
    [self loadBatchData];
    
}

#pragma mark- 批次
- (void)loadBatchData
{
    HUZWEAK_SELF
    [HUZHomeService getBatch:@{} success:^(HUZJudgeBatchModel * _Nonnull model) {
        HUZSTRONG_SELF
        [strongSelf.batchArr removeAllObjects];
        [strongSelf.batchArr addObjectsFromArray:model.data];
        if (self.volunteerDict.count > 0) {
            [strongSelf withVolunteerDict];
        }
        [strongSelf.tableView reloadData];
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
         
    }];
}
//处理备选志愿传来的数据
-(void)withVolunteerDict {
    for (HUZJudgeBatchDataModel *batchModel in self.batchArr) {
        batchModel.schoolArray = self.volunteerDict[batchModel.ID];
    }
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1+self.batchArr.count;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        HUZJudgeBatchDataModel *batchModel = nil;
        if (section-1 < self.batchArr.count) {
            batchModel = self.batchArr[section-1];
        }
        if (batchModel.isOpen) {
            return 1;
        }
        return batchModel.schoolArray.count + 2;
    }
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [self setUpSectionHeaderTitle:tableView withIndexpath:indexPath];
        return cell;
    }else {
        HUZJudgeBatchDataModel *batchModel = nil;
        if (indexPath.section-1 < self.batchArr.count) {
            batchModel = self.batchArr[indexPath.section-1];
        }
        if (indexPath.row == 0) {
            HUZFillVolunteerBatchCell *batchTypeCell = [tableView dequeueReusableCellWithIdentifier:@"HUZFillVolunteerBatchCell"];
            if (indexPath.section == 1) {
                batchTypeCell.titleLb.text = @"本科一批";
            }else if (indexPath.section == 2){
                batchTypeCell.titleLb.text = @"本科二批";
            }else{
                batchTypeCell.titleLb.text = @"专科批";
            }
            batchTypeCell.showBtn.tag = 11000+(indexPath.section);
            [batchTypeCell.showBtn addTarget:self action:@selector(showMajorListAction:) forControlEvents:(UIControlEventTouchUpInside)];
            
            return batchTypeCell;
        }else if(indexPath.row == batchModel.schoolArray.count+1){//(self.batchUniversity1Arr.count+1)
            HUZFillVolunteerAddSchoolCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HUZFillVolunteerAddSchoolCell"];
            cell.addBtn.tag = (11100+indexPath.section-1);
            [cell.addBtn addTarget:self action:@selector(addSchoolListAction:) forControlEvents:(UIControlEventTouchUpInside)];
            return cell;
        }else{
            
            HUZSchoolModel *schoolModel = nil;
            if (batchModel.schoolArray.count > indexPath.row-1) {
                schoolModel = batchModel.schoolArray[indexPath.row-1];
            }
            
            HUZFillVolunteerUniversityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HUZFillVolunteerUniversityCell"];
            cell.indexPath = indexPath;
            cell.delegate = self;
            cell.schoolModel = schoolModel;
            return cell;
        }
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 58;
    }else{
        HUZJudgeBatchDataModel *batchModel = nil;
        if (indexPath.section-1 < self.batchArr.count) {
            batchModel = self.batchArr[indexPath.section-1];
        }
        
        if (indexPath.row == 0) {
            return 58;
        }else if(indexPath.row == batchModel.schoolArray.count+1){
            return 47;
        }else{
            HUZSchoolModel *schoolModel = nil;
            if (batchModel.schoolArray.count > indexPath.row-1) {
                schoolModel = batchModel.schoolArray[indexPath.row-1];
            }
            return 105 + schoolModel.showMajorContentH;
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        ZJAnimationPopView *popView = [[ZJAnimationPopView alloc] initWithPopStyle:ZJAnimationPopStyleShake dismissStyle:ZJAnimationDismissStyleNO];
        [popView popInputAlertWithTitle:@"编辑志愿表名称" placeholder:@"请输入志愿表名称"];
        HUZWEAK_SELF
        popView.inputViewBlock = ^(NSString *str) {
            HUZSTRONG_SELF
            strongSelf->_name = str;
            [strongSelf.tableView reloadData];
        };
    }else{
        HUZJudgeBatchDataModel *batchModel = nil;
        if (indexPath.section-1 < self.batchArr.count) {
            batchModel = self.batchArr[indexPath.section-1];
        }
        
        HUZSchoolModel *schoolModel = nil;
        if (batchModel.schoolArray.count > indexPath.row-1) {
            schoolModel = batchModel.schoolArray[indexPath.row-1];
        }
        
        if (0 < indexPath.row == 0) {
            
        }else if(indexPath.row == batchModel.schoolArray.count+1){
            
        }else{
            HUZVolUniDetailViewController *volUni = [HUZVolUniDetailViewController new];
            volUni.indexPath = indexPath;
            volUni.schoolModel = schoolModel;
            MJWeakSelf
            volUni.delMarjorClickBlock = ^{
                [weakSelf.tableView reloadData];
            };
            
            volUni.delSchoolClickBlock = ^(NSIndexPath * _Nonnull indexPath) {
                [weakSelf deleteSchoolActionIndexPath:indexPath];
            };
            [self.navigationController pushViewController:volUni animated:YES];
        }
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 8;
    }
    return 8;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [UIView new];
    footerView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    return footerView;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [UIView new];
    headerView.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 8;
    }
    return 0.001;
}
#pragma mark - UITableViewDelegate, UITableViewDataSource end
-(void)addSchoolListAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSInteger section = sender.tag - 11100;
    HUZJudgeBatchDataModel *batchModel = nil;
    if (section < self.batchArr.count) {
        batchModel = self.batchArr[section];
    }
    
    if (batchModel.schoolArray.count >= 6) {
        [self presentErrorSheet:@"最多添加六个学校"];
        return;
    }

    HUZUniSelectController *uniSel = [HUZUniSelectController new];
    HUZWEAK_SELF
    //添加的学校
    uniSel.selectBlock = ^(HUZSchoolModel * _Nonnull model) {
//        HUZSTRONG_SELF
        NSMutableArray *newSchoolArr =[NSMutableArray array];
        if (batchModel.schoolArray.count > 0) {
            for (NSInteger i = 0; i<batchModel.schoolArray.count; i++) {
                HUZSchoolModel *schoolModel =  batchModel.schoolArray[i];
                if (![model.schoolId isEqualToString:schoolModel.schoolId]) {
                    [newSchoolArr addObject:schoolModel];
                }
            }
            [newSchoolArr addObject:model];
        }else{
            [newSchoolArr addObject:model];
        }
        batchModel.schoolArray = newSchoolArr.copy;
        [weakSelf.tableView reloadData];
    };
    /*
    uniSel.allBlock = ^(NSDictionary * _Nullable postDic, HUZPacketVolListModel * _Nullable model) {
        NSLog(@"postDic:%@",postDic);
        HUZSTRONG_SELF
    };
    */
    uniSel.batch = batchModel.ID;
    [self.navigationController pushViewController:uniSel animated:YES];
}

#pragma mark ---添加专业
-(void)addMajorCurrentIndexPath:(NSIndexPath *)indexPath {
    HUZJudgeBatchDataModel *batchModel = nil;
    if (indexPath.section-1 < self.batchArr.count) {
        batchModel = self.batchArr[indexPath.section-1];
    }
    HUZSchoolModel *schoolModel = nil;
    if (batchModel.schoolArray.count > indexPath.row-1) {
        schoolModel = batchModel.schoolArray[indexPath.row-1];
    }
    
    HUZUniInfoGeneralizeDataModel *infoModel = [[HUZUniInfoGeneralizeDataModel alloc] init];
    infoModel.schoolId = schoolModel.schoolId;
    infoModel.schoolName = schoolModel.schoolName;
    infoModel.category = [schoolModel.batch integerValue];
    infoModel.uniCity = schoolModel.uniCity;
    infoModel.logoUrl = schoolModel.logoUrl;
    
    HUZFillVolunteerSelectMarjorVC *uniMajorVC = [HUZFillVolunteerSelectMarjorVC new];
    uniMajorVC.infoModel = infoModel;
    uniMajorVC.marjorArr = schoolModel.major;
    __weak typeof(schoolModel) weakSchoolModel = schoolModel;
    HUZWEAK_SELF;
    uniMajorVC.selectMarjorBlock = ^(NSArray * _Nonnull marjorArr) {
        __strong typeof(weakSchoolModel) strongInfoModel = weakSchoolModel;
        strongInfoModel.major = marjorArr;
        [weakSelf.tableView reloadData];
    };
    
    [[UIViewController currentViewController].navigationController pushViewController:uniMajorVC animated:YES];
    
}

-(void)deleteMajorCurrentIndexPath:(NSIndexPath *)indexPath {

    UIAlertController *alterCV = [UIAlertController alertControllerWithTitle:@"" message:@"是否删除当前学校" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alterCV addAction:cancelBtn];
    HUZWEAK_SELF;
    UIAlertAction *okBtn = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf deleteSchoolActionIndexPath:indexPath];
    }];
    
    [alterCV addAction:okBtn];
    [self presentViewController:alterCV animated:YES completion:nil];

}

-(void)deleteSchoolActionIndexPath:(NSIndexPath *)indexPath {
    HUZJudgeBatchDataModel *batchModel = nil;
    if (indexPath.section-1 < self.batchArr.count) {
        batchModel = self.batchArr[indexPath.section-1];
    }
    NSMutableArray *allSchollArr = [NSMutableArray arrayWithArray:batchModel.schoolArray];
    [allSchollArr removeObjectAtIndex:(indexPath.row-1)];
    batchModel.schoolArray = allSchollArr;
    [self.tableView reloadData];
}

-(void)showMajorListAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSInteger section = sender.tag - 11000;
    HUZJudgeBatchDataModel *batchModel = nil;
    if (section-1 < self.batchArr.count) {
        batchModel = self.batchArr[section-1];
    }
    batchModel.isOpen = sender.selected;
    [self.tableView reloadData];
}
#pragma mark - 第一组-----标题
- (UITableViewCell *)setUpSectionHeaderTitle:(UITableView *)tableView withIndexpath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    cell.textLabel.text = @"我的志愿表名称";
    cell.textLabel.textColor = ColorS(COLOR_414141);
    cell.textLabel.font = FontS(FONT_17);
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, AutoDistance(175), AutoDistance(30))];
    NSString *string = [self.name removeStringSpace].length == 0 ? @"请输入志愿表名称" : self.name;
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
-(void)savaAction:(UIButton *)sender  {
    if ([self.name removeStringSpace].length == 0) {
        [self presentErrorSheet:@"请输入志愿表名称"];
        return;
    }
    

    NSMutableArray * volunteerArr = [NSMutableArray array];
    for(HUZJudgeBatchDataModel * batchModel in self.batchArr) {
        for (HUZSchoolModel *schoolModel in batchModel.schoolArray) {
            if (schoolModel.major.count == 0) {
                [self presentErrorSheet:[NSString stringWithFormat:@"%@-专业不能为空",schoolModel.schoolName]];
                return;
            }
            NSMutableDictionary *volunteerDict = [NSMutableDictionary dictionary];
            NSString *majorAllIds = [self withMajorAllIdsSchoolModel:schoolModel];
            volunteerDict[@"majorAllIds"] = majorAllIds;
            volunteerDict[@"schoolId"] = schoolModel.schoolId;
            volunteerDict[@"batch"] = schoolModel.batch;
            if (self.volunteerId.length > 0) {
                volunteerDict[@"volunteerFormId"] = self.volunteerId;
            }
            [volunteerArr addObject:volunteerDict];
        }
    }
    NSString *url = kUrl_volunteer_saveVolunteer;
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    par[@"alternativeType"] = @"3";
    par[@"volunteerName"] = self.name;
    par[@"volunteerSchoolEntities"] = volunteerArr.copy;
    if (self.volunteerId.length > 0) {
        url = kUrl_Volunteer_Update_Volunteer;
        par[@"volunteerId"] = self.volunteerId;
    }
    MJWeakSelf;
    [self displayOverFlowActivityView];
    self.savaBtn.userInteractionEnabled = NO;
    [HUZNetWorkTool huz_POST:url parameters:par success:^(id  _Nonnull responseObject) {
        [self removeOverFlowActivityView];
        self.savaBtn.userInteractionEnabled = YES;
        NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([code integerValue] == 0) {
            HUZMineVolunteerListController *vc = [HUZMineVolunteerListController new];
            vc.barckVc = @"HUZFillVolunteerController";
            [weakSelf.navigationController pushViewController:vc animated:true];
        }else{
            [weakSelf presentErrorSheet:responseObject[@"msg"]];
        }
    } failure:^(NSUInteger statusCode, NSString * _Nonnull error) {
        self.savaBtn.userInteractionEnabled = YES;
        [self removeOverFlowActivityView];
        [weakSelf presentErrorSheet:error];
    }];
    
    
}
//生成专业majorAllIds字符串
-(NSString *)withMajorAllIdsSchoolModel:(HUZSchoolModel *)schoolModel {
    NSMutableString *allids = [NSMutableString string];
    for (HUZUniInfoGeneralizeMajorModel *majorModel in schoolModel.major) {
        if([allids removeStringSpace].length == 0){
            [allids appendString:majorModel.majorAllId];
        }else{
            [allids appendString:@","];
            [allids appendString:majorModel.majorAllId];
        }
        
    }
    return allids.copy;
}
#pragma mark --lazy
-(NSMutableArray *)batchArr {
    if (!_batchArr) {
        _batchArr = [NSMutableArray array];
    }
    return _batchArr;
}
-(UIButton *)savaBtn {
    if (!_savaBtn) {
        _savaBtn = [UIButton buttonWithType:0];
        _savaBtn.titleLabel.font = [UIFont systemFontOfSize:17 weight:(UIFontWeightMedium)];
        [_savaBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _savaBtn.backgroundColor = ColorS(COLOR_BG_2E86FF);
        [_savaBtn setTitle:@"保存" forState:(UIControlStateNormal)];
        [_savaBtn addTarget:self action:@selector(savaAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _savaBtn;
}
#pragma mark --lazy end
@end

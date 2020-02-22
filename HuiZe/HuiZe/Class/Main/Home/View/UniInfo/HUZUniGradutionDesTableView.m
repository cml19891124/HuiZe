//
//  HUZUniGradutionDesTableView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/25.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniGradutionDesTableView.h"
#import "HUZUniGradutionDesSectionView.h"
#import "HUZUniEmploymentStatusCell.h"
#import "HUZUniEmploymentRadioCell.h"
#import "HUZEmptyFooterView.h"

@interface HUZUniGradutionDesTableView ()

@property (nonatomic,strong) HUZGeneralizeModel *generalizeModel;  /// 前景概括
@property (nonatomic,strong) HUZIndustyLeaModel *industyLeaModel; /// 行业去向

@property (nonatomic,strong) NSMutableArray *dataIndusty; /// 行业去向
@property (nonatomic,strong) NSMutableArray *dataRegion;  /// 地区去向

@end

@implementation HUZUniGradutionDesTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        [self dz_registerCell:[HUZUniEmploymentStatusCell class]];
        [self dz_registerCell:[HUZUniEmploymentRadioCell class]];
        [self dz_registerCell:[HUZGoToBuyVipCell class]];
        
        self.dataIndusty = [NSMutableArray new];
        self.dataRegion = [NSMutableArray new];
        
    }
    return self;
}

-(void)setVipState:(NSInteger)vipState {
    _vipState = vipState;
    if (self.vipState >= 2) {
        if (self.schoolId) {
            // 加载数据
            [self loadGradutionDesData];
        }else{
            [self reloadData];
        }
    }else{
        [self reloadData];
    }
    
}


- (void)setSchoolId:(NSString *)schoolId{
    _schoolId = schoolId;
    if (self.vipState >= 2) {
        // 加载数据
        [self loadGradutionDesData];
    }

}

#pragma mark NETWork
- (void)loadGradutionDesData{
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    HUZWEAK_SELF
    [self displayOverFlowActivityView];
    
    /// 前景概括
    [HUZHomeService getGeneralize:@{@"schoolId":_schoolId} success:^(HUZGeneralizeModel * _Nonnull model) {
        HUZSTRONG_SELF
        strongSelf.generalizeModel = model;
        dispatch_group_leave(group);
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf presentErrorSheet:errorStr];
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    /// 行业去向
    [HUZHomeService getIndustyLea:@{@"schoolId":_schoolId} success:^(HUZIndustyLeaModel * _Nonnull model) {
        HUZSTRONG_SELF
        strongSelf.industyLeaModel = model;
        [strongSelf.dataIndusty addObjectsFromArray:model.data.list];
        dispatch_group_leave(group);
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf presentErrorSheet:errorStr];
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    /// 地区去向
    [HUZHomeService getRegionLea:@{@"schoolId":_schoolId} success:^(HUZAreaLeaModel * _Nonnull model) {
        HUZSTRONG_SELF
        [strongSelf.dataRegion addObjectsFromArray:model.data.list];
        dispatch_group_leave(group);
    } failure:^(NSUInteger code, NSString * _Nonnull errorStr) {
        HUZSTRONG_SELF
        [strongSelf presentErrorSheet:errorStr];
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
       HUZSTRONG_SELF
        [strongSelf removeOverFlowActivityView];
        [strongSelf reloadData];
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.vipState < 2) {
        return 1;
    }
    if (section == 0) return 1;
    else if (section == 1) return self.dataIndusty.count;
    return self.dataRegion.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.vipState < 2) {
        return 100;
    }
    if (indexPath.section == 0){
        return AutoDistance(136);
    }
    else if (indexPath.section == 1){
        if (indexPath.row == 0 || indexPath.row == self.dataIndusty.count-1) {
            return AutoDistance(AutoDistance(55));
        }else{
            return AutoDistance(38);
        }
    }else{
        if (indexPath.row == 0 || indexPath.row == self.dataRegion.count-1) {
            return AutoDistance(AutoDistance(55));
        }else{
            return AutoDistance(38);
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.vipState < 2) {
        HUZGoToBuyVipCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HUZGoToBuyVipCell"];
        cell.title = @"开通会员、立即查看详情";
        return cell;
    }else{
        if (indexPath.section == 0) {
            HUZUniEmploymentStatusCell *cell = [HUZUniEmploymentStatusCell cellWithTableView:tableView];
            [cell reloadData:self.generalizeModel];
            return cell;
        }else{
            HUZUniEmploymentRadioCell *cell = [HUZUniEmploymentRadioCell cellWithTableView:tableView];
            if (indexPath.section == 1) {
                if (indexPath.row == 0) {
                    cell.type = HUZUniEmploymentRadioTop;
                }else if (indexPath.row == self.dataIndusty.count-1){
                    cell.type = HUZUniEmploymentRadioBottom;
                }else{
                    cell.type = HUZUniEmploymentRadioCenter;
                }
                [cell reloadData:self.dataIndusty[indexPath.row]];
            }else{
                if (indexPath.row == 0) {
                    cell.type = HUZUniEmploymentRadioTop;
                }else if (indexPath.row == self.dataRegion.count-1){
                    cell.type = HUZUniEmploymentRadioBottom;
                }else{
                    cell.type = HUZUniEmploymentRadioCenter;
                }
                [cell reloadData:self.dataRegion[indexPath.row]];
            }
            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 || section == 2) return AutoDistance(58);
    return AutoDistance(92);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGFloat sectionH = (section == 0 || section == 2) ? AutoDistance(58) : AutoDistance(92);
    HUZUniGradutionDesSectionView *uniGradutionDesSectionView = [[HUZUniGradutionDesSectionView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, sectionH)];
    if (section == 0 || section == 2) {
        uniGradutionDesSectionView.labTitle.text = section == 0 ? @"就业前景概况" : @"地区去向";
        uniGradutionDesSectionView.labDes1.hidden = YES;
        uniGradutionDesSectionView.labDes2.hidden = YES;

    }else{
        uniGradutionDesSectionView.labTitle.text = @"行业去向";
        uniGradutionDesSectionView.model = self.industyLeaModel;
        uniGradutionDesSectionView.labDes1.hidden = NO;
        uniGradutionDesSectionView.labDes2.hidden = NO;

    }
    return uniGradutionDesSectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) return AutoDistance(8);
    return AutoDistance(44);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) return [UIView new];
    
    HUZEmptyFooterView *footerView = [[HUZEmptyFooterView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(44))];
    return footerView;
}

@end

//
//  HUZDroplineTableView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/23.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZDroplineTableView.h"
#import "HUZSearchSchoolCell.h"
#import "HUZUniInfoViewController.h"
#import "HUZKernalDroplineModel.h"
#import "HUZKernalEnterlineModel.h"
#import "HUZMyVipCardViewController.h"
@interface HUZDroplineTableView ()


@end

@implementation HUZDroplineTableView

- (void)setType:(HUZDroplineDataType)type{
    _type = type;
}

- (void)setYear:(NSString *)year{
    _year = year;
    [self.kernelConditonView.btnYear setTitle:[NSString stringWithFormat:@"%@",year] forState:UIControlStateNormal];
}

- (void)setConditon:(NSString *)conditon{
    _conditon = conditon;
    [self.kernelConditonView.btnScore setTitle:conditon forState:UIControlStateNormal];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.vipState = [HUZUserCenterManager.userModel.vip integerValue];
        self.rowHeight = AutoDistance(81);
        [self dz_registerCell:[HUZSearchSchoolCell class]];
        
    }
    return self;
}
//HUZUserCenterManager.userModel.vip// vip：0普通，1铂金，2钻石，3专家一对一
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(self.vipState == 0) {
        return 0;
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HUZSearchSchoolCell *cell = [HUZSearchSchoolCell cellWithTableView:tableView];
    cell.ivDiviceline.hidden = indexPath.row == self.datas.count - 1 ? YES : NO;
    [cell reloadData:self.datas[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AutoDistance(42);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HUZUniInfoViewController *uniInfoVC = [HUZUniInfoViewController new];
    if (_type == HUZDroplineType) {
        HUZKernalDroplineDataListModel *model = self.datas[indexPath.row];
        uniInfoVC.schoolId = model.schoolId;
    }else{
        HUZKernalEnterlineDataListModel *model = self.datas[indexPath.row];
        uniInfoVC.schoolId = model.schoolId;
    }
    
    [[UIViewController currentViewController].navigationController pushViewController:uniInfoVC animated:YES];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HUZKernelConditonView *kernelConditonView = [[HUZKernelConditonView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, AutoDistance(40))];
    kernelConditonView.backgroundColor = COLOR_BG_WHITE;
    self.kernelConditonView = kernelConditonView;
    if (_type == HUZDroplineType) {
        [self.kernelConditonView.btnYear setTitle:[NSString stringWithFormat:@"%@",_year] forState:UIControlStateNormal];
        [self.kernelConditonView.btnScore setTitle:_conditon forState:UIControlStateNormal];
        [self.kernelConditonView.btnYear addTarget:self action:@selector(clickDroplineYear) forControlEvents:UIControlEventTouchUpInside];
//        [self.kernelConditonView.btnScore addTarget:self action:@selector(clickDroplineScore) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [self.kernelConditonView.btnYear setTitle:[NSString stringWithFormat:@"%@",_year] forState:UIControlStateNormal];
        [self.kernelConditonView.btnScore setTitle:_conditon forState:UIControlStateNormal];
        [self.kernelConditonView.btnYear addTarget:self action:@selector(clickEnterlineYear) forControlEvents:UIControlEventTouchUpInside];
        [self.kernelConditonView.btnScore addTarget:self action:@selector(clickEnterlineScore) forControlEvents:UIControlEventTouchUpInside];
    }
    return self.kernelConditonView;
}

- (void)clickDroplineYear{
    [self routerEventWithName:HUZdroplineClickyear userInfo:nil];
}

- (void)clickDroplineScore{
    [self routerEventWithName:HUZdroplineClickdrop userInfo:nil];
}

- (void)clickEnterlineYear{
    [self routerEventWithName:HUZenterlineClickyear userInfo:nil];
}

- (void)clickEnterlineScore{
    [self routerEventWithName:HUZenterlineClickdrop userInfo:nil];
}
-(void)setVipState:(NSInteger)vipState {
    _vipState = vipState;
    if (vipState == 0) {
        self.tableHeaderView = self.droplineToBuyVipView;
    }else{
        self.tableHeaderView = nil;
    }
}
- (void)setDatas:(NSMutableArray *)datas{
    [super setDatas:datas];
}


-(HUZGoToBuyVipView *)droplineToBuyVipView {
    if (!_droplineToBuyVipView) {
        _droplineToBuyVipView = [HUZGoToBuyVipView viewFromXib];
        _droplineToBuyVipView.titleLb.text = @"开通会员、立即查看详情";
        _droplineToBuyVipView.frame = CGRectMake(0, 0, HUZSCREEN_WIDTH, 188);
        _droplineToBuyVipView.height = 188.0;
    }
    return _droplineToBuyVipView;
}

//-(HUZGoToBuyVipView *)enterlineToBuyVipView {
//    if (!_enterlineToBuyVipView) {
//        _enterlineToBuyVipView = [HUZGoToBuyVipView viewFromXib];
//        _enterlineToBuyVipView.titleLb.text = @"开通会员、立即查看详情";
//        _enterlineToBuyVipView.frame = CGRectMake(0, 0, HUZSCREEN_WIDTH, 188);
//        _enterlineToBuyVipView.height = 188.0;
//        _enterlineToBuyVipView.backgroundColor = UIColor.yellowColor;
//    }
//    return _enterlineToBuyVipView;
//}

@end

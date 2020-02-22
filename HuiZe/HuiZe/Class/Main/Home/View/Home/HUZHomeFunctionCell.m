//
//  HUZHomeFunctionCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/18.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZHomeFunctionCell.h"
#import "HUZFunctionCell.h"
#import "HUZKernelDataViewController.h"
#import "HUZStudentPlanViewController.h"
#import "HUZSearchUniViewController.h"
#import "HUZSearchMajorViewController.h"
#import "HUZGKDynamicViewController.h"
#import "HUZRegisterGuideViewController.h"
#import "HUZCannerPlanViewController.h"
#import "HUZMyVipCardViewController.h"
@implementation HUZHomeFunctionCell

+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"HUZHomeFunctionCell";
    HUZHomeFunctionCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:ID];
    }
    return cell;
}

+ (CGFloat)calculateHeightWithEntity:(id)entity{
    return 190;
}

- (void)initView{
    [self.contentView addSubview:self.collectionView];
}

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0,HUZSCREEN_WIDTH,190) collectionViewLayout:flow];
        [self.contentView addSubview:_collectionView];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.collectionView dz_registerCell:[HUZFunctionCell class]];
        _collectionView.backgroundColor= COLOR_BG_WHITE;
        _collectionView.bounces = NO;
    }
    return _collectionView;
}

- (void)setDataFunction:(NSMutableArray *)dataFunction{
    _dataFunction = dataFunction;
    [self.collectionView reloadData];
}

#pragma mark ————— collection代理方法 —————
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataFunction.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HUZFunctionCell* cell = [HUZFunctionCell cellWithCollectionView:collectionView forIndexPath:indexPath];
    NSDictionary *dic = self.dataFunction[indexPath.row];
    cell.ivFunction.image = ImageNamed(dic[@"icon"]);
    cell.labFunction.text = dic[@"name"];
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;//行每个item的间隔
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;//列每个item的间隔
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((HUZSCREEN_WIDTH - 30)/4.0, 76);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(24, 15, 14, 15);//分别为上、左、下、右
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HUZViewController *VC = nil;
    /// 志愿填写
    if (indexPath.row == 0) {
        [UIViewController currentViewController].tabBarController.selectedIndex = 1;
    }
    
    /// 核心数据
    else if (indexPath.row == 1){
        HUZKernelDataViewController *kernelDataVC = [HUZKernelDataViewController new];
        VC = kernelDataVC;
    }
    
    /// 招生计划
    else if (indexPath.row == 2){
        HUZStudentPlanViewController *studentPlanVC = [HUZStudentPlanViewController new];
        VC = studentPlanVC;
    }
    
    /// 报考指南
    else if (indexPath.row == 3){
        HUZRegisterGuideViewController *registerGuideVC = [HUZRegisterGuideViewController new];
        VC = registerGuideVC;
    }
    
    /// 查大学
    else if (indexPath.row == 4){
        HUZSearchUniViewController *searchUniVC = [HUZSearchUniViewController new];
        VC = searchUniVC;
    }
    
    /// 查专业
    else if (indexPath.row == 5){
        HUZSearchMajorViewController *searchMajorVC = [HUZSearchMajorViewController new];
        VC = searchMajorVC;
    }
    
    /// 高考动态
    else if (indexPath.row == 6){
        HUZGKDynamicViewController *gkDynamicVC = [HUZGKDynamicViewController new];
        VC = gkDynamicVC;
    }
    
    /// 生涯规划
    else{
        NSInteger vipState = [HUZUserCenterManager.userModel.vip integerValue];
        if (vipState >= 2) {
            HUZCannerPlanViewController *cannerPlanVC = [HUZCannerPlanViewController new];
            VC = cannerPlanVC;
        }else{
            HUZMyVipCardViewController *myVipCardVC = [HUZMyVipCardViewController new];
            [self.YQViewController.navigationController pushViewController:myVipCardVC animated:YES];
        }

    }
    
    if (VC != nil) {
        [[UIViewController currentViewController].navigationController pushViewController:VC animated:YES];
    }
}

@end

//
//  HUZGKDynamicViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/26.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZGKDynamicViewController.h"
#import "HUZGKDynamicCell.h"
#import "HUZDynamicListViewController.h"
#import "HUZPolicyExplainViewController.h"


@interface HUZGKDynamicViewController ()

@end

@implementation HUZGKDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"高考动态";
    self.view.backgroundColor = ColorS(COLOR_BG_F6F6F6);
}

- (void)configComponents{
    [super configComponents];
 
    self.dataSource = [@[@{@"image":@"iv_gk_dynamic1",@"name":@"教育部"},
                         @{@"image":@"iv_gk_dynamic2",@"name":@"本省政策"},
                         @{@"image":@"iv_gk_dynamic3",@"name":@"最新动态"},
                         //@{@"image":@"iv_gk_dynamic4",@"name":@"政策解读"}
                         ] mutableCopy];
    
    
    self.minimumLineSpacing = AutoDistance(30);
    self.minimumInteritemSpacing = 0;
    self.cellSize = CGSizeMake(HUZSCREEN_WIDTH-AutoDistance(30), (HUZSCREEN_WIDTH-AutoDistance(30)) * 0.342);
    self.edg = UIEdgeInsetsMake(AutoDistance(24), AutoDistance(15), AutoDistance(24), AutoDistance(15));
    [self.collectionView dz_registerCell:[HUZGKDynamicCell class]];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
       dequeueReusableCellWithIdentifier:(NSString *)identifier
                            forIndexPath:(NSIndexPath *)indexPath{
    return [HUZGKDynamicCell cellWithCollectionView:collectionView forIndexPath:indexPath];
}

- (void)configureCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    HUZGKDynamicCell *gkDynamicCell = (HUZGKDynamicCell *)cell;
    [gkDynamicCell reloadData:object];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row <= 2) {
        HUZDynamicListViewController *dynamicListVC = [HUZDynamicListViewController new];
        dynamicListVC.navTitle = self.dataSource[indexPath.row][@"name"];
        dynamicListVC.type = (int)indexPath.row;
        [self.navigationController pushViewController:dynamicListVC animated:YES];
    }else{
        HUZPolicyExplainViewController *policyExplainVC = [HUZPolicyExplainViewController new];
        [self.navigationController pushViewController:policyExplainVC animated:YES];
    }
}


@end


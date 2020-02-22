//
//  HUZUniRankingViewController.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/24.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniRankingViewController.h"
#import "HUZUniRankingCell.h"
#import "HUZUniRankingListViewController.h"
#import "HUZMajorRankingListViewController.h"

@interface HUZUniRankingViewController ()

@end

@implementation HUZUniRankingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    self.title = self.type == HUZUniRankingType ?  @"学校排行榜" : @"专业排行榜";
}

- (void)configComponents{
    [super configComponents];
    
    /// 高校榜单
    if (self.type == HUZUniRankingType) {
        //@{@"icon":@"ic_ranking_li",@"content":@"2018理科招生院校排行"},
        //@{@"icon":@"ic_ranking_wen",@"content":@"2018文科招生院校排行"},
        self.dataSource = [@[
                             @{@"icon":@"ic_ranking_wu",@"content":@"武书连2019"},
                             @{@"icon":@"ic_ranking_zhi",@"content":@"中国校友网2019"},
                             @{@"icon":@"ic_ranking_us",@"content":@"U.S.New2019"},
                             @{@"icon":@"ic_ranking_qs",@"content":@"QS 2019"}
                             ] mutableCopy];
    }
    /// 专业排行榜
    else{
        self.dataSource = @[@{@"icon":@"ic_ranking_li",@"content":@"本省理科专业排行榜"},
                            @{@"icon":@"ic_ranking_wen",@"content":@"本省文科专业排行榜"},].mutableCopy;
    }
    

    
    self.cellSize = CGSizeMake((HUZSCREEN_WIDTH-AutoDistance(79))/2.0, (HUZSCREEN_WIDTH-AutoDistance(79))/2.0);
    self.edg = UIEdgeInsetsMake(AutoDistance(32), AutoDistance(25), AutoDistance(32), AutoDistance(25));
    self.minimumLineSpacing = AutoDistance(29);
    self.minimumInteritemSpacing = AutoDistance(29);
    [self.collectionView dz_registerCell:[HUZUniRankingCell class]];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
       dequeueReusableCellWithIdentifier:(NSString *)identifier
                            forIndexPath:(NSIndexPath *)indexPath{
    return [HUZUniRankingCell cellWithCollectionView:collectionView forIndexPath:indexPath];
}

- (void)configureCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    HUZUniRankingCell *uniRankingCell = (HUZUniRankingCell*) cell;
    [uniRankingCell reloadData:object];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type == HUZUniRankingType) {
        //高校榜单
        HUZUniRankingListViewController *uniRankingListVC = [HUZUniRankingListViewController new];
        uniRankingListVC.navTitle = self.dataSource[indexPath.row][@"content"];
        switch (indexPath.item) {
            case 0:
                uniRankingListVC.type = 4;
                break;
            case 1:
                uniRankingListVC.type = 5;
                break;
            case 2:
                uniRankingListVC.type = 3;
                break;
            case 3:
                uniRankingListVC.type = 2;
                break;
            case 4:
                uniRankingListVC.type = 0;
                break;
            case 5:
                uniRankingListVC.type = 1;
                break;
                
            default:
                break;
        }
        [self.navigationController pushViewController:uniRankingListVC animated:YES];
    }else{
//        HUZMajorRankingListViewController *majorRankingListVC = [HUZMajorRankingListViewController new];
//        majorRankingListVC.navTitle = self.dataSource[indexPath.row][@"content"];
//        if (indexPath.item == 0) {
//            majorRankingListVC.navTitle = @"理科专业排行榜";//self.dataSource[indexPath.row][@"content"];
//            majorRankingListVC.grade = 0;
//        }else{
//            majorRankingListVC.navTitle = @"文科专业排行榜";
//            majorRankingListVC.grade = 1;
//        }
//        [self.navigationController pushViewController:majorRankingListVC animated:YES];
    }
    
}

@end

//
//  HUZFriendPostHeaderView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/29.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZFriendPostHeaderView.h"
#import "HUZFriendPostHeaderCell.h"
#import "HUZGkTreasureViewController.h"

@interface HUZFriendPostHeaderView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIImageView *ivDiviceline;

@end

@implementation HUZFriendPostHeaderView

- (void)initView{
    
    self.backgroundColor = COLOR_BG_WHITE;
    [self addSubview:self.collectionView];
    
    self.ivDiviceline = [[UIImageView alloc] initWithFrame:CGRectMake(0, AutoDistance(232), HUZSCREEN_WIDTH, AutoDistance(8))];
    self.ivDiviceline.backgroundColor = ColorS(COLOR_BG_F6F6F6);
    [self addSubview:self.ivDiviceline];
}

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        [flow setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,AutoDistance(48),HUZSCREEN_WIDTH,AutoDistance(180)) collectionViewLayout:flow];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor= COLOR_BG_WHITE;
        [_collectionView dz_registerCell:[HUZFriendPostHeaderCell class]];
    }
    return _collectionView;
}

- (void)setDatas:(NSArray *)datas{
    _datas = datas;
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _datas.count;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return AutoDistance(15);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, AutoDistance(15), 0, AutoDistance(15));
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(AutoDistance(156), AutoDistance(156));
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HUZFriendPostHeaderCell *cell = [HUZFriendPostHeaderCell cellWithCollectionView:collectionView forIndexPath:indexPath];
    [cell reloadData:_datas[indexPath.row]];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HUZGkTreasureViewController *gkTreasureVC = [HUZGkTreasureViewController new];
    gkTreasureVC.model = _datas[indexPath.row];
    [[UIViewController currentViewController].navigationController pushViewController:gkTreasureVC animated:YES];
}


@end

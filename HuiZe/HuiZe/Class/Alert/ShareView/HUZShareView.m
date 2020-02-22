//
//  HUZShareView.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/25.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZShareView.h"
#import "HUZShareCell.h"

@interface HUZShareView (){
    NSMutableArray *_datas;
}

@end

@implementation HUZShareView

- (void)initView{
    
    [self initData];
    
    self.ivAlpha = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT)];
    self.ivAlpha.backgroundColor = ColorS(COLOR_BG_000000);
    self.ivAlpha.alpha = 0.4;
    
    self.ivShare = [[UIView alloc] initWithFrame:CGRectMake(AutoDistance(48), AutoDistance(190), HUZSCREEN_WIDTH-AutoDistance(96), AutoDistance(210))];
    self.ivShare.backgroundColor = COLOR_BG_WHITE;
    ViewRadius(self.ivShare, AutoDistance(8));
    
    [self addSubview:self.ivAlpha];
    [self addSubview:self.ivShare];
    [self.ivShare addSubview:self.collectionView];
    
    [self.ivAlpha addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
    
}

- (void)initData{
    _datas = [NSMutableArray new];
    
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]){
        [_datas addObject:@{@"icon":@"ic_share_qzone",@"platform":QZone,@"name":@"QQ空间"}];
//    }
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        [_datas addObject:@{@"icon":@"ic_share_wxmoment",@"platform":WCMoment,@"name":@"朋友圈"}];
//    }
    
//    [_datas addObject:@{@"icon":@"ic_share_wb",@"platform":WB,@"name":@"微博"}];
    
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]){
        [_datas addObject:@{@"icon":@"ic_share_qq",@"platform":QQ,@"name":@"QQ"}];
//    }
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        [_datas addObject:@{@"icon":@"ic_share_wechat",@"platform":Wechat,@"name":@"微信"}];
//    }

}



- (void)show{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    [self setFrame:CGRectMake(0, 0, HUZSCREEN_WIDTH, HUZSCREEN_HEIGHT)];
    [self animationWithAlertView];
}

- (void)dismiss{
    [self removeFromSuperview];
}

#pragma mark - collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{return 1;}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _datas.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row <= 2) {
//        return CGSizeMake(AutoDistance(44), AutoDistance(66));
//    }else{
        return CGSizeMake(AutoDistance(90), AutoDistance(66));
//    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HUZShareCell *cell = [HUZShareCell cellWithCollectionView:collectionView forIndexPath:indexPath];
    [cell reloadData:_datas[indexPath.row]];
    return cell;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return AutoDistance(16);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return AutoDistance(46);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
   return UIEdgeInsetsMake(AutoDistance(26), AutoDistance(26), AutoDistance(26), AutoDistance(26));
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self dismiss];
    self.block(_datas[indexPath.row][@"platform"]);
}

#pragma mark - Lazy
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0,HUZSCREEN_WIDTH-AutoDistance(96),AutoDistance(210)) collectionViewLayout:flow];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.bounces = NO;
        _collectionView.backgroundColor = COLOR_BG_WHITE;
        [_collectionView dz_registerCell:[HUZShareCell class]];
    }
    return _collectionView;
}

/// 抖动动画
- (void)animationWithAlertView {
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.15;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [self.layer addAnimation:animation forKey:nil];
}


@end

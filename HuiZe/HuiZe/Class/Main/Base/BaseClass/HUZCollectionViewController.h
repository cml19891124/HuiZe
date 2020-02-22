//
//  HUZCollectionViewController.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/22.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZCollectionViewController : HUZViewController
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>
@property (nonatomic,strong) UICollectionView *collectionView;
/// default 50,50
@property(nonatomic,assign) CGSize cellSize;
/// default UIEdgeInsetsMake(10 ,10, 10, 10)
@property(nonatomic,assign) UIEdgeInsets edg;
/// 最小水平间距 default 10
@property(nonatomic,assign) CGFloat minimumInteritemSpacing;
/// 最小竖直间距 default 10
@property(nonatomic,assign) CGFloat minimumLineSpacing;
/// 是否数据是多段   defalut is NO
@property (nonatomic,assign) BOOL shouldMultiSections;
/// 滚动方向 默认竖直滚动
@property(nonatomic,assign) UICollectionViewScrollDirection scrollDirection;
/// 设置滚动方向,子类可以重写
- (void)setScrollDirection;

/// dequeueReusableCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
       dequeueReusableCellWithIdentifier:(NSString *)identifier
                            forIndexPath:(NSIndexPath *)indexPath;
/// configure cell data
- (void)configureCell:(UICollectionViewCell *)cell
          atIndexPath:(NSIndexPath *)indexPath
           withObject:(id)object;

@property (nonatomic,strong) NSMutableArray *dataSource;
@end

NS_ASSUME_NONNULL_END

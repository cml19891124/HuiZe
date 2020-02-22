//
//  HUZHomeFunctionCell.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/18.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZHomeFunctionCell : HUZTableViewCell<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *dataFunction;

@end

NS_ASSUME_NONNULL_END

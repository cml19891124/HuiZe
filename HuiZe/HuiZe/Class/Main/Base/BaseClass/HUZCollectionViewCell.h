//
//  HUZCollectionViewCell.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/17.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HUZCollectionViewCell : UICollectionViewCell
/// 创建UI
- (void)initView;
/// 刷新数据
- (void)reloadData:(id)entity;
/// 刷新数据
- (void)reloadData:(id)entity indexPath:(NSIndexPath *)indexPath;
/// 计算item size
+ (CGSize)calculateSizeWithEntity:(id)entity;
/// 注册
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END

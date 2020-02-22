//
//  HUZCollectionViewCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/17.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZCollectionViewCell.h"

@implementation HUZCollectionViewCell
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"HUZCollectionViewCell";
    HUZCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    return cell;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder: aDecoder];
    if (self) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{}

- (void)reloadData:(id)entity{}

- (void)reloadData:(id)entity indexPath:(NSIndexPath *)indexPath{}

+(CGSize)calculateSizeWithEntity:(id)entity{ return CGSizeZero;}
@end

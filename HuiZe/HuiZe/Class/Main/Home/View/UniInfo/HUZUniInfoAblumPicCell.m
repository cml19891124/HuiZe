//
//  HUZUniInfoAblumPicCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/24.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniInfoAblumPicCell.h"

@implementation HUZUniInfoAblumPicCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"HUZUniInfoAblumPicCell";
    HUZUniInfoAblumPicCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    return cell;
}

- (void)initView{
    
    self.ivPic = [UIImageView new];
    [self.contentView addSubview:self.ivPic];
    ViewRadius(self.ivPic, AutoDistance(4));
    [self.ivPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.contentView);
    }];
}

- (void)reloadData:(id)entity{
    [self.ivPic sd_setImageWithURL:[NSURL URLWithString:entity] placeholderImage:ImageNamed(DEFAULT_IMAGE)];
}

@end

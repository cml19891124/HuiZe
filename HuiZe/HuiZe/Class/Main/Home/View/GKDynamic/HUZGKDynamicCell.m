//
//  HUZGKDynamicCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/26.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZGKDynamicCell.h"

@implementation HUZGKDynamicCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"HUZGKDynamicCell";
    HUZGKDynamicCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    return cell;
}

- (void)initView{
    
    self.ivContent = [UIImageView new];
    
    self.labContent = [[UILabel alloc] initWithTextColor:ColorS(COLOR_ffffff) autoTextFont:FontS(FONT_20)];
    
    [self.contentView addSubview:self.ivContent];
    [self.contentView addSubview:self.labContent];
    
    [self.ivContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.contentView);
    }];
    
    [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
}

- (void)reloadData:(id)entity{
    NSDictionary *dic = (NSDictionary *)entity;
    self.ivContent.image = ImageNamed(dic[@"image"]);
    self.labContent.text = dic[@"name"];
}
@end

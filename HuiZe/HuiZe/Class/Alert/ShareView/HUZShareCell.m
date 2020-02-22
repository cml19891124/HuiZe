//
//  HUZShareCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/25.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZShareCell.h"

@implementation HUZShareCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"HUZShareCell";
    HUZShareCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    return cell;
}

- (void)initView{
    
    self.ivShare = [UIImageView new];
    
    self.labShare = [[UILabel alloc] initWithTextColor:ColorS(COLOR_848484) autoTextFont:FontS(FONT_12) textAlignment:NSTextAlignmentCenter];
    
    [self.contentView addSubview:self.ivShare];
    [self.contentView addSubview:self.labShare];
    
    [self.ivShare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(AutoDistance(44), AutoDistance(44)));
    }];
    
    [self.labShare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.ivShare);
        make.top.equalTo(self.ivShare.mas_bottom).offset(AutoDistance(4));
    }];
}

- (void)reloadData:(id)entity{
    NSDictionary *dic = (NSDictionary *)entity;
    self.ivShare.image = ImageNamed(dic[@"icon"]);
    self.labShare.text = dic[@"name"];
}

@end

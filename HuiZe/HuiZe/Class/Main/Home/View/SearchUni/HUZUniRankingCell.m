//
//  HUZUniRankingCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/24.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZUniRankingCell.h"

@implementation HUZUniRankingCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"HUZUniRankingCell";
    HUZUniRankingCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    return cell;
}

- (void)initView{
    
    self.ivBg = [UIView new];
    self.ivBg.backgroundColor = COLOR_BG_WHITE;
    ViewRadius(self.ivBg, AutoDistance(8));
    
    self.ivLogo = [UIImageView new];
    
    self.labContent = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_12) textAlignment:NSTextAlignmentCenter];
    
    self.labDes = [[UILabel alloc] initWithTextColor:ColorS(COLOR_848484) autoTextFont:FontS(FONT_10) textAlignment:NSTextAlignmentCenter];
    self.labDes.text = @"大学百强榜";
    
    [self.contentView addSubview:self.ivBg];
    [self.contentView addSubview:self.ivLogo];
    [self.contentView addSubview:self.labContent];
    [self.contentView addSubview:self.labDes];
    
    [self.ivBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.contentView);
    }];
    
    [self.ivLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.mas_offset(AutoDistance(24));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(48), AutoDistance(48)));
    }];
    
    [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ivLogo.mas_bottom).offset(AutoDistance(14));
        make.centerX.equalTo(self.contentView);
    }];
    
    [self.labDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labContent.mas_bottom).offset(AutoDistance(4));
        make.centerX.equalTo(self.contentView);
    }];
}

- (void)reloadData:(id)entity{
    NSDictionary *dic = (NSDictionary *)entity;
    self.ivLogo.image = ImageNamed(dic[@"icon"]);
    self.labContent.text = dic[@"content"];
}

@end


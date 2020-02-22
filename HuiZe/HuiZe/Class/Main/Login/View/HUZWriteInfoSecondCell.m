//
//  HUZWriteInfoSecondCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/22.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZWriteInfoSecondCell.h"

@implementation HUZWriteInfoSecondCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"HUZWriteInfoSecondCell";
    HUZWriteInfoSecondCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    return cell;
}

- (void)initView{
    
    self.labProvice = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_17)];
    self.labProvice.text = @"";
    ViewBorderRadius(self.labProvice, 4, 1, ColorS(COLOR_989898));
    self.labProvice.tag = 1;
    self.labProvice.userInteractionEnabled = YES;

    self.ivPullDown1 = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_pull_down")];
    self.ivPullDown1.userInteractionEnabled = NO;
    
    self.labYear = [[UILabel alloc] initWithTextColor:ColorS(COLOR_989898) autoTextFont:FontS(FONT_17)];
    ViewBorderRadius(self.labYear, 4, 1, ColorS(COLOR_989898));
    self.labYear.tag = 2;
    self.labYear.userInteractionEnabled = YES;
    
    self.ivPullDown2 = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_pull_down")];
    self.ivPullDown2.userInteractionEnabled = NO;

    
    [self.contentView addSubview:self.labProvice];
    [self.contentView addSubview:self.ivPullDown1];
    [self.contentView addSubview:self.labYear];
    [self.contentView addSubview:self.ivPullDown2];
    
    
    [self.labProvice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(AutoDistance(145), AutoDistance(38)));
    }];
    
    [self.ivPullDown1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labProvice);
        make.right.equalTo(self.labProvice).offset(-AutoDistance(12));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(26), AutoDistance(24)));
    }];
    
    [self.labYear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.labProvice.mas_right).offset(AutoDistance(26));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(128), AutoDistance(38)));
    }];
    
    [self.ivPullDown2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labYear);
        make.right.equalTo(self.labYear).offset(-AutoDistance(12));
        make.size.mas_equalTo(CGSizeMake(AutoDistance(26), AutoDistance(24)));
    }];
    
    [self.labProvice addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickType:)]];
    [self.labYear addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickType:)]];

}

- (void)clickType:(UIGestureRecognizer *)tap{
    NSInteger tag = tap.view.tag;
    if ( self.delegate && [self.delegate respondsToSelector:@selector(clickInfoType:)]) {
        [self.delegate clickInfoType:tag];
    }
}

- (void)reloadProvice:(NSString *)provice year:(NSString *)year{
    self.labProvice.text = DRStringIsNotEmpty(provice) ? [NSString stringWithFormat:@"   %@",provice] : @"   所在的省份";
    self.labYear.text = DRStringIsNotEmpty(year) ? [NSString stringWithFormat:@"   %@",year] : @"   高考年份";
    self.labProvice.textColor = DRStringIsNotEmpty(provice) ? ColorS(COLOR_2E86FF) : ColorS(COLOR_989898);
    self.labYear.textColor = DRStringIsNotEmpty(year) ? ColorS(COLOR_2E86FF) : ColorS(COLOR_989898);

}

@end


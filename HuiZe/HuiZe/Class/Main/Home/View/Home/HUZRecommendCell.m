//
//  HUZRecommendCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/18.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZRecommendCell.h"
#import "HUZRecommendUniModel.h"

@interface HUZRecommendCell ()
@property (nonatomic,strong) UIView *ivBg;
@property (nonatomic,strong) UIImageView *ivTag;
@property (nonatomic,strong) UIImageView *ivLogo;
@property (nonatomic,strong) UILabel *labCity;
@property (nonatomic,strong) UILabel *labUni;
@end

@implementation HUZRecommendCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"HUZRecommendCell";
    HUZRecommendCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    return cell;
}


- (void)initView{
    
    self.ivBg = [UIView new];
    self.ivBg.backgroundColor = COLOR_BG_WHITE;
    self.ivBg.layer.shadowColor = [UIColor blackColor].CGColor;
    self.ivBg.layer.shadowOffset = CGSizeMake(2,3);// 设置阴影偏移量
    self.ivBg.layer.shadowOpacity = 0.2;// 设置阴影透明度
    self.ivBg.layer.shadowRadius = 4;// 设置阴影半径
    self.ivBg.layer.cornerRadius = 4;
    self.ivBg.clipsToBounds = NO;
    
    self.ivTag = [UIImageView new];
    
    self.ivLogo = [UIImageView new];
    
    self.labCity = [[UILabel alloc] initWithTextColor:ColorS(COLOR_C8C8C8) autoTextFont:FontS(FONT_12) textAlignment:NSTextAlignmentCenter];
    self.labCity.text = @"北京市";
    
    self.labUni = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15) textAlignment:NSTextAlignmentCenter];
    self.labUni.text = @"北京大学";
    
    [self.contentView addSubview:self.ivBg];
    [self.contentView addSubview:self.ivTag];
    [self.contentView addSubview:self.ivLogo];
    [self.contentView addSubview:self.labCity];
    [self.contentView addSubview:self.labUni];
    
    [self.ivBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.contentView);
    }];
    
    [self.ivTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(8);
        make.right.mas_offset(-8);
        make.size.mas_equalTo(CGSizeMake(14, 14));
    }];
    
    [self.ivLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(18);
        make.centerX.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(54, 52));
    }];
    
    [self.labCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ivLogo.mas_bottom).offset(18);
        make.left.mas_offset(2);
        make.right.mas_offset(-2);
    }];
    
    [self.labUni mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labCity.mas_bottom).offset(2);
        make.left.mas_offset(2);
        make.right.mas_offset(-2);
    }];
    
}

- (void)reloadData:(HUZRecommendUniDataModel *)entity indexPath:(nonnull NSIndexPath *)indexPath{
    [self.ivLogo sd_setImageWithURL:[NSURL URLWithString:entity.logoUrl] placeholderImage:ImageNamed(DEFAULT_IMAGE)];
    self.labUni.text = entity.schoolName;
    self.labCity.text = entity.provinceName;
    if (indexPath.row == 0) {
        self.ivTag.image = ImageNamed(@"ic_uni_chong");
    }else if (indexPath.row == 1 || indexPath.row == 2){
        self.ivTag.image = ImageNamed(@"ic_uni_wen");
    }else{
        self.ivTag.image = ImageNamed(@"ic_uni_bao");
    }
}

@end

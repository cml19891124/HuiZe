//
//  HUZFriendPostHeaderCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/29.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZFriendPostHeaderCell.h"
#import "HUZFriendReleaseTypeModel.h"

@interface HUZFriendPostHeaderCell ()

@property (nonatomic,strong) UIImageView *ivContent;
@property (nonatomic,strong) UIView *ivBg;
@property (nonatomic,strong) UILabel *labTitle;
@property (nonatomic,strong) UILabel *labDes;

@end

@implementation HUZFriendPostHeaderCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"HUZFriendPostHeaderCell";
    HUZFriendPostHeaderCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    return cell;
}


- (void)initView{
    
    self.ivContent = [UIImageView new];
    self.ivContent.image = ImageNamed(@"iv_ablum_pic");
    self.ivContent.contentMode = UIViewContentModeScaleAspectFit;
    ViewRadius(self.ivContent, AutoDistance(8));
    
    self.ivBg = [UIView new];
    self.ivBg.backgroundColor = ColorS(COLOR_BG_40424E);
    
    self.labTitle = [[UILabel alloc] initWithTextColor:ColorS(COLOR_ffffff) autoTextFont:FontS(FONT_14)];
    
    self.labDes = [[UILabel alloc] initWithTextColor:ColorS(COLOR_ffffff) autoTextFont:FontS(FONT_10)];
    
    [self.contentView addSubview:self.ivContent];
    [self.ivContent addSubview:self.ivBg];
    [self.ivBg addSubview:self.labTitle];
    [self.ivBg addSubview:self.labDes];
    
    [self.ivContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.contentView);
    }];
    
    [self.ivBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.ivContent);
        make.height.mas_equalTo(AutoDistance(60));
    }];
    
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(12));
        make.left.mas_offset(AutoDistance(14));
        make.right.mas_offset(-AutoDistance(2));
    }];
    
    [self.labDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTitle.mas_bottom).offset(AutoDistance(4));
        make.left.mas_offset(AutoDistance(14));
        make.right.mas_offset(-AutoDistance(2));
    }];
}

- (void)reloadData:(HUZFriendReleaseTypeListModel *)entity{
    [self.ivContent sd_setImageWithURL:[NSURL URLWithString:entity.banner] placeholderImage:ImageNamed(DEFAULT_IMAGE)];
    self.labTitle.text = entity.typeName;
    self.labDes.text = [NSString stringWithFormat:@"帖子%@  热度%@",entity.releaseSum,entity.heat];
}

@end

//
//  HUZGkTreasureHeaderView.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/5.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZGkTreasureHeaderView.h"

@interface HUZGkTreasureHeaderView ()

@property (nonatomic,strong) UIImageView *ivContent;
@property (nonatomic,strong) UIView *ivAlpha;
@property (nonatomic,strong) UILabel *labTitle;
@property (nonatomic,strong) UILabel *labDes;
@property (nonatomic,strong) UILabel *labContent;

@end

@implementation HUZGkTreasureHeaderView

- (void)initView{
    
    self.ivContent = [UIImageView new];
    
    self.ivAlpha = [UIView new];
    self.ivAlpha.backgroundColor = ColorS(COLOR_BG_000000);
    self.ivAlpha.alpha = 0.32;
    
    self.labTitle = [[UILabel alloc] initWithTextColor:ColorS(COLOR_ffffff) autoTextFont:FontS(FONT_18) textAlignment:NSTextAlignmentCenter];
    
    self.labDes = [[UILabel alloc] initWithTextColor:ColorS(COLOR_ffffff) autoTextFont:FontS(FONT_12) textAlignment:NSTextAlignmentCenter];
    self.labDes.alpha = 0.8;
    
    self.labContent = [[UILabel alloc] initWithTextColor:ColorS(COLOR_ffffff) autoTextFont:FontS(FONT_15) textAlignment:NSTextAlignmentCenter];
    
    [self addSubview:self.ivContent];
    [self addSubview:self.ivAlpha];
    [self addSubview:self.labTitle];
    [self addSubview:self.labDes];
    [self addSubview:self.labContent];
    
    [self.ivContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.mas_offset(-AutoDistance(8));
    }];
    
    [self.ivAlpha mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.mas_offset(-AutoDistance(8));
    }];
    
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(83));
        make.centerX.equalTo(self);
    }];
    
    [self.labDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTitle.mas_bottom).offset(AutoDistance(10));
        make.centerX.equalTo(self);
    }];
    
    [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labDes.mas_bottom).offset(AutoDistance(24));
        make.centerX.equalTo(self);
    }];
}

- (void)setModel:(HUZFriendReleaseTypeListModel *)model{
    self.labTitle.text = model.typeName;
    [self.ivContent sd_setImageWithURL:[NSURL URLWithString:model.banner] placeholderImage:ImageNamed(DEFAULT_IMAGE)];
    self.labDes.text = [NSString stringWithFormat:@"%@帖子     %@热度",model.releaseSum,model.heat];
    self.labContent.text = model.headContent;
}

@end

//
//  HUZMajorRecommendCell.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/9.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZMajorRecommendCell.h"
#import "HUZRecommendMajorModel.h"

@interface HUZMajorRecommendCell ()
@property (nonatomic,strong) UIView *ivBg;
@property (nonatomic,strong) UILabel *labTitle;
@property (nonatomic,strong) UILabel *labDes;
@property (nonatomic,strong) UIImageView *ivHot;
@property (nonatomic,strong) UILabel *labNum;
@end

@implementation HUZMajorRecommendCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"HUZMajorRecommendCell";
    HUZMajorRecommendCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
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
    
    self.labTitle = [[UILabel alloc] initWithTextColor:ColorS(COLOR_414141) autoTextFont:FontS(FONT_15) textAlignment:NSTextAlignmentCenter];
//    self.labTitle.text = @"航海技术";
    
    self.labDes = [[UILabel alloc] initWithTextColor:ColorS(COLOR_C8C8C8) autoTextFont:FontS(FONT_12) textAlignment:NSTextAlignmentCenter];
//    self.labDes.text = @"物流运输";
    
    self.ivHot = [[UIImageView alloc] initWithImage:ImageNamed(@"ic_major_hot")];
    
    self.labNum = [[UILabel alloc] initWithTextColor:ColorS(COLOR_2E86FF) autoTextFont:FontS(FONT_17) textAlignment:NSTextAlignmentCenter];
//    self.labNum.text = @"2000人";
    
    [self.contentView addSubview:self.ivBg];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labDes];
    [self.contentView addSubview:self.ivHot];
    [self.contentView addSubview:self.labNum];
    
    [self.ivBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.contentView);
    }];
    
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(AutoDistance(18));
        make.left.mas_offset(AutoDistance(2));
        make.right.mas_offset(-AutoDistance(2));
    }];
    
    [self.labDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTitle.mas_bottom).offset(AutoDistance(4));
        make.left.mas_offset(AutoDistance(2));
        make.right.mas_offset(-AutoDistance(2));
    }];
    
    [self.ivHot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labDes.mas_bottom).offset(AutoDistance(25));
        make.centerX.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(AutoDistance(56), AutoDistance(14)));
    }];
    
    [self.labNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ivHot.mas_bottom).offset(AutoDistance(6));
        make.left.mas_offset(AutoDistance(2));
        make.right.mas_offset(-AutoDistance(2));
    }];
}

- (void)reloadData:(HUZRecommendMajorDataModel *)entity{
    self.labTitle.text = entity.schoolNameTem;
    self.labNum.text = [NSString stringWithFormat:@"%@人",entity.admissionNum];
    self.labDes.text = entity.zhuanyeNameTem;
}

@end

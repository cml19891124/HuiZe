//
//  HUZUniRankingListCell.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/24.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZUniRankingListCell : HUZTableViewCell

@property (nonatomic,strong) UILabel *labRanking;
@property (nonatomic,strong) UIImageView *ivLogo;
@property (nonatomic,strong) UILabel *labSchool;
@property (nonatomic,strong) UILabel *labCity;
@property (nonatomic,strong) UILabel *labDes1;
@property (nonatomic,strong) UILabel *labDes2;
@property (nonatomic,strong) UIImageView *ivDiviceline;

@property (nonatomic, assign) NSInteger type;
@end

NS_ASSUME_NONNULL_END

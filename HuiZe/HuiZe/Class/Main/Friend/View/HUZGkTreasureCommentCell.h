//
//  HUZGkTreasureCommentCell.h
//  HuiZe
//
//  Created by  YIQI on 2019/5/5.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZGkTreasureCommentCell : HUZTableViewCell

@property (nonatomic,strong) UIImageView *ivHeader;
@property (nonatomic,strong) UILabel *labName;
@property (nonatomic,strong) UILabel *labTime;
@property (nonatomic,strong) UILabel *labContent;
@property (nonatomic,strong) UILabel *labType;
@property (nonatomic,strong) UIButton *btnLike;
@property (nonatomic,strong) UILabel *labLike;
@property (nonatomic,strong) UIButton *btnComment;
@property (nonatomic,strong) UILabel *labComment;
@property (nonatomic,strong) UIImageView *ivDiviceline;

@end

NS_ASSUME_NONNULL_END

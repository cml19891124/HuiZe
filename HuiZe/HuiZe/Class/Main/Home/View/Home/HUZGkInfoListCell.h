//
//  HUZGkInfoListCell.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/19.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZGkInfoListCell : HUZTableViewCell

@property (nonatomic,strong) UILabel *labTitle;
@property (nonatomic,strong) UILabel *labDes;
@property (nonatomic,strong) UIImageView *ivContent;

@property (nonatomic, strong) UIView * topView;

@end

NS_ASSUME_NONNULL_END

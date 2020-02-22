//
//  HUZUniPriorityFillCell.h
//  HuiZe
//
//  Created by mac on 2019/4/27.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZUniPriorityFillCell : HUZTableViewCell
@property (nonatomic,strong) UIImageView *ivLogo;
@property (nonatomic,strong) UILabel *labTitle;
@property (nonatomic,strong) UILabel *labSubTitle;
@property (nonatomic,strong) UILabel *labDetailTitle;
@property (nonatomic,strong) NSMutableDictionary *dic;
@end

NS_ASSUME_NONNULL_END

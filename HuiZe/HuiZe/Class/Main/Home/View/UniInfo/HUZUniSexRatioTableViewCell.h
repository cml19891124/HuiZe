//
//  HUZUniSexRatioTableViewCell.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/24.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZTableViewCell.h"
#import "ZYLineProgressView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZUniSexRatioTableViewCell : HUZTableViewCell
@property (nonatomic,strong) UIView *ivBg;
@property (nonatomic,strong) UIImageView *ivMale;
@property (nonatomic,strong) UIImageView *ivFemale;
@property (nonatomic,strong) ZYLineProgressView *lineProgressView;
@property (nonatomic,strong) UILabel *labMale;
@property (nonatomic,strong) UILabel *labFemale;

@property (nonatomic,strong) HUZUniInfoGeneralizeDataModel *uniInfoModel;  /// 大学信息对象


@end

NS_ASSUME_NONNULL_END

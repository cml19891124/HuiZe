//
//  HUZUniGradutionDesSectionView.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/25.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZView.h"
#import "HUZIndustyLeaModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZUniGradutionDesSectionView : HUZView

@property (nonatomic,strong) UILabel *labTitle;
@property (nonatomic,strong) UILabel *labDes1;
@property (nonatomic,strong) TTTAttributedLabel *labDes2;

@property (nonatomic,strong) HUZIndustyLeaModel *model;

@end

NS_ASSUME_NONNULL_END

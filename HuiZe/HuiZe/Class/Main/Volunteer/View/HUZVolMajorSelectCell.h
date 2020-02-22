//
//  HUZVolMajorSelectCell.h
//  HuiZe
//
//  Created by mac on 2019/4/28.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZTableViewCell.h"
@class HUZVoluntaryListModel;
NS_ASSUME_NONNULL_BEGIN

typedef void(^AddMajor)(BOOL isSelected);
@interface HUZVolMajorSelectCell : HUZTableViewCell
@property (nonatomic,strong) UILabel *labMajor;
@property (nonatomic,strong) UILabel *labDes1;
@property (nonatomic,strong) UILabel *labDes2;
@property (nonatomic,strong) UILabel *labDes3;
@property (nonatomic,strong) UIImageView *ivDiviceline;
@property (nonatomic,strong) UIButton *btnAdd;
@property (nonatomic,copy) AddMajor addMajor;

@property (nonatomic,strong) HUZVoluntaryListModel *model;

@end

NS_ASSUME_NONNULL_END

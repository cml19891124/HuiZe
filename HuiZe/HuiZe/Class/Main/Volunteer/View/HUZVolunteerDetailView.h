//
//  HUZVolunteerDetailView.h
//  HuiZe
//
//  Created by mac on 2019/4/29.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZView.h"

NS_ASSUME_NONNULL_BEGIN
@class HUZIntelligenceDetailDataModel;
typedef void(^DetailBlock)(void);
@interface HUZVolunteerDetailView : HUZView
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *labTip;
@property (nonatomic,strong) UILabel *labTitle;
@property (nonatomic,strong) UILabel *labName;
@property (nonatomic,strong) UILabel *labDate;
@property (nonatomic,copy) DetailBlock detailBlock;
@property (nonatomic, strong) HUZIntelligenceDetailDataModel * dataModel;
@end

NS_ASSUME_NONNULL_END

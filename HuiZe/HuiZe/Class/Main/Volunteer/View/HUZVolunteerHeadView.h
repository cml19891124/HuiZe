//
//  HUZVolunteerHeadView.h
//  HuiZe
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZView.h"
#import "HUZTwoLabelSwipeView.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^ReportBlock)(void);

@interface HUZVolunteerHeadView : HUZView

@property (nonatomic,strong) UIButton *btnCheck;
@property (nonatomic,strong) HUZTwoLabelSwipeView *leftView;
@property (nonatomic,strong) HUZTwoLabelSwipeView *rightView;
@property (nonatomic,copy) ReportBlock reportBlock;
@end

NS_ASSUME_NONNULL_END

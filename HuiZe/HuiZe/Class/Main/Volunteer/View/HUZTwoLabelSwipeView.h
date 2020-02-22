//
//  HUZTwoLabelSwipeView.h
//  HuiZe
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZView.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^TapClick)(void);
@interface HUZTwoLabelSwipeView : HUZView
@property (nonatomic,strong) TTTAttributedLabel *labTop;
@property (nonatomic,strong) UILabel *labBtom;
@property (nonatomic,copy) TapClick tapClick;
@end

NS_ASSUME_NONNULL_END

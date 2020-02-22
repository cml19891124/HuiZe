//
//  HUZThirdLoginView.h
//  HuiZe
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZThirdLoginView : HUZView <TTTAttributedLabelDelegate>
@property (nonatomic,strong) UIButton *btnQQ;
@property (nonatomic,strong) UIButton *btnWechat;
@property (nonatomic,strong) UIButton *btnWb;
@property (nonatomic,strong) TTTAttributedLabel *aLable; // 用户服务

@end

NS_ASSUME_NONNULL_END

//
//  HUZMySetPassHeaderView.h
//  HuiZe
//
//  Created by mac on 2019/5/14.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZView.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^PassBlock)(NSString *code);
@interface HUZMySetPassHeaderView : HUZView<UITextFieldDelegate>
@property (nonatomic,strong) ACFloatingTextField *tfPass;
@property (nonatomic,strong) UIButton *btnEye;
@property (nonatomic,strong) UIButton *btnNext;
@property (nonatomic,copy) PassBlock passBlock;

@end

NS_ASSUME_NONNULL_END

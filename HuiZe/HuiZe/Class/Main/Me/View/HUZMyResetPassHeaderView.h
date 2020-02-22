//
//  HUZMyResetPassHeaderView.h
//  HuiZe
//
//  Created by mac on 2019/5/14.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^PasswordBlock)(NSString *oldPass, NSString *newPass);
@interface HUZMyResetPassHeaderView : HUZView<UITextFieldDelegate>
@property (nonatomic,strong) ACFloatingTextField *tfOldPass;
@property (nonatomic,strong) ACFloatingTextField *tfNewPass;
@property (nonatomic,strong) UIButton *btnOldEye;
@property (nonatomic,strong) UIButton *btnNewEye;
@property (nonatomic,strong) UIButton *btnNext;
@property (nonatomic,strong) UIButton *btnForget;
@property (nonatomic,copy) PasswordBlock passBlock;

@end

NS_ASSUME_NONNULL_END

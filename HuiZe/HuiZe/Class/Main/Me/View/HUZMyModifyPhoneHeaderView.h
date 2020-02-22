//
//  HUZMyModifyPhoneHeaderView.h
//  HuiZe
//
//  Created by mac on 2019/5/6.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CodeBlock)(NSString *phone);
typedef void(^LoginBlock)(NSString *phone, NSString *code);
@interface HUZMyModifyPhoneHeaderView : HUZView<UITextFieldDelegate>
@property (nonatomic,strong) ACFloatingTextField *tfPhone;
@property (nonatomic,strong) ACFloatingTextField *tfSms;
@property (nonatomic,strong) UIButton *btnCode;
@property (nonatomic,strong) UIButton *btnNext;
@property (nonatomic,strong) Calculagraph *codeTimer;
@property (nonatomic,copy) CodeBlock codeBlock;
@property (nonatomic,copy) LoginBlock loginBlock;
@end

NS_ASSUME_NONNULL_END

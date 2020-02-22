//
//  HUZCodeLoginView.h
//  HuiZe
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CodeBlock)(NSString *phone);
typedef void(^LoginBlock)(NSString *phone, NSString *code);

@interface HUZCodeLoginView : HUZView<UITextFieldDelegate>
@property (nonatomic,strong) UILabel *labWel;
@property (nonatomic,strong) ACFloatingTextField *tfPhone;
@property (nonatomic,strong) ACFloatingTextField *tfPsd;
@property (nonatomic,strong) UIButton *btnCode;
@property (nonatomic,strong) UIButton *btnSmsLogin;
@property (nonatomic,strong) UIButton *btnForget;
@property (nonatomic,strong) UIButton *btnLogin;
@property (nonatomic,strong) Calculagraph *codeTimer;

@property (nonatomic,copy) CodeBlock codeBlock;
@property (nonatomic,copy) LoginBlock loginBlock;

@end

NS_ASSUME_NONNULL_END

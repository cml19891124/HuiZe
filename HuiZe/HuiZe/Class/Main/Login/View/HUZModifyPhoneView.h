//
//  HUZModifyPhoneView.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/20.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CodeBlock)(NSString *phone);
typedef void(^LoginBlock)(NSString *phone, NSString *code);
@interface HUZModifyPhoneView : HUZView<UITextFieldDelegate>

@property (nonatomic,strong) UIButton *btnBack;
@property (nonatomic,strong) UILabel *labTip;
@property (nonatomic,strong) ACFloatingTextField *tfPhone;
@property (nonatomic,strong) ACFloatingTextField *tfSms;
@property (nonatomic,strong) UIButton *btnCode;
@property (nonatomic,strong) UIButton *btnNext;
@property (nonatomic,strong) Calculagraph *codeTimer;

@property (nonatomic,copy) CodeBlock codeBlock;
@property (nonatomic,copy) LoginBlock loginBlock;
@end

NS_ASSUME_NONNULL_END

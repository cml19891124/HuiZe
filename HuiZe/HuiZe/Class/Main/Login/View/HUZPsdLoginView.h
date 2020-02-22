//
//  HUZPsdLoginView.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/20.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^LoginBlock)(NSString *phone, NSString *password);
@interface HUZPsdLoginView : HUZView<UITextFieldDelegate>
@property (nonatomic,strong) UIImageView *ivBg;
@property (nonatomic,strong) UIButton *btnBack;
@property (nonatomic,strong) ACFloatingTextField *tfPhone;
@property (nonatomic,strong) ACFloatingTextField *tfPsd;
@property (nonatomic,strong) UIButton *btnEye;
@property (nonatomic,strong) UIButton *btnSmsLogin;
@property (nonatomic,strong) UIButton *btnForget;
@property (nonatomic,strong) UIButton *btnLogin;

@property (nonatomic,copy) LoginBlock loginBlock;

@end

NS_ASSUME_NONNULL_END

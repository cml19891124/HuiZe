//
//  HUZForgetPsdView.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/20.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CompleteBlock)(NSString *password);
@interface HUZForgetPsdView : HUZView<UITextFieldDelegate>
@property (nonatomic,strong) UIButton *btnBack;
@property (nonatomic,strong) UIButton *btnEye;
@property (nonatomic,strong) UILabel *labTip;
@property (nonatomic,strong) ACFloatingTextField *tfPsd;
@property (nonatomic,strong) UIButton *btnComplete;

@property (nonatomic,copy) CompleteBlock completeBlock;

@end

NS_ASSUME_NONNULL_END

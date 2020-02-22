//
//  HUZInputView.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/22.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZInputView : HUZView

@property (nonatomic,strong) UILabel *labTitle;
@property (nonatomic,strong) UITextField *tfInput;
@property (nonatomic,strong) UIButton *btnCancel;
@property (nonatomic,strong) UIButton *btnConfirm;

@end

NS_ASSUME_NONNULL_END

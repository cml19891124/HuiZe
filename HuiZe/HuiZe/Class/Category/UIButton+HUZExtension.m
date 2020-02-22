//
//  UIButton+HUZExtension.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/17.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "UIButton+HUZExtension.h"
#import "UIImage+HUZExtension.h"

#undef    NAV_BUTTON_MIN_WIDTH
#define   NAV_BUTTON_MIN_WIDTH    (40.0f)

#undef    NAV_BUTTON_MIN_HEIGHT
#define   NAV_BUTTON_MIN_HEIGHT    (40.0f)

#undef    NAV_BAR_HEIGHT
#define   NAV_BAR_HEIGHT    (44.0f)

@implementation UIButton (HUZExtension)

-(UIButton *)initNavigationButton:(UIImage *)image{
    CGRect buttonFrame = CGRectZero;
    
    buttonFrame = CGRectMake(0, 0, image.size.width, NAV_BAR_HEIGHT);
    
    if ( buttonFrame.size.width >= NAV_BUTTON_MIN_WIDTH )
    {
        buttonFrame.size.width = NAV_BUTTON_MIN_WIDTH;
    }
    
    if ( buttonFrame.size.height >= NAV_BUTTON_MIN_HEIGHT )
    {
        buttonFrame.size.height = NAV_BUTTON_MIN_HEIGHT;
    }
    
    self = [self initWithFrame:buttonFrame];
    self.contentMode = UIViewContentModeScaleAspectFit;
    self.backgroundColor = [UIColor clearColor];
    self.contentEdgeInsets = UIEdgeInsetsMake(0, -12, 0, 0);// 图片和字体靠近一点，根据实际情况调整
    [self setImage:image forState:UIControlStateNormal];
    return self;
}

-(UIButton *)initNavigationButtonWithTitle:(NSString *)title textColor:(UIColor *)textColor{
    CGRect buttonFrame = CGRectZero;
    
    CGSize titleSize = [title boundingRectWithSize:CGSizeMake(999999.0f, NAV_BAR_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16]} context:nil].size;
    
    buttonFrame = CGRectMake(0, 0, titleSize.width, NAV_BAR_HEIGHT);
    
    self = [self initWithFrame:buttonFrame];
    self.contentMode = UIViewContentModeScaleAspectFit;
    self.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [self setTitleColor:textColor forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateNormal];
    return self;
}


-(UIButton *)initWithImage:(UIImage *)imgae{
    self = [super init];
    if (self) {
        [self setImage:imgae forState:UIControlStateNormal];
    }
    return self;
}

-(UIButton *)initWithTitle:(NSString *)title textColor:(UIColor *)textColor autoTextFont:(nonnull UIFont *)textfont{
    self = [super init];
    if (self) {
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:textColor forState:UIControlStateNormal];
        self.titleLabel.font = textfont;
    }
    return self;
}

-(UIButton *)initWithImageNormal:(NSString *)imgaenormal imageSeleted:(NSString *)imageSeleted{
    self = [super init];
    if (self) {
        [self setImage:[UIImage imageNamed:imgaenormal] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:imageSeleted] forState:UIControlStateSelected];
    }
    return self;
}
-(UIButton *)initWithImageNormal:(NSString *)imgaenormal imageHighlight:(NSString *)imageHighlight{
    UIButton * btn = [self initWithImage:[UIImage imageNamed:imgaenormal]];
    [btn setImage:[UIImage imageNamed:imageHighlight] forState:UIControlStateHighlighted];
    return btn;
}

-(UIButton *)initWithNormalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor{
    self = [super init];
    if (self) {
        [self jk_setBackgroundColor:selectColor forState:UIControlStateNormal];
        [self jk_setBackgroundColor:selectColor forState:UIControlStateHighlighted];
        [self jk_setBackgroundColor:normalColor forState:UIControlStateDisabled];

    }
    return self;
}


/**
 *  @brief  使用颜色设置按钮背景
 *
 *  @param backgroundColor 背景颜色
 *  @param state           按钮状态
 */
- (void)dr_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    [self setBackgroundImage:[UIImage dr_b_imageWithColor:backgroundColor] forState:state];
}

- (UIButton *)LeftImageRightTitleWithSpace:(CGFloat)space {
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0, -space, 0.0, 0.0);
    return self;
}

- (UIButton *)LeftTitleRightImageWithSpace:(CGFloat)space {
    CGSize imageSize = self.imageView.frame.size;
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, 0.0, imageSize.width + space);
    CGSize titleSize = self.titleLabel.frame.size;
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0, titleSize.width + space, 0.0, - titleSize.width);
    return self;
}

@end

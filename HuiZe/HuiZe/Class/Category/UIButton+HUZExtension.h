//
//  UIButton+HUZExtension.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/17.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (HUZExtension)

-(UIButton *)initNavigationButton:(UIImage *)image;
-(UIButton *)initNavigationButtonWithTitle:(NSString *)title textColor:(UIColor *)textColor;

-(UIButton *)initWithImage:(UIImage *)imgae;
-(UIButton *)initWithTitle:(NSString *)title textColor:(UIColor *)textColor autoTextFont:(UIFont *)textfont;
-(UIButton *)initWithImageNormal:(NSString *)imgaenormal imageSeleted:(NSString *)imageSeleted;
-(UIButton *)initWithImageNormal:(NSString *)imgaenormal imageHighlight:(NSString *)imageHighlight;

-(UIButton *)initWithNormalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor;

- (UIButton *)LeftImageRightTitleWithSpace:(CGFloat)space;
- (UIButton *)LeftTitleRightImageWithSpace:(CGFloat)space;

@end

NS_ASSUME_NONNULL_END

//
//  UILabel+HUZExtension.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/17.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (HUZExtension)
- (UILabel *)initWithTextColor:(UIColor *)color TextFont:(CGFloat)font;
- (UILabel *)initWithTextColor:(UIColor *)color TextFont:(CGFloat)font Text:(NSString *)text;
- (UILabel *)initWithTextColor:(UIColor *)color TextFont:(CGFloat)font Text:(NSString *)text numberOfLines:(NSInteger)numberOfLines;
- (UILabel *)initWithTextColor:(UIColor *)color TextFont:(CGFloat)font Text:(NSString *)text textAlignment:(NSTextAlignment)textAlignment;

/// 字体适配
- (UILabel *)initWithTextColor:(UIColor *)color autoTextFont:(UIFont *)font;
- (UILabel *)initWithTextColor:(UIColor *)color autoTextFont:(UIFont *)font numberOfLines:(NSInteger)numberOfLines;
- (UILabel *)initWithTextColor:(UIColor *)color autoTextFont:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment;

- (UILabel *)initWithTextColor:(UIColor *)color autoTextFont:(UIFont *)font frame:(CGRect)frame;
- (UILabel *)initWithTextColor:(UIColor *)color autoTextFont:(UIFont *)font numberOfLines:(NSInteger)numberOfLines frame:(CGRect)frame;
- (UILabel *)initWithTextColor:(UIColor *)color autoTextFont:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment frame:(CGRect)frame;


/**
 设置UILabel不同字体或者颜色,label前半部分特殊处理
 
 @param string 需要处理的string
 @param font   设置特殊字体
 @param color  设置特殊颜色
 @param space  隔断的符号
 */
- (void)addAttributestring:(NSString *)string font:(UIFont *)font color:(UIColor *)color space:(NSString *)space;


/**
 设置UILabel不同字体或者颜色,range部分特殊处理
 
 @param string 需要处理的string
 @param font 设置特殊字体
 @param color 设置特殊颜色
 @param range 特殊处理的range
 */
- (void)addAttributestring:(NSString *)string font:(UIFont *)font color:(UIColor *)color range:(NSRange)range;


//改变行间距和字间距
- (void)changeSpacewithLineSpace:(float)lineSpace WordSpace:(float)wordSpace;
@end

NS_ASSUME_NONNULL_END

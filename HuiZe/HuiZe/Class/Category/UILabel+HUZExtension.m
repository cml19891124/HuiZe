//
//  UILabel+HUZExtension.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/17.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "UILabel+HUZExtension.h"

@implementation UILabel (HUZExtension)
- (UILabel *)initWithTextColor:(UIColor *)color TextFont:(CGFloat)font{
    self = [super init];
    if (self) {
        [self setTextColor:color];
        [self setFont:[UIFont systemFontOfSize:font]];
    }
    return self;
}

- (UILabel *)initWithTextColor:(UIColor *)color TextFont:(CGFloat)font Text:(NSString *)text{
    UILabel * lab = [[UILabel alloc] initWithTextColor:color TextFont:font];
    lab.text = text;
    return lab;
}

- (UILabel *)initWithTextColor:(UIColor *)color TextFont:(CGFloat)font Text:(NSString *)text numberOfLines:(NSInteger)numberOfLines{
    UILabel * lab = [[UILabel alloc] initWithTextColor:color TextFont:font Text:text];
    lab.numberOfLines = numberOfLines;
    return lab;
}

- (UILabel *)initWithTextColor:(UIColor *)color TextFont:(CGFloat)font Text:(NSString *)text textAlignment:(NSTextAlignment)textAlignment{
    UILabel * lab = [[UILabel alloc] initWithTextColor:color TextFont:font Text:text];
    lab.textAlignment = textAlignment;
    return lab;
}

- (UILabel *)initWithTextColor:(UIColor *)color autoTextFont:(UIFont *)font{
    self = [super init];
    if (self) {
        [self setTextColor:color];
        [self setFont:font];
    }
    return self;
}

- (UILabel *)initWithTextColor:(UIColor *)color autoTextFont:(UIFont *)font numberOfLines:(NSInteger)numberOfLines{
    self = [super init];
    if (self) {
        [self setTextColor:color];
        [self setFont:font];
        self.numberOfLines = numberOfLines;
    }
    return self;
}

- (UILabel *)initWithTextColor:(UIColor *)color autoTextFont:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment{
    self = [super init];
    if (self) {
        [self setTextColor:color];
        [self setFont:font];
        self.textAlignment = textAlignment;
    }
    return self;
}

- (UILabel *)initWithTextColor:(UIColor *)color autoTextFont:(UIFont *)font frame:(CGRect)frame {
    self = [super init];
    if (self) {
        [self setTextColor:color];
        [self setFont:font];
        self.frame = frame;
    }
    return self;
}
- (UILabel *)initWithTextColor:(UIColor *)color autoTextFont:(UIFont *)font numberOfLines:(NSInteger)numberOfLines frame:(CGRect)frame {
    self = [super init];
    if (self) {
        [self setTextColor:color];
        [self setFont:font];
        self.numberOfLines = numberOfLines;
        self.frame = frame;
    }
    return self;
}

- (UILabel *)initWithTextColor:(UIColor *)color autoTextFont:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment frame:(CGRect)frame {
    self = [super init];
    if (self) {
        [self setTextColor:color];
        [self setFont:font];
        self.textAlignment = textAlignment;
        self.frame = frame;
    }
    return self;
}

/**
 设置UILabel不同字体或者颜色  处理前半部分
 
 @param string 需要处理的string
 @param font   设置特殊字体
 @param color  设置特殊颜色
 @param space  隔断的符号
 */
- (void)addAttributestring:(NSString *)string font:(UIFont *)font color:(UIColor *)color space:(NSString *)space{
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:string];
    NSInteger length = [[attributeStr string] rangeOfString:space].location;
    NSRange range = NSMakeRange(0, length + 1);
    if (font != nil) {
        [attributeStr addAttribute:NSFontAttributeName value:font range:range];
    }
    if (color != nil) {
        [attributeStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    [self setAttributedText:attributeStr];
}

/**
 设置UILabel不同字体或者颜色,range部分特殊处理
 
 @param string 需要处理的string
 @param font 设置特殊字体
 @param color 设置特殊颜色
 @param range 特殊处理的range
 */
- (void)addAttributestring:(NSString *)string font:(UIFont *)font color:(UIColor *)color range:(NSRange)range{
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:string];
    if (font != nil) {
        [attributeStr addAttribute:NSFontAttributeName value:font range:range];
    }
    if (color != nil) {
        [attributeStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    [self setAttributedText:attributeStr];
}

- (void)changeSpacewithLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
    [self sizeToFit];
    
}

@end

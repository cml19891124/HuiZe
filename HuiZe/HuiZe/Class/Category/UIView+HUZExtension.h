//
//  UIView+HUZExtension.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/22.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ActionBlock)(id sender);
@interface UIView (HUZExtension)
-(void)addTapAction:(ActionBlock)action;
/// 设置view 左上角和右上角圆角
+ (void)huz_bezierPathWithRoundedRect:(UIView *)rectView;

/// 设置view 左下角和右下角圆角
+ (void)huzBezierPathWithBottomRoundedRect:(UIView *)rectView;

/// 设置阴影
- (void)huz_shadowColor:(UIColor *)shadowColor shadowOffset:(CGSize)shadowOffset shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius cornerRadius:(CGFloat)cornerRadius;

+ (instancetype)viewFromXib;
@end

NS_ASSUME_NONNULL_END

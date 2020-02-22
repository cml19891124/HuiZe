//
//  UIView+HUZExtension.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/22.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "UIView+HUZExtension.h"

@interface UIView()
@property (nonatomic, copy) ActionBlock action;

@end

@implementation UIView (HUZExtension)

static void *actionKey = &actionKey;

-(void)setAction:(ActionBlock)action{
    objc_setAssociatedObject(self, &actionKey, action, OBJC_ASSOCIATION_COPY);
}

-(ActionBlock)action{
    return objc_getAssociatedObject(self, &actionKey);
}

-(void)addTapAction:(ActionBlock)action{
    self.userInteractionEnabled = YES;
    self.action = action;
    UITapGestureRecognizer * g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action_tapGestureRecognizer:)];
    [self addGestureRecognizer:g];
}

-(void)action_tapGestureRecognizer:(id)sender{
    if (self.action) {
        self.action(sender);
    }
}


+ (void)huz_bezierPathWithRoundedRect:(UIView *)rectView{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rectView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(AutoDistance(12), AutoDistance(12))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = rectView.bounds;
    maskLayer.path = path.CGPath;
    rectView.layer.mask = maskLayer;
}

+ (void)huzBezierPathWithBottomRoundedRect:(UIView *)rectView{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rectView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(AutoDistance(12), AutoDistance(12))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = rectView.bounds;
    maskLayer.path = path.CGPath;
    rectView.layer.mask = maskLayer;
}

- (void)huz_shadowColor:(UIColor *)shadowColor shadowOffset:(CGSize)shadowOffset shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius cornerRadius:(CGFloat)cornerRadius{
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOffset = shadowOffset;// 设置阴影偏移量
    self.layer.shadowOpacity = shadowOpacity;// 设置阴影透明度
    self.layer.shadowRadius = shadowRadius ;// 设置阴影半径'
    self.layer.cornerRadius = cornerRadius;
//    self.clipsToBounds = NO;
}
+ (instancetype)viewFromXib
{
    
    NSString *str = NSStringFromClass(self);
    NSArray *arr = [str componentsSeparatedByString:@"."];
    if (arr.count > 1) {
        str = arr.lastObject;
    }
    return [[[NSBundle mainBundle] loadNibNamed:str owner:nil options:nil] lastObject];
}
@end
